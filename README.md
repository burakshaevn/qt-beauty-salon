# Управление базой данных салона красоты

## Описание
Приложение разработано на C++17 с использованием фреймворка Qt 6.6.3 и системой управления базами данных PostgreSQL. Проект представляет собой систему для управления данными салона красоты, включая клиентов, мастеров, администраторов, ценовую политику салона и управление записями. Данные извлекаются из базы данных, обрабатываются и отображаются в интерфейсе с использованием Qt, откуда у пользователя есть возможность добавлять, редактировать и удалять данные.

В программе предусмотрено два пользователя — **пользователь** и **администратор**.

## Сборка и установка
Требования:
- C++17
- Qt 6.6.2+
- PostgreSQL 17+
- CMake 3.5+

Сборка и запуск:

В переменных средах системы должен быть указан путь до бинарных библиотек Postgres.
* Windows (_пример_): `C:\dev\PostgreSQL\17\lib`
* MacOS (_пример_): `/Library/PostgreSQL/17/lib`

### Создание базы данных
* В репозитории хранится файл c расширением `.sql`, содержащий пример базы данных для задачи.

  ```
  1. Выполняем авторизацию в pgAdmin 4.
  2. Создаём базу данных, в которой будут расположены таблицы, триггеры и тд.
  3. Открываем «запросник» Query Tool → Вставить код из файла .sql → Выполнить запрос.
  ```

### Сборка под редакторы

* Qt Creator
  ```
  1. Распаковать репозиторий.
  2. Open Qt Creator → Open Project.
  3. В открывшемся окне указываем путь к распакованному репозиторию и выбираем файл CMakeLists.txt.
  4. Выполняем конфигурацию проекта под нужный компилятор «Configure Project».
  ```

* Visual Studio 2022
  ```sh
  cd ..\qt-transport-catalogue\
  mkdir build-vs
  cd ..\qt-transport-catalogue\build-vs
  cmake .. -G "Visual Studio 17 2022" -DCMAKE_PREFIX_PATH="C:\Qt\6.6.2\msvc2019_64\"
  mingw32-make
  ```
  где `-DCMAKE_PREFIX_PATH="C:\Qt\6.6.2\msvc2019_64\"` — путь к месту установки фреймворка Qt, собранного с использованием компилятора Microsoft Visual Studio. Здесь можно указать свой компилятор.

## Пример 
...

## Авторизация
В программе предусмотрено два пользователя — **пользователь** и **администратор**. 
<div align="center">
  <img src="https://github.com/user-attachments/assets/01d0fcc5-97b7-4c10-96ea-7445c562e173" alt="image" width="50%">
  <p>Рис. N — Окно авторизации.</p>
</div>  

<details>
<summary>Авторизация как администратор</summary>
  
  Требуется таблица admins.
  1. Открыть pgAdmin 4
  2. Открыть Query Tool для базы данных beauty-salon
  3. Выполнить SQL-запрос:
  ```sql
  SELECT * FROM admins;
  ```
  4. Скопировать любой email и вставить в поле Login
  5. Скопировать пароль выбранного почтового адреса и вставить в поле Password

</details>

<details>
<summary>Авторизация как пользователь</summary>

  Требуется таблица clients.
  1. Открыть pgAdmin 4
  2. Открыть Query Tool для базы данных beauty-salon
  3. Выполнить SQL-запрос:
  ```sql
  SELECT * FROM clients;
  ```
  5. Скопировать любой email и вставить в поле Login
  6. Скопировать пароль выбранного почтового адреса и вставить в поле Password

</details>

## Авторизация как пользователь 
<div align="center">
  <img src="https://github.com/user-attachments/assets/a1606fbc-3057-4210-8cc7-d2d74fbf5a32" alt="image" width="50%">
  <p>Рис. N — Страница «Главная» после авторизации как пользователь.</p>
</div>  

В этом окне отображаются все записи пользователя: название услуги, имя мастера и время записи. Отсюда мы можем выполнить переход по дополнительным разделам — «Услуги» и «Мастера».

На странице с услугами пользователь может только ознакомиться с ценами на услуги.
<div align="center">
  <img src="https://github.com/user-attachments/assets/463bb03b-ab31-4392-b607-8d5f5c606698" alt="image" width="50%">
  <p>Рис. N — Страница «Услуги».</p>
</div>   

На странице с мастерами пользователь может выбрать мастера, время и услугу, которую предлагает мастер (мастера многозадачные).
<div align="center">
  <img src="https://github.com/user-attachments/assets/4b51a497-27ab-476c-b2f2-9600fa297847" alt="image" width="50%">
  <p>Рис. N — Страница «Услуги».</p>
</div>     

## Авторизация как администратор
По умолчанию эта страница будет пустой до тех пор, пока не будет выбрана таблица для редактирования. Чтобы это сделать, необходимо нажать на «меню» в верхней части экрана. Это выпадающий список, в который динамически добавятся все таблицы базы данных. 
<div align="center">
  <img src="https://github.com/user-attachments/assets/c27aac2c-f20b-4407-8308-9b1806ae218f" alt="image" width="50%">
  <p>Рис. N — Страница по умолчанию для администратора. (teachers).</p>
</div>

После выбора таблицы её данные отображаются на экране.
<div align="center">
  <img src="https://github.com/user-attachments/assets/07f5a53c-fda0-4061-af55-70510eec565c" alt="image" width="50%">
  <p>Рис. N — Выгрузка таблицы.</p>
</div>

### Добавление записи
При нажатии на кнопку добавления новой записи «Добавить», происходит вызов функции `void Table::AddRecord();`, которая создаёт экземпляр класса, в котором строится диалоговое окно `EditDialog dialog(newRecord, this);`, где `newRecord` — передача конкретной записи из базы данных в виде QSqlRecord. Эта запись используется для отображения столбцов таблицы.

Здесь мы не можем задать значение поля id. Потому что это «счётчик» записей в таблице, который будет сам автоматически увеличиваться по мере поступления новых записей.
<div align="center">
  <img src="https://github.com/user-attachments/assets/a9702f08-d5af-47cc-ac8b-094dbe3f956d" alt="image">
  <p>Рис. 5 — Окно для добавления.</p>
</div>

## Удаление записи
Производится ввод ID записи в таблице. Она будет удалена.

В некоторых таблицах, например, ID начинается необязательно с 1. Итерироваться в этом окне мы можем от самого минимального ID до самого максимального. Чтобы не выходить за пределы.
<div align="center">
  <img src="https://github.com/user-attachments/assets/a3b3e4f2-aa02-4b36-83c0-fb953ccb189e" alt="image">
  <p>Рис. 5 — Окно ввода ID записи (автоинкрементируемого столбца) в текущей таблице.</p>
</div>

После указания ID удаляемой записи выходит окно подтверждения удаления, где строится таблица с удаляемой строкой (чтобы быть уверенным, что удаляется именно то, что мы задумали).
<div align="center">
  <img src="https://github.com/user-attachments/assets/fed447e6-314a-4583-9b9e-654bc2e0908f" alt="image">
  <p>Рис. 6 — Вывод удаляемой строки.</p>
</div>

<div align="center">
  <img src="https://github.com/user-attachments/assets/bf66e036-a05d-48cb-a64a-5b911e22aef6" alt="image">
  <p>Рис. 7 — Окно подтверждения удаления.</p>
</div>

После подтверждения происходит удаление из основной таблицы, **а записи, которые ссылались на первичный ключ этой строки, каскадно удаляются**.

## Редактирование записи
Для редактирования указывается всегда номер строки в таблицы, а не ID записи. 
<div align="center">
  <img src="https://github.com/user-attachments/assets/b44792b7-1329-4303-8a26-cb23624892cf" alt="image">
  <p>Рис. 8 — Окно поиска записи в таблице.</p>
</div>

<div align="center">
  <img src="https://github.com/user-attachments/assets/0e3a0c6f-5d6f-4b74-9475-12cfbcc66ccc" alt="image">
  <p>Рис. 9 — Окно редактирования записи.</p>
</div>

## ER-диаграмма базы данных
<div align="center">
  <img src="https://github.com/user-attachments/assets/ee38b467-5e2b-45b6-bf15-3c12035b01cb" alt="image">
  <p>Рис. 10 — ER-диаграмма.</p>
</div>    
