-- # запускаю такой скрипт
DROP DATABASE IF EXISTS example;
CREATE DATABASE example;
USE example;
CREATE TABLE users (
id SERIAL PRIMARY KEY , 
name VARCHAR(30) NOT NULL);
--# несколько записей для наглядности
INSERT INTO users (name)VALUES('John Doe');
INSERT INTO users (name)VALUES('Chris White');
INSERT INTO users (name)VALUES('Sam Smith');
SELECT * FROM users;
quit
-- # это уже делаю в консоли
mysqldump example > dump_example.sql;
--# запускаю утилиту mysql
mysql
--# cоздаю новую БД sample
CREATE DATABASE IF NOT EXISTS sample;
--# выхожу из mysql
quit	
--# разворачиваю в sample дамп
mysql sample < dump_example.sql;
--# делаю дамп таблицы help_keyword из mysql
mysqldump mysql help_keyword --where="true limit 100"> help_100.sql
--# смотрю что получилось
cat help_100.sql
