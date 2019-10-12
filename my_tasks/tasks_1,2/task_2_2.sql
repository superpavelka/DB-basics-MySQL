DROP DATABASE IF EXISTS Media;
CREATE DATABASE Media;
USE Media;
DROP TABLE IF EXISTS users;
CREATE TABLE users(
    id SERIAL PRIMARY KEY ,
    name VARCHAR(255),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS  keywords;
CREATE TABLE keywords(
    id serial PRIMARY KEY,
    name VARCHAR(256),
    UNIQUE idx_name(name)
);

DROP TABLE IF EXISTS filestore;
CREATE TABLE filestore(
    id SERIAL PRIMARY KEY,
    name VARCHAR(256),
    description TEXT,
    user_id INT UNSIGNED NOT NULL,
    PATH VARCHAR(2048) NOT NULL,
    TYPE ENUM('photo', 'audio', 'video')
);


DROP TABLE IF EXISTS filestore_keyword;
CREATE TABLE filestore_keyword(
    id SERIAL PRIMARY KEY,
    store_id INT UNSIGNED,
    keyword_id INT UNSIGNED
);

INSERT INTO keywords(name) VALUES('Moscow');
INSERT INTO users(name) VALUES('John Snow');
INSERT INTO filestore VALUES(DEFAULT, 'M19.jpg', 'Red Square 2019', 1,'C:/Ph/M19.jpg', 'photo');
INSERT INTO filestore_keyword VALUES (NULL, 1,1);
SELECT * FROM users, keywords, filestore, filestore_keyword;