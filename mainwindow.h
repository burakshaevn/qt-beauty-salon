#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QMessageBox>
#include <QScrollArea>
#include <QGroupBox>
#include <QCalendarWidget>

#include "database_manager.h"
#include "user.h"
#include "table.h"

QT_BEGIN_NAMESPACE
namespace Ui {
class MainWindow;
}
QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();

    void UpdateUser(const UserInfo& user, QWidget* parent);

private slots:
    void on_pushButton_login_clicked();
    void on_logout_clicked();

    void on_pushButton_authorization_clicked();

    void on_pushButton_masters_clicked();

    void on_pushButton_services_clicked();

    QList<QPair<int, QString>> FetchMasters();
    QList<QPair<int, QString>> FetchServices();
    void ShowMasters();
    void ShowServices();

private:
    Ui::MainWindow *ui;

    DatabaseManager db_manager_;
    std::unique_ptr<User> user_;
    std::unique_ptr<Table> table_;
    std::unique_ptr<QTableWidget> table_services_;
};
#endif // MAINWINDOW_H
