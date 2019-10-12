-- по желанию) Пусть имеется таблица с календарным полем created_at. 
-- В ней размещены разряженые календарные записи за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17. 
-- Составьте запрос, который выводит полный список дат за август, выставляя в соседнем поле значение 1, 
-- если дата присутствует в исходном таблице и 0, если она отсутствует.

DROP DATABASE IF EXISTS months;
CREATE DATABASE months;
USE months;
DROP TABLE IF EXISTS tbl_august;
CREATE TABLE tbl_august
(
	id SERIAL,
    created_at DATE 
);

INSERT INTO tbl_august VALUES
    (default, '2018-08-01'),
    (default, '2018-08-04'),
    (default, '2018-08-16'),
	(default, '2018-08-17');

SELECT * FROM tbl_august;

DROP TABLE IF EXISTS dates;
CREATE TABLE dates
(
	id SERIAL,
    created_at DATE,
    equal SMALLINT
);
INSERT INTO dates VALUES
    (default, '2018-08-01',0),
    (default, '2018-08-02',0),
    (default, '2018-08-03',0),
    (default, '2018-08-04',0),
    (default, '2018-08-05',0),
    (default, '2018-08-06',0),
    (default, '2018-08-07',0),
    (default, '2018-08-08',0),
    (default, '2018-08-09',0),
    (default, '2018-08-10',0),
    (default, '2018-08-11',0),
    (default, '2018-08-12',0),
    (default, '2018-08-13',0),
    (default, '2018-08-14',0),
    (default, '2018-08-15',0),
    (default, '2018-08-16',0),
    (default, '2018-08-17',0),
    (default, '2018-08-18',0),
    (default, '2018-08-19',0),
    (default, '2018-08-20',0),
    (default, '2018-08-21',0),
    (default, '2018-08-22',0),
    (default, '2018-08-23',0),
    (default, '2018-08-24',0),
    (default, '2018-08-25',0),
    (default, '2018-08-26',0),
    (default, '2018-08-27',0),
    (default, '2018-08-28',0),
    (default, '2018-08-29',0),
    (default, '2018-08-30',0),
	(default, '2018-08-31',0);

SELECT * FROM dates;

UPDATE dates, tbl_august
SET dates.equal = 1
WHERE dates.created_at = tbl_august.created_at;

SELECT * FROM dates;
-- (по желанию) Пусть имеется любая таблица с календарным полем created_at. 
-- Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.
DELETE d1 FROM dates d1
         LEFT JOIN
         (
         SELECT id FROM dates
         ORDER BY created_at DESC
         LIMIT 5
         ) d2
    ON d1.id = d2.id
	WHERE d2.id IS NULL;
SELECT * FROM dates;
