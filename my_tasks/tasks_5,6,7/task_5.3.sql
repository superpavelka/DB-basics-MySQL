/*(по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
Поля from, to и label содержат английские названия городов, поле name — русское. 
Выведите список рейсов flights с русскими названиями городов.*/
DROP DATABASE IF EXISTS flights_cities;
CREATE DATABASE flights_cities;
USE flights_cities;
DROP TABLE IF EXISTS cities;
CREATE TABLE cities
(
    label VARCHAR(255) PRIMARY KEY,
    name  VARCHAR(255)
);

DROP TABLE IF EXISTS flights;
CREATE TABLE flights
(
    id     SERIAL,
    `from` VARCHAR(255) NOT NULL,
    `to`   VARCHAR(255) NOT NULL,
    FOREIGN KEY (`from`) REFERENCES cities (label),
    FOREIGN KEY (`to`) REFERENCES cities (label),
    CONSTRAINT flight_unq UNIQUE (`from`, `to`),
    CHECK ( `from` <> `to`)
);

INSERT INTO cities
VALUES ('moscow', 'Москва'),
       ('kazan', 'Казань'),
       ('irkutsk', 'Иркустк'),
       ('omsk', 'Омск');

INSERT flights
VALUES (DEFAULT, 'moscow', 'kazan'),
       (DEFAULT, 'moscow', 'omsk'),
       (DEFAULT, 'moscow', 'irkutsk'),
       (DEFAULT, 'kazan', 'moscow'),
       (DEFAULT, 'omsk', 'moscow');
       
SELECT * FROM flights;

SELECT flights.id, c1.name, c2.name
FROM flights
         LEFT JOIN cities c1 
         ON flights.`from` = c1.label
         LEFT JOIN cities c2 
         ON flights.`to` = c2.label
ORDER BY flights.id;