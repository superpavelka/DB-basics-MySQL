DROP DATABASE IF EXISTS example;
CREATE DATABASE example;
USE example;
CREATE TABLE users (
id SERIAL PRIMARY KEY , 
name VARCHAR(30) NOT NULL);

INSERT INTO users (name)VALUES('John Doe');
INSERT INTO users (name)VALUES('Chris White');
INSERT INTO users (name)VALUES('Sam Smith');
SELECT * FROM users;
