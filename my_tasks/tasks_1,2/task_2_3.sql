DROP DATABASE IF EXISTS shop;
CREATE DATABASE shop;
USE shop;
DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'City name',
  UNIQUE unique_name(name(10))
) COMMENT = 'Online Store Sections';

INSERT INTO catalogs (name)VALUES ('Processors');
INSERT INTO catalogs (name)VALUES('Motherboards');
INSERT INTO catalogs (name)VALUES('Videocards');
SELECT * FROM catalogs;

DROP DATABASE IF EXISTS sample;
CREATE DATABASE sample;
USE sample;
DROP TABLE IF EXISTS cat;
CREATE TABLE cat (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);

INSERT INTO cat (name)VALUES('TV');
INSERT INTO cat (name)VALUES('AV');
SELECT * FROM cat;

REPLACE INTO cat SELECT * FROM shop.catalogs;
SELECT * FROM cat;