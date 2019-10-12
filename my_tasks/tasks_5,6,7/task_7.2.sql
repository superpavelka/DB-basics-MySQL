-- (по желанию) Пусть имеется таблица accounts содержащая три столбца id, name, password, содержащие первичный ключ,
-- имя пользователя и его пароль. Создайте представление username таблицы accounts, предоставляющий доступ к столбцам 
-- id и name. Создайте пользователя user_read, который бы не имел доступа к таблице accounts, однако, мог бы извлекать 
-- записи из представления username.

DROP DATABASE IF EXISTS users_accounts;
CREATE DATABASE users_accounts;
USE users_accounts;
DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts
(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    pwd VARCHAR(255)
);

CREATE VIEW username AS 
(
    SELECT id, name
    FROM accounts
);
DROP USER IF EXISTS 'user_read'@'localhost';
CREATE USER 'user_read'@'localhost' IDENTIFIED BY '=!=npuBETMuP=!=';

GRANT USAGE ON *.* TO 'user_read'@'localhost';
GRANT SELECT ON users_accounts.username TO 'user_read'@'localhost';

SHOW GRANTS FOR 'user_read'@'localhost';

-- mysql> USE users_accounts;
-- Database changed
-- mysql> select * from accounts;
-- ERROR 1142 (42000): SELECT command denied to user 'user_read'@'localhost' for table 'accounts'
-- mysql> select * from username;
-- Empty set (0.03 sec)