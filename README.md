# Library Management Database

Этот проект содержит SQL-скрипт `goit-rdb-hw-04.sql` для создания и наполнения базы данных управления библиотекой.

## Установка

1. Убедитесь, что MySQL установлен и запущен.
2. Создайте базу данных (если необходимо):
   ```sh
   mysql -u root -p -e "CREATE DATABASE librarymanagement;"
   ```
3. Импортируйте SQL-скрипт:
   ```sh
   mysql -u root -p librarymanagement < goit-rdb-hw-04.sql
   ```

## Структура базы

- `authors` — таблица авторов книг.
- `genres` — таблица жанров.
- `users` — таблица пользователей библиотеки.
- `books` — таблица книг.
- `borrowed_books` — записи о выданных книгах.

## Использование

Подключитесь к MySQL и выберите базу:
```sh
mysql -u root -p
USE librarymanagement;
```

Дальше можно выполнять SQL-запросы для работы с данными.

