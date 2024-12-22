#include "mainwindow.h"
#include "./ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    QString hostname = "localhost";
    int port = 5432;
    QString dbname = "beauty-salon";
    QString username = "postgres";
    QString password = "89274800234Nn";
    db_manager_.UpdateConnection(hostname, port, dbname, username, password);
    db_manager_.Open();
    ui->stackedWidget->setCurrentWidget(ui->login);
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::UpdateUser(const UserInfo& user, QWidget* parent){
    user_ = std::make_unique<User>(user, parent);
}

void MainWindow::on_pushButton_login_clicked() {
    auto queryResult = db_manager_.ExecuteSelectQuery(QString("SELECT * FROM public.admins WHERE email = '%1';").arg(ui->lineEdit_login->text()));

    if (queryResult.canConvert<QSqlQuery>()) {
            QSqlQuery query = queryResult.value<QSqlQuery>();
            if (query.next()) {
                UserInfo user;
                user.id_ = query.value("id").toInt();
                user.full_name_ = query.value("full_name").toString();
                user.email_ = query.value("email").toString();
                user.password_ = query.value("password").toString();
                user.role_ = StringToRole(query.value("role").toString());
                if (user.password_ == ui->lineEdit_password->text()) {
                    ui->lineEdit_login->clear();
                    ui->lineEdit_password->clear();
                    QMessageBox::information(this, "Информация", "Выполнена авторизация как администратор.");
                    UpdateUser(user, this);

                    table_ = std::make_unique<Table>(&db_manager_, user, nullptr);
                    connect(table_.get(), &Table::Logout, this, &MainWindow::on_logout_clicked);
                    ui->stackedWidget->addWidget(table_.get());
                    ui->stackedWidget->setCurrentWidget(table_.get());
                }
                else{
                    QMessageBox::critical(this, "Ошибка", "Неверный логин или пароль.");
                }
            }
            else {
                auto queryResult = db_manager_.ExecuteSelectQuery(QString("SELECT * FROM public.clients WHERE email = '%1';").arg(ui->lineEdit_login->text()));

                if (queryResult.canConvert<QSqlQuery>()) {
                    QSqlQuery query = queryResult.value<QSqlQuery>();
                    if (query.next()) {
                        UserInfo user;
                        user.id_ = query.value("id").toInt();
                        user.full_name_ = query.value("name").toString();
                        user.email_ = query.value("email").toString();
                        user.password_ = query.value("password").toString();
                        user.role_ = Role::User;

                        if (user.password_ == ui->lineEdit_password->text()) {
                            ui->lineEdit_login->clear();
                            ui->lineEdit_password->clear();
                            QMessageBox::information(this, "Информация", "Выполнена авторизация как пользователь.");
                            UpdateUser(user, this);

                            table_ = std::make_unique<Table>(&db_manager_, user, nullptr);
                            connect(table_.get(), &Table::Logout, this, &MainWindow::on_logout_clicked);
                            ui->stackedWidget->addWidget(table_.get());
                            ui->stackedWidget->setCurrentWidget(table_.get());
                        }
                        else{
                            QMessageBox::critical(this, "Ошибка", "Неверный логин или пароль.");
                        }
                    }
                    else {
                        QMessageBox::critical(this, "Ошибка", "Пользователя с таким логином не существует.");
                    }
                }
                else {
                    QMessageBox::critical(this, "Ошибка в базе данных", queryResult.toString());
                }
            }
        }
    else {
        QMessageBox::critical(this, "Ошибка в базе данных", queryResult.toString());
    }
}

void MainWindow::on_logout_clicked() {
    if (!this->ui->stackedWidget) {
        return;
    }
    user_.reset();
    this->ui->stackedWidget->setCurrentWidget(this->ui->login);
}

void MainWindow::on_pushButton_authorization_clicked()
{
    if (ui->stackedWidget->currentWidget() == ui->login || ui->stackedWidget->currentWidget() == table_.get()) {
        QMessageBox::information(this, "Информация", "Текущая страница — главная.");
    }
    else{
        if (user_->GetRole() == Role::User){
            ui->stackedWidget->setCurrentWidget(table_.get());
        }
    }
}

void MainWindow::on_pushButton_masters_clicked()
{
    if (user_.get()){
        if (user_->GetRole() == Role::User){
            ShowMasters();
            ui->stackedWidget->setCurrentWidget(ui->masters);

            return;
        }
    }
    QMessageBox::warning(this, "Ошибка", "Чтобы переключаться по остальным разделам, необходимо авторизоваться как пользователь.");
}

void MainWindow::on_pushButton_services_clicked()
{
    if (user_.get()){
        if (user_->GetRole() == Role::User){
            ShowServices();
            ui->stackedWidget->setCurrentWidget(ui->services);
            return;
        }
    }
    QMessageBox::warning(this, "Ошибка", "Чтобы переключаться по остальным разделам, необходимо авторизоваться как пользователь.");
}

QList<QPair<int, QString>> MainWindow::FetchMasters() {
    QList<QPair<int, QString>> masters;
    QSqlQuery query("SELECT id, name FROM public.masters");
    while (query.next()) {
        int id = query.value(0).toInt();
        QString name = query.value(1).toString();
        masters.append(qMakePair(id, name));
    }
    return masters;
}

QList<QPair<int, QString>> MainWindow::FetchServices() {
    QList<QPair<int, QString>> services;
    QSqlQuery query("SELECT id, name FROM public.services");
    while (query.next()) {
        int id = query.value(0).toInt();
        QString name = query.value(1).toString();
        services.append(qMakePair(id, name));
    }
    return services;
}

void MainWindow::ShowMasters() {
    QVBoxLayout* layout = new QVBoxLayout(ui->masters);

    QLabel* titleLabel = new QLabel("Доступные мастера");
    titleLabel->setStyleSheet("font-size: 18px; font-weight: bold;");
    layout->addWidget(titleLabel);

    // Создаем область прокрутки
    QScrollArea* scrollArea = new QScrollArea(this);
    scrollArea->setWidgetResizable(true);
    QWidget* container = new QWidget(scrollArea);
    QVBoxLayout* containerLayout = new QVBoxLayout(container);

    // Загружаем мастеров из базы
    QList<QPair<int, QString>> masters = FetchMasters();

    // Загружаем услуги
    QList<QPair<int, QString>> services = FetchServices();

    // Создаем карточки для каждого мастера
    for (const auto& master : masters) {
        QGroupBox* masterCard = new QGroupBox(master.second, this);
        QVBoxLayout* cardLayout = new QVBoxLayout(masterCard);

        // Добавляем виджет календаря для выбора даты
        QCalendarWidget* calendarWidget = new QCalendarWidget(this);
        calendarWidget->setGridVisible(true);
        cardLayout->addWidget(new QLabel("Выберите дату:", this));
        cardLayout->addWidget(calendarWidget);

        // Добавляем выпадающий список для выбора времени
        QComboBox* timeComboBox = new QComboBox(this);
        QStringList timeSlots = {"10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00"};
        timeComboBox->addItems(timeSlots);
        cardLayout->addWidget(new QLabel("Выберите время:", this));
        cardLayout->addWidget(timeComboBox);

        // Создание ComboBox для выбора услуги
        QComboBox* serviceComboBox = new QComboBox(this);
        for (const auto& service : services) {
            serviceComboBox->addItem(service.second, service.first);
        }
        cardLayout->addWidget(new QLabel("Выберите услугу:", this));
        cardLayout->addWidget(serviceComboBox);

        // Кнопка записи
        QPushButton* bookButton = new QPushButton("Записаться", this);
        connect(bookButton, &QPushButton::clicked, [this, master, serviceComboBox, calendarWidget, timeComboBox]() {
            QString selectedDate = calendarWidget->selectedDate().toString("yyyy-MM-dd");
            QString selectedTime = timeComboBox->currentText();
            QString appointmentDateTime = selectedDate + " " + selectedTime + ":00";

            // Получаем выбранные значения
            int serviceId = serviceComboBox->currentData().toInt();
            int clientId = user_->GetId();

            QString query = QString(R"(
                INSERT INTO public.appointments (client_id, service_id, master_id, appointment_time)
                VALUES (%1, %2, %3, '%4')
            )").arg(clientId).arg(serviceId).arg(master.first).arg(appointmentDateTime);

            // Попытка записи на прием
            if (db_manager_.ExecuteQuery(query)) {
                QMessageBox::information(this, "Запись подтверждена",
                                         "Мастер: " + master.second +
                                             "\nДата: " + selectedDate +
                                             "\nВремя: " + selectedTime);
            } else {
                QMessageBox::critical(this, "Ошибка записи", "Не удалось выполнить запись: " + db_manager_.GetLastError());
            }
        });
        cardLayout->addWidget(bookButton);

        containerLayout->addWidget(masterCard);
    }

    container->setLayout(containerLayout);
    scrollArea->setWidget(container);
    layout->addWidget(scrollArea);
}

void MainWindow::ShowServices() {
    // Очистка предыдущего содержимого
    QVBoxLayout* layout = new QVBoxLayout(ui->services);
    QTableWidget* table = new QTableWidget(this);

    // Устанавливаем заголовки таблицы
    table->setColumnCount(3);
    table->setHorizontalHeaderLabels({"Название услуги", "Цена (₽)", "Длительность (мин)"});
    table->horizontalHeader()->setSectionResizeMode(QHeaderView::Stretch);

    // Загружаем данные из таблицы services
    QSqlQuery query("SELECT name, price, duration_minutes FROM public.services");
    int row = 0;

    while (query.next()) {
        table->insertRow(row);

        // Заполняем строку данными
        table->setItem(row, 0, new QTableWidgetItem(query.value("name").toString()));
        table->setItem(row, 1, new QTableWidgetItem(query.value("price").toString()));
        table->setItem(row, 2, new QTableWidgetItem(query.value("duration_minutes").toString()));

        ++row;
    }

    // Добавляем таблицу в виджет
    layout->addWidget(table);
    ui->services->setLayout(layout);
}
