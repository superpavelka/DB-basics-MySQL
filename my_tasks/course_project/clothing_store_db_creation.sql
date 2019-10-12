DROP DATABASE IF EXISTS clothing_store;
CREATE DATABASE clothing_store;
USE clothing_store;

DROP TABLE IF EXISTS product_types;
CREATE TABLE product_types 
(
  id_product_type SERIAL PRIMARY KEY,
  product_type TEXT COMMENT 'product_type'
);

DROP TABLE IF EXISTS manufacturers;
CREATE TABLE manufacturers 
(
  id_manufacturer SERIAL PRIMARY KEY,
  name TEXT COMMENT 'manufacturer name'
);

DROP TABLE IF EXISTS colors;
CREATE TABLE colors 
(
  id_color SERIAL PRIMARY KEY,
  color TEXT COMMENT 'color name'
);

DROP TABLE IF EXISTS sizes;
CREATE TABLE sizes 
(
  id_size SERIAL PRIMARY KEY,
  product_type BIGINT UNSIGNED NOT NULL,
  `size` TEXT COMMENT 'clothing size',
  FOREIGN KEY (product_type) REFERENCES product_types(id_product_type)
);

DROP TABLE IF EXISTS stores;
CREATE TABLE stores 
(
  id_store SERIAL PRIMARY KEY,
  address TEXT,
  director_name TEXT COMMENT 'name of store manager'
);

DROP TABLE IF EXISTS exchange_rates;
CREATE TABLE exchange_rates 
(
  id_exchange_rate SERIAL PRIMARY KEY,
  `data` DATETIME DEFAULT CURRENT_TIMESTAMP,
  exchange_rate INT COMMENT 'exchange_rates'
);

DROP TABLE IF EXISTS product_groups;
CREATE TABLE product_groups 
(
  id_product_group SERIAL PRIMARY KEY,
  product_type BIGINT UNSIGNED NOT NULL,
  product_group TEXT COMMENT 'product_groups' ,
  FOREIGN KEY (product_type) REFERENCES product_types(id_product_type)
);

DROP TABLE IF EXISTS products;
CREATE TABLE products 
(
  id_product SERIAL PRIMARY KEY,
  product_type BIGINT UNSIGNED NOT NULL ,
  product_group BIGINT UNSIGNED NOT NULL,
  manufacturer BIGINT UNSIGNED NOT NULL,
  description TEXT COMMENT 'Description',
  FOREIGN KEY (product_type) REFERENCES product_types(id_product_type),
  FOREIGN KEY (product_group) REFERENCES product_groups(id_product_group),
  FOREIGN KEY (manufacturer) REFERENCES manufacturers(id_manufacturer)
);

DROP TABLE IF EXISTS products_colors_sizes;
CREATE TABLE products_colors_sizes 
(
  id_product_color_size SERIAL PRIMARY KEY,
  product BIGINT UNSIGNED NOT NULL,
  color BIGINT UNSIGNED NOT NULL,
  `size` BIGINT UNSIGNED NOT NULL COMMENT 'products_colors_sizes',
  FOREIGN KEY (product) REFERENCES products(id_product),
  FOREIGN KEY (color) REFERENCES colors(id_color),
  FOREIGN KEY (`size`) REFERENCES sizes(id_size)
);

DROP TABLE IF EXISTS supplies;
CREATE TABLE supplies 
(
  id_supply SERIAL PRIMARY KEY,
  store BIGINT UNSIGNED NOT NULL,
  exchange_rate BIGINT UNSIGNED NOT NULL,
  product_color_size BIGINT UNSIGNED NOT NULL,
  amount INT,
  purchase_price INT COMMENT 'supplies',
  FOREIGN KEY (store) REFERENCES stores(id_store),
  FOREIGN KEY (exchange_rate) REFERENCES exchange_rates(id_exchange_rate),
  FOREIGN KEY (product_color_size) REFERENCES products_colors_sizes(id_product_color_size)
);

DROP TABLE IF EXISTS sales;
CREATE TABLE sales 
(
  id_sale SERIAL PRIMARY KEY,
  sale_date DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  store BIGINT UNSIGNED NOT NULL,
  product_color_size BIGINT UNSIGNED NOT NULL,
  amount INT,
  discount INT COMMENT 'sales',
  FOREIGN KEY (store) REFERENCES stores(id_store),
  FOREIGN KEY (product_color_size) REFERENCES products_colors_sizes(id_product_color_size)
);

-- Наполнение
INSERT INTO product_types VALUES 
(NULL,'pants and shorts'),
(NULL,'outerwear'),
(NULL,'turtlenecks'),
(NULL,'jumpers and cardigans'),
(NULL,'jeans'),
(NULL,'vests'),
(NULL,'carnival costumes'),
(NULL,'overalls and semi-overalls'),
(NULL,'costumes'),
(NULL,'long sleigh'),
(NULL,'homewear'),
(NULL,'jackets'),
(NULL,'sweatshirts'),
(NULL,'hoodies'),
(NULL,'T-shirts'),
(NULL,'dresses'),
(NULL,'tunics'),
(NULL,'skirts');

INSERT INTO manufacturers VALUES 
(NULL,'ASICS'),
(NULL,'Baon'),
(NULL,'Betsy'),
(NULL,'Bourjois'),
(NULL,'Caprice'),
(NULL,'COLIN'),
(NULL,'CROCS'),
(NULL,'Keddo'),
(NULL,'Finn Flare'),
(NULL,'GEOX'),
(NULL,'POSAYLEGOL'),
(NULL,'Tozzi'),
(NULL,'Pierre'),
(NULL,'Nike'),
(NULL,'Polaris'),
(NULL,'SOKOLOV'),
(NULL,'Trussardi'),
(NULL,'Rocher');

INSERT INTO colors VALUES 
(NULL,'fuchsia'),
(NULL,'gray'),
(NULL,'white'),
(NULL,'aqua'),
(NULL,'blue'),
(NULL,'teal'),
(NULL,'silver'),
(NULL,'black'),
(NULL,'purple'),
(NULL,'green'),
(NULL,'navy'),
(NULL,'olive'),
(NULL,'maroon'),
(NULL,'lime'),
(NULL,'pink'); 

INSERT INTO clothing_store.sizes (product_type,`size`) VALUES 
(1,'XS')
,(2,'XS')
,(3,'XS')
,(4,'XS')
,(5,'XS')
,(6,'XS')
,(7,'XS')
,(8,'XS')
,(9,'XS')
,(10,'XS')
,(11,'XS')
,(12,'XS')
,(13,'XS')
,(14,'XS')
,(15,'XS')
,(16,'XS')
,(17,'XS')
,(18,'XS')
,(1,'S')
,(2,'S')
,(3,'S')
,(4,'S')
,(5,'S')
,(6,'S')
,(7,'S')
,(8,'S')
,(9,'S')
,(10,'S')
,(11,'S')
,(12,'S')
,(13,'S')
,(14,'S')
,(15,'S')
,(16,'S')
,(17,'S')
,(18,'S')
,(1,'M')
,(2,'M')
,(3,'M')
,(4,'M')
,(5,'M')
,(6,'M')
,(7,'M')
,(8,'M')
,(9,'M')
,(10,'M')
,(11,'M')
,(12,'M')
,(13,'M')
,(14,'M')
,(15,'M')
,(16,'M')
,(17,'M')
,(18,'M')
,(1,'L')
,(2,'L')
,(3,'L')
,(4,'L')
,(5,'L')
,(6,'L')
,(7,'L')
,(8,'L')
,(9,'L')
,(10,'L')
,(11,'L')
,(12,'L')
,(13,'L')
,(14,'L')
,(15,'L')
,(16,'L')
,(17,'L')
,(18,'L')
,(1,'XL')
,(2,'XL')
,(3,'XL')
,(4,'XL')
,(5,'XL')
,(6,'XL')
,(7,'XL')
,(8,'XL')
,(9,'XL')
,(10,'XL')
,(11,'XL')
,(12,'XL')
,(13,'XL')
,(14,'XL')
,(15,'XL')
,(16,'XL')
,(17,'XL')
,(18,'XL');

INSERT INTO stores VALUES 
(NULL, '561 Cole Port','Kristopher Brown'),
(NULL, '927 Crist Mills Suite 834','Lenny Wintheiser'),
(NULL, '54023 Altenwerth Freeway','Tate Krajcik'),
(NULL, '02428 Seth Walk','Antonetta Heidenreich'),
(NULL, '73126 Runolfsson Ford Apt. 825','Prof. Ford Hermann MD'),
(NULL, '4429 Hodkiewicz Crest Apt. 900','Mrs. Keira Jaskolski'),
(NULL, '46136 Werner Summit','Caterina Stokes'),
(NULL, '64322 Cleveland Circles','Miss Alexandria Cremin MD'),
(NULL, '66754 Eugenia Prairie Suite 420','Candace Sawayn MD'),
(NULL, '4705 Davion Falls','Hassan Feest'),
(NULL, '64148 Johns Pass','Luis Reinger'),
(NULL, '971 Hoppe Park Apt. 685','Freeman Hilpert'),
(NULL, '85515 Nathanial Springs Apt. 180','Krystel Rohan'),
(NULL, '6817 Kuhn Oval Apt. 859','Dr. Melyna Skiles'),
(NULL, '22217 Padberg Views Suite 145','Helga Fritsch'),
(NULL, '9677 Cleveland Summit Suite 128','Urban Bartell'),
(NULL, '48363 Ullrich Plaza','Prof. Shaun Bogisich DVM'),
(NULL, '88754 Ledner Turnpike','Prof. Janick Roberts II'),
(NULL, '4033 Deckow Square','Carmela Shanahan'),
(NULL, '512 Addison Ville','Prof. Krista Nikolaus PhD'),
(NULL, '9190 Fletcher Fields Apt. 552','Ignatius O\'Connell'),
(NULL, '04508 Stone Harbor Suite 434','George Hirthe Sr.'),
(NULL, '784 Bogan Hills Apt. 402','Gretchen Padberg'),
(NULL, '38490 Brekke Prairie Apt. 056','Ms. Ofelia Mitchell Jr.'),
(NULL, '6974 Maude Cove Suite 769','Mr. Alfred McDermott'),
(NULL, '8635 Cassin Field','Owen Greenholt'),
(NULL, '41243 Boehm Island Suite 547','Rudy Auer MD'),
(NULL, '101 Clarissa Stream','Dr. Violette Kertzmann IV'),
(NULL, '990 Zelda Islands','Mr. Nelson Cronin DVM'),
(NULL, '25328 Lubowitz Squares','Laurine Bogisich'),
(NULL, '0965 Patience Lake Suite 703','Elnora Cremin'),
(NULL, '8631 Barrows Island','Jessica Kerluke'),
(NULL, '85433 Cronin Walk','Mr. Demond McKenzie'),
(NULL, '25508 Goyette Walk Suite 202','Prof. Jaeden Bayer'),
(NULL, '627 Nikolaus Lodge','Felicity Turcotte Sr.'),
(NULL, '127 Howell Prairie Suite 451','Mireille Schultz'),
(NULL, '2358 Sabryna Radial','Arnold Anderson'),
(NULL, '21233 Hayes Crest Suite 556','Chelsey Anderson'),
(NULL, '897 Gerlach Loop Apt. 703','Keeley Weimann'),
(NULL, '445 Turcotte Valleys Apt. 961','Prof. Darren Bergnaum IV'),
(NULL, '2120 Phoebe Common Apt. 774','Edna Medhurst'),
(NULL, '0901 Jayce Fords Suite 460','Dr. Ulices Wolff'),
(NULL, '5903 Domenick Land','Payton Franecki'),
(NULL, '0297 Wunsch Stravenue Suite 666','Tianna Runolfsson'),
(NULL, '217 Bernhard Pine Suite 135','Lavada Bosco'),
(NULL, '45235 Goldner Park','Dr. Omer Sanford PhD'),
(NULL, '736 Erdman Coves','Arlene Murray'),
(NULL, '7094 Schuppe Islands Apt. 608','Fermin Weimann PhD'),
(NULL, '47047 Octavia Points','Dr. Abraham Haley'),
(NULL, '186 Gertrude Path','Stanton Emard III'),
(NULL, '16623 Shanon Mills','Santa Keebler'),
(NULL, '67363 Konopelski Trafficway','Lucienne Hauck MD'),
(NULL, '607 Braden Dam Suite 453','Deja Harber Sr.'),
(NULL, '010 Alexander Vista','Erling Kunde'),
(NULL, '587 Brekke Mount','Prof. Willis McDermott'),
(NULL, '483 Lang Stravenue Apt. 174','Mrs. Matilda Erdman'),
(NULL, '097 Eliane Junction','Amely Hackett MD'),
(NULL, '20819 Bergstrom Plaza Apt. 471','Prof. D\'angelo Jacobson'),
(NULL, '57550 Kelsie Run','Johnny Carroll'),
(NULL, '51460 Wayne Parkway Suite 716','Quinton Douglas'),
(NULL, '806 Katheryn Track Apt. 418','Rodrick Zulauf PhD'),
(NULL, '10037 Wilber Greens','Brendan Pagac'),
(NULL, '63579 Garnett Turnpike','Miss Alexane Predovic DVM'),
(NULL, '1985 Monahan Grove Suite 792','Jayda Lakin'),
(NULL, '019 Mayert Dam','Verona Hansen'),
(NULL, '8005 Eulah Crossroad Suite 903','Prof. Quincy Hartmann'),
(NULL, '957 Krajcik Route Suite 056','Lynn Weissnat'),
(NULL, '35815 Lockman Springs Apt. 231','Mr. Johnathon Blick'),
(NULL, '299 Collins Parkways Suite 874','Dr. Frankie Stroman Sr.'),
(NULL, '4023 Larkin Manor Suite 293','Vickie Stark'),
(NULL, '2506 Phoebe Islands Suite 909','Eleanora Franecki'),
(NULL, '5508 Heaney Center','Dr. Amaya Collier II'),
(NULL, '98547 Terry Locks','Prof. Luigi Beer V'),
(NULL, '907 Vincent Harbor','Jessie Nicolas'),
(NULL, '017 Tanya Pine Suite 928','Mr. Robert Johns V'),
(NULL, '66121 Witting Grove Apt. 584','Evert Kassulke'),
(NULL, '694 Misty Cove Suite 843','Justen Hodkiewicz'),
(NULL, '3379 Emmerich Fork Suite 271','Dr. Gianni Turner II'),
(NULL, '182 Tomas Village','Mr. Isaiah Reinger DVM'),
(NULL, '4401 Delaney Ford','Jaylon Feeney'),
(NULL, '616 Hamill Forge Suite 406','Ephraim Mertz'),
(NULL, '87098 Beer Extension','Mr. Jayden Parker MD'),
(NULL, '5848 Shanahan Prairie','Mr. Olin Brekke II'),
(NULL, '958 Fredy Fork Apt. 049','Tracy Roberts DVM'),
(NULL, '01122 Taya Street','Louisa Bartoletti'),
(NULL, '8596 Gordon Avenue','Prof. Coralie Blick II'),
(NULL, '92192 Gail Roads','Mittie Gottlieb'),
(NULL, '99433 Gerald Junctions Apt. 492','Ms. Mariam Larson II'),
(NULL, '934 Stroman Pass','Rodrick Weber'),
(NULL, '20222 Kendall Plains','Myrtis Robel'),
(NULL, '20345 Dudley Oval','Lilla Pouros III'),
(NULL, '0863 Glen Lock Apt. 497','Georgette Dibbert'),
(NULL, '42933 Nico Glens Suite 399','Maiya Schamberger'),
(NULL, '64479 Waelchi Junctions Apt. 195','Josianne Wintheiser'),
(NULL, '419 Savanah Spurs','Ms. Krystal Von Jr.'),
(NULL, '168 Maudie Fall','Jerrell Terry'),
(NULL, '18362 Franecki Loaf Apt. 895','Breanna Smitham'),
(NULL, '78848 Hubert Village Apt. 602','Dr. Herman Hermann'),
(NULL, '415 Lind Junctions','Nikolas Krajcik'),
(NULL, '67754 Leannon Union Suite 745','Callie Boyer'); 

INSERT INTO clothing_store.exchange_rates (`data`,exchange_rate) VALUES 
('2018-07-04 21:00:00',50)
,('2018-07-05 21:00:00',51)
,('2018-07-06 21:00:00',52)
,('2018-07-07 21:00:00',53)
,('2018-07-08 21:00:00',54)
,('2018-07-09 21:00:00',55)
,('2018-07-10 21:00:00',56)
,('2018-07-11 21:00:00',57)
,('2018-07-12 21:00:00',58)
,('2018-07-13 21:00:00',59)
,('2018-07-14 21:00:00',60)
,('2018-07-15 21:00:00',61)
,('2018-07-16 21:00:00',62)
,('2018-07-17 21:00:00',63)
,('2018-07-18 21:00:00',64)
,('2018-07-19 21:00:00',65)
,('2018-07-20 21:00:00',66)
,('2018-07-21 21:00:00',67)
,('2018-07-22 21:00:00',68)
,('2018-07-23 21:00:00',69)
,('2018-07-24 21:00:00',70)
,('2018-07-25 21:00:00',71)
,('2018-07-26 21:00:00',72)
,('2018-07-27 21:00:00',73)
,('2018-07-28 21:00:00',74)
,('2018-07-29 21:00:00',75)
,('2018-07-30 21:00:00',76)
,('2018-07-31 21:00:00',77)
,('2018-08-01 21:00:00',78)
,('2018-08-02 21:00:00',79)
,('2018-08-03 21:00:00',80)
,('2018-08-04 21:00:00',81)
,('2018-08-05 21:00:00',82)
,('2018-08-06 21:00:00',83)
,('2018-08-07 21:00:00',84)
,('2018-08-08 21:00:00',85)
,('2018-08-09 21:00:00',86)
,('2018-08-10 21:00:00',87)
,('2018-08-11 21:00:00',88)
,('2018-08-12 21:00:00',89)
,('2018-08-13 21:00:00',90)
,('2018-08-14 21:00:00',91)
,('2018-08-15 21:00:00',92)
,('2018-08-16 21:00:00',93)
,('2018-08-17 21:00:00',94)
,('2018-08-18 21:00:00',95)
,('2018-08-19 21:00:00',96)
,('2018-08-20 21:00:00',97)
,('2018-08-21 21:00:00',98)
,('2018-08-22 21:00:00',99)
,('2018-08-23 21:00:00',100)
,('2018-08-24 21:00:00',101)
,('2018-08-25 21:00:00',102)
,('2018-08-26 21:00:00',103)
,('2018-08-27 21:00:00',104)
,('2018-08-28 21:00:00',105)
,('2018-08-29 21:00:00',106)
,('2018-08-30 21:00:00',107)
,('2018-08-31 21:00:00',108)
,('2018-09-01 21:00:00',109)
,('2018-09-02 21:00:00',110)
,('2018-09-03 21:00:00',111)
,('2018-09-04 21:00:00',112)
,('2018-09-05 21:00:00',113)
,('2018-09-06 21:00:00',114)
,('2018-09-07 21:00:00',115)
,('2018-09-08 21:00:00',116)
,('2018-09-09 21:00:00',117)
,('2018-09-10 21:00:00',118)
,('2018-09-11 21:00:00',119)
,('2018-09-12 21:00:00',120)
,('2018-09-13 21:00:00',121)
,('2018-09-14 21:00:00',122)
,('2018-09-15 21:00:00',123)
,('2018-09-16 21:00:00',124)
,('2018-09-17 21:00:00',125)
,('2018-09-18 21:00:00',126)
,('2018-09-19 21:00:00',127)
,('2018-09-20 21:00:00',128)
,('2018-09-21 21:00:00',129)
,('2018-09-22 21:00:00',130)
,('2018-09-23 21:00:00',131)
,('2018-09-24 21:00:00',132)
,('2018-09-25 21:00:00',133)
,('2018-09-26 21:00:00',134)
,('2018-09-27 21:00:00',135)
,('2018-09-28 21:00:00',136)
,('2018-09-29 21:00:00',137)
,('2018-09-30 21:00:00',138)
,('2018-10-01 21:00:00',139)
,('2018-10-02 21:00:00',140)
,('2018-10-03 21:00:00',141)
,('2018-10-04 21:00:00',142)
,('2018-10-05 21:00:00',143)
,('2018-10-06 21:00:00',144)
,('2018-10-07 21:00:00',145)
,('2018-10-08 21:00:00',146)
,('2018-10-09 21:00:00',147)
,('2018-10-10 21:00:00',148)
,('2018-10-11 21:00:00',149);

INSERT INTO product_groups VALUES 
(NULL,1,'For men')
,(NULL,2,'For men')
,(NULL,3,'For men')
,(NULL,4,'For men')
,(NULL,5,'For men')
,(NULL,6,'For men')
,(NULL,7,'For men')
,(NULL,8,'For men')
,(NULL,9,'For men')
,(NULL,10,'For men')
,(NULL,11,'For men')
,(NULL,12,'For men')
,(NULL,13,'For men')
,(NULL,14,'For men')
,(NULL,15,'For men')
,(NULL,16,'For men')
,(NULL,17,'For men')
,(NULL,18,'For men')
,(NULL,1,'For women')
,(NULL,2,'For women')
,(NULL,3,'For women')
,(NULL,4,'For women')
,(NULL,5,'For women')
,(NULL,6,'For women')
,(NULL,7,'For women')
,(NULL,8,'For women')
,(NULL,9,'For women')
,(NULL,10,'For women')
,(NULL,11,'For women')
,(NULL,12,'For women')
,(NULL,13,'For women')
,(NULL,14,'For women')
,(NULL,15,'For women')
,(NULL,16,'For women')
,(NULL,17,'For women')
,(NULL,18,'For women')
,(NULL,1,'For children')
,(NULL,2,'For children')
,(NULL,3,'For children')
,(NULL,4,'For children')
,(NULL,5,'For children')
,(NULL,6,'For children')
,(NULL,7,'For children')
,(NULL,8,'For children')
,(NULL,9,'For children')
,(NULL,10,'For children')
,(NULL,11,'For children')
,(NULL,12,'For children')
,(NULL,13,'For children')
,(NULL,14,'For children')
,(NULL,15,'For children')
,(NULL,16,'For children')
,(NULL,17,'For children')
,(NULL,18,'For children');

INSERT INTO clothing_store.products (product_type,product_group,manufacturer,description) VALUES 
(9,27,13,'incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation u')
,(2,9,6,'laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor i')
,(2,4,6,'sunt in culpa ')
,(18,25,1,'qui officia deserunt mollit anim id est labo')
,(18,32,8,'in reprehenderit in voluptate veli')
,(15,13,4,'Ut enim ad minim veniam, quis nost')
,(1,27,7,'ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderi')
,(17,28,14,'sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt moll')
,(4,27,7,'elit, se')
,(4,40,2,'quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo cons')
,(5,6,6,'nostrud exercitation ullamco laboris nisi ut')
,(6,34,2,'nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor')
,(13,51,8,'eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut ')
,(11,49,4,'mollit anim id est laborum.Lorem ipsum dolor')
,(1,31,8,'ut labore et dolore')
,(13,52,2,'in reprehenderit in voluptat')
,(3,1,10,'consectetur adipisc')
,(12,49,17,'aute irure dolor ')
,(17,10,7,'occaecat cupidatat non proident, sunt i')
,(4,24,1,'ut labore et dolore magna aliqua. Ut enim ad minim ')
,(18,54,18,'consequat. Duis aute irure dolor in reprehenderit in voluptate velit e')
,(12,16,2,'ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitati')
,(3,23,6,'adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliq')
,(1,42,9,'elit, sed do eiusmod tempor incididunt ut labore et dolore magna')
,(14,48,11,'aborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididun')
,(11,40,14,'ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ul')
,(8,3,17,'magna aliqua. Ut enim ad minim veniam, quis no')
,(9,27,6,'sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet,')
,(15,51,5,'dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolo')
,(14,19,7,'ullamco laboris nisi ut aliquip ex ea ')
,(18,52,7,'amet, consectetur adipisci')
,(8,47,5,'exerc')
,(11,44,18,'velit esse cillum dolore eu fug')
,(16,23,16,'dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercita')
,(18,23,7,'ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor ')
,(12,45,15,'reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepte')
,(7,43,4,'reprehenderit in voluptate velit esse cillum')
,(16,12,2,'velit esse cillum dolore eu fugi')
,(2,29,14,'cupida')
,(18,3,18,'ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut lab')
,(15,39,1,'ad minim veniam, quis nostrud exercitation ullamc')
,(14,54,17,'adipiscing elit, sed do eiusmod tempor incididunt ut labore e')
,(5,28,8,'in voluptate velit esse cillum dolore eu fugiat nulla pariat')
,(8,19,14,'d')
,(6,49,9,'sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore')
,(3,1,5,'sit a')
,(2,31,18,'deserunt mollit anim id')
,(15,37,11,'adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore ')
,(13,27,16,'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex')
,(2,51,9,'um.Lorem ipsum dolor sit amet, consectetur adipiscing elit, se')
,(12,26,7,'consequat. Duis a')
,(13,8,18,'velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proiden')
,(6,43,18,'nostrud exercitation ullamco laboris nisi')
,(3,18,15,'fugiat nulla pariatur. Excepteur sint occaecat cu')
,(9,10,16,'id ')
,(12,28,5,'nostrud exercitation ullamco laboris nisi ut aliquip ex ea ')
,(2,25,17,'eu fugiat nulla pariatur. Except')
,(14,38,4,'dolore eu fugia')
,(17,17,18,'anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod')
,(17,36,3,'elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim')
,(15,22,4,'mag')
,(2,45,10,'cillum dolore eu fugiat ')
,(13,47,2,'adipiscing elit, sed do eiusmod tempor')
,(2,43,1,'do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nos')
,(12,27,1,'pariatur. Excepteur sint occaecat ')
,(1,14,15,'deserunt mollit')
,(12,10,14,'non proident, sunt in culpa qui officia deserunt moll')
,(10,47,2,'mollit anim id est laborum.Lorem ipsum dolor sit amet, conse')
,(12,20,7,'ut labore et dolore magna aliqua. Ut enim ad minim')
,(2,24,16,'veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea ')
,(8,3,5,'dolore eu fugiat nul')
,(5,21,12,'in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat n')
,(8,30,9,'commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum do')
,(18,46,16,'Excepteur sint o')
,(18,3,4,'ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco labor')
,(11,41,8,'sint occaecat cupidatat non proi')
,(13,19,17,'dolor sit amet, consectetur adipiscing elit, sed do eiusmod te')
,(13,11,11,'eiusmod tempor incid')
,(13,43,16,'velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non p')
,(3,17,8,'esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, su')
,(17,8,14,'sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit ')
,(11,52,4,'fugia')
,(8,6,16,'nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt')
,(8,4,14,'sint occaecat cupidatat')
,(13,31,16,'qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit ame')
,(2,14,14,'sint occaecat cupidatat non proident, sunt in culpa qui officia deser')
,(3,26,3,'veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. D')
,(8,27,11,'.Lorem ipsum dolor sit amet, consectetur adipiscing el')
,(12,5,11,'esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non pro')
,(5,51,10,'pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia dese')
,(10,39,6,'in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupida')
,(2,11,6,'exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in repr')
,(3,45,12,'commodo consequat. Duis aute irure dolor in reprehenderit in volupt')
,(10,1,3,'anim id est laborum.Lorem ipsum')
,(13,2,16,'ipsum d')
,(16,14,9,'eu fugiat ')
,(11,38,5,'veniam, ')
,(1,9,7,'in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat')
,(1,17,9,'Excepteur sint occaecat cupidatat non proident, sunt i')
,(3,36,10,'ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore ')
,(4,30,5,'anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipisci')
,(17,38,13,'in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Exce')
,(13,50,18,'ut labore et dolore magna aliqua. Ut eni')
,(12,4,7,'veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip e')
,(1,8,10,'magna aliqua. Ut enim ad min')
,(9,2,2,'reprehenderit in voluptate velit esse ci')
,(7,43,6,'et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut')
,(8,51,12,'deserunt mollit anim id est laborum.Lorem ipsum dolor')
,(5,50,10,'veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea comm')
,(10,47,3,'dolor in reprehenderit in voluptate velit esse cillum dolore')
,(11,11,2,'laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptat')
,(17,40,13,'sint occaecat cupidatat non proiden')
,(11,26,12,'amet, consectetur adipi')
,(17,23,2,'in culpa qui officia deserunt mollit a')
,(9,45,3,'Excepteur sint occaecat cupidatat non proident, sunt in culpa ')
,(15,1,2,'ipsum dolor sit amet, consectetur adipiscing elit,')
,(6,40,12,'dolor in reprehenderit in voluptate velit')
,(12,24,4,'nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor')
,(6,13,8,'quis nostrud exercitation ullamco laboris nisi ')
,(1,41,1,'tempor incididunt ut labore et dolore magna aliq')
,(16,46,2,'laboris nisi ut aliquip')
,(12,18,6,'ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ul')
,(10,19,9,'irure dolor in reprehenderit in voluptate v')
,(13,45,8,'anim id est laborum.')
,(18,54,13,'sint occaecat cupidatat non proident, sunt in culpa qui officia des')
,(4,51,11,'dolor sit amet, consectetur adipiscing elit, sed do eius')
,(18,38,9,'dolore eu fugiat nulla pariatur. Except')
,(5,46,3,'adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ')
,(15,47,17,'Dui')
,(8,37,7,'mollit anim id e')
,(13,33,2,'sunt in culpa qui officia deserunt mollit anim id est laborum')
,(14,15,9,'Duis aute irure dolor in reprehenderit in volu')
,(12,28,11,'irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. E')
,(10,1,17,'labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostr')
,(3,25,9,'adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad')
,(17,27,4,'sunt in culpa qui officia deserunt mollit anim id est laborum.L')
,(18,7,10,'proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit')
,(4,53,5,'in cu')
,(16,13,2,'fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia des')
,(7,22,4,'sed do eiusmod tempor incididu')
,(16,5,14,'adipiscing elit, sed do eiusmod te')
,(13,19,11,'sit amet,')
,(2,1,6,'dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat no')
,(8,44,18,'aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut ali')
,(11,19,1,'ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis')
,(5,10,13,'laboris')
,(5,10,17,'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt')
,(11,35,2,'non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit a')
,(7,15,8,'irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Exce')
,(7,17,16,'ullamco laboris nisi ut aliquip ex ea commodo consequat. Dui')
,(17,13,4,'ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in')
,(9,17,18,'sunt in culpa qui off')
,(18,22,17,'aute irure dolor in reprehenderit in ')
,(8,13,11,'est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, s')
,(2,32,16,'in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint')
,(3,24,16,'magna aliqua. Ut enim ad minim veniam, quis nostrud exercitat')
,(1,25,1,'fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in ')
,(14,13,7,'sint occaecat cupidatat non proident, sunt in culpa qui offic')
,(10,11,15,'n')
,(17,13,8,'occaecat cupidatat non proident, sunt in culpa qui officia deserunt ')
,(14,34,7,'pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia de')
,(9,9,9,'ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempo')
,(15,25,10,'incididunt ut labore et dolore magna aliqua. Ut enim a')
,(5,35,16,'et dolore magna')
,(9,39,16,'voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint ')
,(17,19,11,'Ut enim ad mi')
,(16,22,15,'et dolore magna ali')
,(12,45,16,'ut aliquip ex ea ')
,(7,2,16,'ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco lab')
,(7,20,16,'in culpa qui officia deseru')
,(15,50,15,'qui officia deser')
,(11,19,5,'mo')
,(9,35,1,'adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore ma')
,(16,30,10,'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt ')
,(15,14,11,'nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui offi')
,(6,47,1,'nostrud exercitation ullamco laboris nis')
,(5,23,12,'Ut enim ad minim veniam, quis no')
,(14,1,17,'in reprehenderit in voluptate velit esse ')
,(7,51,6,'ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dol')
,(7,49,2,'velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupid')
,(2,28,4,'velit esse cillum dolore eu fugia')
,(7,53,16,'pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui')
,(12,22,16,'ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris')
,(15,41,5,'nostrud exercitation ullamco lab')
,(4,14,8,'qui officia deserunt mollit ani')
,(8,21,1,'ven')
,(6,41,1,'sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')
,(6,11,8,'cupidatat non proident, sunt in culpa qui officia deserunt mollit anim i')
,(11,23,8,'ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis a')
,(3,6,1,'nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor i')
,(5,15,16,'nisi ut aliquip ex ea commodo consequat. Duis aut')
,(4,37,14,'Duis aute irure dolor in reprehenderit i')
,(18,23,10,'quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat')
,(18,52,4,'Duis aute irure dolor in')
,(2,13,17,'molli')
,(15,23,5,'et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud e')
,(12,51,2,'quis nostrud exercitat')
,(16,5,4,'nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt ')
,(14,3,13,'nostrud exercitation ullamco ')
,(12,9,7,'laboris nisi ut aliquip ex ea commodo consequat. Du')
,(10,1,4,'Duis aute irure dolor in reprehend')
,(1,17,9,'ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse ci')
,(11,38,16,'esse cillum dolore eu fugiat nulla pariatur. Except')
,(11,21,13,'Excepteur ')
,(1,14,9,'sunt in culpa qui officia deserunt mollit anim id est l')
,(12,54,1,'consequat. Dui')
,(8,16,14,'magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris ')
,(3,2,1,'exercitation ullamco laboris nisi ut aliq')
,(3,5,18,'elit, sed do ei')
,(13,7,1,'sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dol')
,(6,18,14,'non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit am')
,(9,32,10,'ulla')
,(6,17,6,'labore et ')
,(10,6,7,'elit, sed do eiusmod tempor inci')
,(15,37,14,'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla p')
,(11,46,17,'exercitation')
,(14,28,17,'nostrud exercitation ullamco laboris nisi ut aliquip ')
,(15,51,16,'occaecat cupidatat non proident, ')
,(14,22,7,'cillum dolo')
,(1,23,12,'deserunt mollit')
,(15,20,16,'sunt in culpa qui officia d')
,(1,36,12,'ut l')
,(6,48,14,'rum.Lorem ipsum dolor sit amet, con')
,(12,21,13,'mollit anim id est laborum.Lore')
,(3,12,12,'eu fugiat nulla pariatur. Excepteur sint occaecat cupida')
,(2,38,15,'laboris nisi ut aliquip ex ea commodo consequat')
,(4,3,3,'ad minim veniam, quis nostrud exercitation')
,(11,13,10,'dolore eu fugiat nu')
,(10,19,7,'mollit anim id est laborum.Lorem ipsum dolor')
,(7,43,4,'consectetur adipiscing elit, sed do eiusmod tempor incididunt ')
,(4,43,2,'in voluptate velit esse cillum dolore eu f')
,(7,23,1,'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pa')
,(12,31,7,'ut labore et dolore ')
,(12,11,8,'dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco lab')
,(15,31,5,'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt molli')
,(9,12,16,'ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliqu')
,(2,14,14,'nisi ut aliquip ex ea commodo consequ')
,(1,8,2,'exercitation ullamco laboris nisi ')
,(5,34,1,'anim id est laborum.Lorem ipsum dolor sit amet,')
,(11,3,15,'non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor')
,(3,32,18,'adipiscing elit, s')
,(5,39,5,'au')
,(2,24,5,'et dolore magna aliqua. Ut eni')
,(16,6,8,'amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et do')
,(9,31,10,'eu fugiat nulla pariatur. Excepteur sint occaecat cupi')
,(12,10,11,'consequat. Duis aute ')
,(5,2,4,'tempor incididunt ut labore et dolore magna aliqua')
,(11,8,9,'veniam, quis nostrud exercitation ')
,(7,51,6,'elit, sed do eiusmod tempor incididunt ut labore et dolore magna al')
,(4,11,16,'Duis aute irure dolor in reprehenderit in volupt')
,(15,50,6,'e')
,(9,30,4,'dolore ma')
,(6,32,17,'amet, consectetur adipiscing elit, sed do ei')
,(2,53,5,'amet, co')
,(8,43,7,'deserunt mollit anim id est laborum.Lorem ipsum dol')
,(11,51,18,'deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, conse')
,(7,19,10,'consectetur adipiscing elit, se')
,(15,46,4,'labore et dolore magna aliqua. Ut enim ad minim veniam, qu')
,(17,27,7,'sint occaecat cupidatat non proident, sunt in culpa qui officia deser')
,(3,5,6,'.Lorem ipsum dolor sit amet, cons')
,(6,5,13,'elit, s')
,(8,31,4,'elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad ')
,(12,38,2,'ea commodo consequat. Duis aute irure dolor in repreh')
,(5,43,6,'in voluptate velit esse cillum dolore eu fugiat nulla paria')
,(18,28,3,'ut aliquip ex ea commodo consequat. Duis aute irure dolor in repre')
,(8,11,14,'magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation')
,(10,9,8,'ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commod')
,(5,20,17,'in reprehenderit in voluptate velit esse cill')
,(11,38,8,'in voluptate velit esse cillum dolore e')
,(5,35,12,'ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate')
,(5,40,12,'mollit anim id est laborum.Lorem i')
,(13,48,16,'tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nos')
,(13,38,17,'ullamco la')
,(8,35,5,'voluptate v')
,(18,28,8,'in ')
,(1,26,3,'est laborum.Lorem')
,(14,3,8,'su')
,(5,23,8,'ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris')
,(17,47,11,'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id e')
,(12,23,9,'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt moll')
,(8,49,9,'laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in volupt')
,(11,38,5,'incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis n')
,(2,44,2,'magna aliqua. Ut enim ad minim veniam, quis nostrud exerc')
,(9,25,1,'officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetu')
,(17,44,13,'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliqu')
,(2,11,7,'exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in')
,(15,52,6,'in reprehenderit in voluptate velit esse cillum dolore eu ')
,(18,51,4,'non pr')
,(12,29,2,'nostrud exercitation ullamco laboris nisi ut aliquip ex ea')
,(2,31,5,'pr')
,(8,35,6,'sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, cons')
,(10,22,5,'dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident')
,(9,28,4,'id est laborum.Lorem ipsu')
,(17,22,14,'dolore eu fugiat nulla pariatur. Excepteur sint occ')
,(6,34,1,'adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut eni')
,(3,17,1,'incididunt ut labore et dolore magna aliqua. Ut enim ad minim veni')
,(4,41,5,'ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt u')
,(11,6,13,'id est laborum.Lore')
,(4,16,7,'dese')
,(17,18,2,'labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exerc')
,(13,6,7,'in culpa qui officia deseru')
,(4,18,7,'quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute i')
,(1,25,4,'do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, q')
,(5,52,1,'eu')
,(7,15,4,'sint occaecat c')
,(3,42,12,'exercitation ullamco laboris nisi ut aliqu')
,(6,30,10,'ad minim veniam, quis nostrud exercitation ullamco laboris nis')
,(6,34,6,'dolor sit amet, consectetur adipiscing elit')
,(17,8,18,'Duis aute irure dolor in reprehend')
,(4,13,14,'ut labore et dolore magna aliqua. Ut enim ad min')
,(8,42,17,'pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa')
,(1,13,11,'velit esse cillum dolore eu fugiat nulla paria')
,(14,27,10,'in voluptate velit esse cillum dolore e')
,(18,24,17,'adipiscing elit, sed do eiusmod tempor incidi')
,(10,3,6,'Ut enim a')
,(7,26,7,'laboris nisi ut aliquip ex ea commodo consequa')
,(8,11,1,'Duis aute irure dolor in reprehen')
,(17,11,10,'in voluptate velit esse cillum dolore eu fugiat n')
,(16,29,12,'Duis aute irure dol')
,(9,28,18,'eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia ')
,(12,31,15,'sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit ani')
,(17,11,17,'exercitation ullamco laboris nisi ut aliqui')
,(14,53,1,'dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco labori')
,(6,36,2,'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut en')
,(3,13,18,'aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip')
,(18,18,17,'eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut ')
,(4,21,6,'in voluptate velit e')
,(3,27,2,'ut aliquip ex ea commodo consequat. Duis aute irure do')
,(5,9,5,'rum.Lorem')
,(6,47,3,'amet, consectetur adipiscing elit, sed do ')
,(9,12,5,'eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui offic')
,(18,6,3,'n')
,(5,54,3,'deserunt mollit anim id est laborum.Lorem ipsum dolor sit')
,(14,21,5,'amet, consectetur adipiscing elit')
,(17,24,15,'enim ad minim veniam, quis nostrud exercitation ')
,(4,52,10,'Ut enim ad minim veniam, quis nostrud exercitation ulla')
,(3,8,9,'sunt in culpa qui officia deserunt mo')
,(11,48,5,'consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna a')
,(7,2,5,'proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum d')
,(18,5,4,'non proident, sunt in culpa qui officia deserunt mollit anim id es')
,(8,48,3,'laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed')
,(9,38,2,'pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui ')
,(18,12,9,'cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat no')
,(10,6,11,'sint occaecat cupidatat non proident, sunt in culpa qui o')
,(8,22,17,'ad minim veniam, quis nostrud exercitation ullamco laboris nisi u')
,(18,19,7,'nulla pariatur. Except')
,(17,1,18,'pari')
,(16,44,3,'proident, sunt in culpa qui officia dese')
,(1,37,5,'laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehender')
,(17,41,17,'exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute i')
,(11,39,12,'est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed')
,(9,42,6,'consectetur adipiscing ')
,(15,12,12,'sint occaecat cupidatat non proident, sunt in culpa qui offic')
,(13,30,2,'irure dolor in reprehenderit in voluptate')
,(3,5,15,'quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute ir')
,(4,16,2,'qui officia deserunt mollit')
,(6,21,11,'sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum do')
,(16,43,16,'mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod')
,(1,31,9,'exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute ')
,(16,17,18,'dolor in reprehenderit in voluptate velit esse cillum ')
,(2,40,2,'et dolore magna aliqua. Ut enim ad minim veniam, qui')
,(18,43,10,'velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat')
,(15,22,6,'eu fugiat nulla pariatur. Excepteur sint occaecat cupidat')
,(5,11,7,'Ut enim ad ')
,(2,2,13,'officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing')
,(8,46,4,'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id')
,(13,48,17,'ullamco laboris nisi ut aliquip ex ea commodo consequat. Dui')
,(6,53,12,'elit, sed do eiusmod tempor incididunt ut labore et')
,(7,6,7,'deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing e')
,(2,13,13,'sint occae')
,(11,51,4,'occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim')
,(13,26,5,'in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, cons')
,(14,25,2,'occaecat cupidatat non proident, sunt in culp')
,(17,21,18,'ex ea')
,(8,52,1,'occaecat cupidatat non proident, sunt in culpa qui ')
,(4,38,4,'velit esse cillum dolore eu fugiat nulla paria')
,(8,44,1,'ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation u')
,(10,18,5,'magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliq')
,(18,32,6,'nostrud exerci')
,(5,6,6,'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nul')
,(11,25,14,'ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in rep')
,(18,17,9,'do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim venia')
,(14,2,12,'incididunt ut labore et dolore magna aliqua. Ut enim ')
,(14,24,1,'magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco lab')
,(16,3,11,'in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur si')
,(14,24,11,'dolor sit amet, consecte')
,(8,54,11,'qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectet')
,(18,49,9,'velit esse cillum dolore eu fugiat nulla pariatur')
,(5,48,6,'sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laboru')
,(11,18,16,'ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut al')
,(13,51,15,'aliqua. Ut enim ad minim veniam, quis nostrud exercitation')
,(18,29,16,'quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis a')
,(18,1,18,'laboris nisi ut aliquip ex ea commodo con')
,(15,46,9,'eu fugi')
,(15,26,11,'et ')
,(7,34,6,'anim id est laborum.Lorem ipsum dolor sit amet, consecte')
,(10,14,9,'esse cillum dolore e')
,(9,31,17,'e')
,(14,53,5,'ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate vel')
,(16,48,18,'laboris ni')
,(12,18,7,'ad ')
,(8,17,2,'consequat. Duis')
,(13,50,15,'occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est ')
,(14,53,12,'non proident, sunt in culpa qui')
,(13,42,7,'in volupt')
,(10,17,11,'nisi ut aliquip ex ea commodo consequat')
,(2,9,7,'ex ea commodo consequat. Duis aute irure dolor in reprehende')
,(4,22,1,'ut labore et dolore magna aliqua. Ut enim ad minim veni')
,(16,46,13,'elit, sed do eiusmod tempor inci')
,(5,11,1,'proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor si')
,(9,33,10,'proident, sunt in culpa qui officia deserunt mollit anim id est labor')
,(10,11,8,'non proident, sunt in culpa qui officia deserunt molli')
,(14,11,2,'exercitation ullamco labo')
,(5,30,11,'ad minim veniam, quis nostrud exercitation ullamco')
,(13,48,12,'cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ips')
,(15,41,15,'ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure ')
,(12,9,3,'occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim')
,(10,12,16,'laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tem')
,(7,44,17,'incididunt ut labore et dolore magna aliqua. Ut enim ad minim veni')
,(11,34,5,'dolor ')
,(8,2,8,'anim id est laborum.Lorem ipsum dolor sit amet,')
,(3,48,14,'non proident, sunt in culpa ')
,(6,13,17,'est laborum.Lorem ipsum do')
,(10,23,18,'et d')
,(10,39,16,'laboris nisi ut aliquip')
,(16,19,4,'qui officia deserunt ')
,(1,6,16,'nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo ')
,(18,3,2,'velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non')
,(17,16,1,'laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor inci')
,(14,39,15,'um.Lorem ipsum dolo')
,(1,42,2,'mollit anim id est laborum.Lorem ipsum dolor sit amet, consectet')
,(12,35,3,'sed do eiusmod tempo')
,(14,9,17,'ex ea commodo consequat. Duis aute irure dolor in reprehe')
,(9,27,16,'mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetu')
,(6,18,9,'sint occaecat cupidatat non proident, sunt in culpa qui o')
,(13,9,14,'et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exerc')
,(2,17,6,'exercitation ullamco laboris nisi ut aliquip ')
,(3,8,16,'aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pa')
,(7,10,10,'orum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiu')
,(16,51,7,'adipiscing elit, sed do eiusmod tempor incididunt ut labore et ')
,(3,50,2,'in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint oc')
,(5,43,2,'veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat')
,(1,4,4,'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui ')
,(6,44,1,'Excepteur sint occaecat cupidatat non proident, sunt in cu')
,(4,26,13,'ullamco laboris nisi ut aliquip ex ea')
,(15,22,18,'elit, sed do eiusmod temp')
,(13,2,14,'amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labo')
,(13,46,16,'ad minim veniam,')
,(12,50,5,'quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo conseq')
,(13,20,1,'anim id est laborum.Lorem ipsum dolor sit amet, cons')
,(13,28,7,'veniam, quis nostrud exercitation ullamco')
,(10,3,1,'id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod')
,(1,39,12,'ex ea commodo consequat. D')
,(3,46,17,'eu fugiat nulla pariatu')
,(12,12,18,'fugiat nulla pariatur. Ex')
,(8,7,9,'et dolore')
,(9,49,2,'ipsum dolor sit amet, consect')
,(2,20,11,'incididunt ut labore et dolore magna')
,(7,24,16,'ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut')
,(11,52,2,'Duis aute irure dolor in repreh')
,(13,27,15,'ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in rep')
,(9,31,13,'in voluptat')
,(4,12,15,'ullamco laboris nisi ut aliquip ex ea commodo consequat')
,(5,15,14,'adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim a')
,(16,36,14,'quis nostrud exercitation ullamco laboris nisi ut aliquip ex')
,(6,38,7,'n')
,(18,25,4,'esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, ')
,(16,38,2,'veniam, quis nostrud exercitation ullamco laboris n')
,(12,13,6,'borum.')
,(5,6,7,'amet, consectetur adipiscing elit, sed do eiusmod tempo')
,(12,33,5,'nostrud exercitati')
,(7,29,9,'ut')
,(17,9,1,'id est laborum.Lorem ipsum dolor sit amet, consectetur adipi')
,(13,7,8,'dolore eu fugiat nulla pariatur. Excepteur sint occ')
,(15,49,12,'officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing')
,(11,34,12,'m.Lorem ipsum dolor sit amet, consectetur adipiscing eli')
,(5,24,7,'et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco labori')
,(9,18,5,'ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure ')
,(17,5,13,'in culpa qui officia deserunt mollit anim id est labo')
,(14,46,10,'exercitation ul')
,(1,7,12,'amet, consectetur adipisc')
,(16,20,16,'Duis aute irure dolor in reprehenderit in v')
,(9,40,7,'et dolore magna aliqua. Ut enim ad minim veniam, quis nostr')
,(18,12,11,'consequat. Duis aute irure dolor in reprehenderit in voluptate velit e')
,(18,33,14,'dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut')
,(4,54,18,'ad minim veniam, quis nostrud exercitati')
,(2,13,12,'esse cillum dolore eu fugiat nulla pariatu')
,(18,43,14,'velit esse cillum dolore eu fugiat nulla p')
,(6,34,15,'sint oc')
,(3,6,4,'pariatur. Excepteur sint occaecat cupidatat non proid')
,(11,49,2,'occaecat cupidatat non proident, sunt in cu')
,(4,44,4,'sunt in culpa qui officia deserunt mollit anim id est laborum')
,(8,19,1,'elit, sed do eiusmo')
,(1,22,9,'Ut enim ad minim veniam, quis nostrud exercitation ulla')
,(8,11,10,'mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit,')
,(9,1,11,'sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt m')
,(2,4,8,'elit, se')
,(11,34,17,'dolore magna aliqua. Ut enim ad minim')
,(16,19,14,'id est laborum.Lorem ipsum')
,(2,6,9,'en')
,(15,28,10,'ullamco laboris nisi ut aliquip ex ea commodo consequa')
,(12,35,1,'mollit anim id est laborum.Lorem ipsum dolor sit amet, consectet')
,(6,23,4,'incididunt ut labore et dolore magna ')
,(14,34,15,'nulla pariat')
,(9,30,3,'aliquip ex ea commodo consequat. Duis aute irure dolor in repr')
,(6,3,6,'id est laborum')
,(1,42,2,'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim a')
,(13,45,6,'cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')
,(15,20,12,'anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipis')
,(14,34,1,'ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit ess')
,(13,11,1,'minim veniam, quis nostrud ex')
,(8,17,11,'est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor in')
,(16,41,16,'anim id est laborum.')
,(5,30,10,'Ut enim ad minim veniam, quis nostrud ')
,(3,28,10,'aute irure dolor in reprehenderit in voluptate')
,(2,32,9,'nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehender')
,(5,8,9,'Duis aute irure dolor in reprehenderit in voluptate velit esse ')
,(11,53,4,'occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')
,(6,26,11,'mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusm')
,(13,45,2,'exercitation ullamco laboris nisi ut aliquip ')
,(16,5,8,'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id ')
,(7,7,4,'mollit ani')
,(14,12,8,'in reprehenderit ')
,(12,21,10,'Excepteur s')
,(18,35,11,'adipiscing elit, sed do ei')
,(17,39,10,'pariatur. Except')
,(8,45,18,'sunt in culpa qui officia deserunt molli')
,(15,34,9,'Duis aute irure dolor in reprehenderit in voluptate velit ess')
,(13,24,6,'sint occaecat cupidatat non proident, s')
,(12,31,13,'velit esse cillum dolor')
,(16,45,7,'pariatur. Excepteur sint occaec')
,(3,34,9,'ullamco laboris nisi ut aliquip ex ea commodo consequat. ')
,(1,32,10,'sed do ')
,(3,7,1,'Ut enim ad minim veniam, quis nostrud e')
,(7,19,12,'in ')
,(18,43,2,'consequat. Duis aute irure do')
,(5,22,5,'in culpa qui officia deserunt mollit anim id est laborum.')
,(2,48,6,'ut aliquip ex ea commo')
,(13,43,10,'in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint o')
,(11,9,2,'mollit anim id ')
,(6,8,12,'pariatur. Excepteur sint occaecat cupi')
,(11,32,16,'velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupi')
,(2,9,4,'velit esse cillum do')
,(16,17,5,'nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequ')
,(12,11,14,'in voluptate velit esse cillum dolore eu')
,(4,14,5,'non proident, sunt in culpa qui officia deserunt mollit anim id es')
,(9,47,2,'aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu ')
,(14,7,3,'laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in ')
,(14,48,8,'eu fugiat nulla p')
,(5,10,18,'eiusmod tempor incididunt ut labore et dolore magna aliqua')
,(5,29,18,'mollit anim id est laborum.Lorem')
,(8,25,15,'ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cill')
,(16,28,12,'et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco l')
,(15,9,15,'eiusmod tempor incididunt ut labore et dolore')
,(11,13,14,'irure dolor in reprehenderit in voluptate velit es')
,(9,13,9,'dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proi')
,(16,26,9,'aborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod t')
,(16,4,3,'dolor in reprehenderit in voluptate velit esse cillum dolore eu')
,(8,47,6,'sit amet, consectetur adipiscing elit, sed do eiu')
,(18,14,13,'non proident, sunt in culpa qui officia deserunt mol')
,(1,25,17,'culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolo')
,(11,8,7,'veniam')
,(8,25,13,'sed do eiusmod tempor inci')
,(15,44,2,'proident, sunt in culpa qui offici')
,(8,17,11,'enim ad minim v')
,(10,1,2,'id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing e')
,(13,13,16,'ex ea commodo consequat. Duis aute ')
,(2,1,7,'magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation u')
,(4,38,1,'sit amet, consectetur adipiscing elit, sed do eiusmod t')
,(14,13,17,'sint occaec')
,(5,16,4,'non proident, sunt in culpa qui of')
,(7,22,18,'non pro')
,(2,28,12,'esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaeca')
,(18,22,13,'nisi ut aliquip ex ea comm')
,(6,52,16,'sunt in culpa qui officia deseru')
,(6,28,6,'amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut lab')
,(4,2,18,'velit esse cillum dolore eu fugiat nulla pariatur. Excepteur si')
,(6,49,11,'ipsum dolor sit ')
,(10,7,5,'nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in ')
,(4,39,7,'dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur si')
,(3,39,5,'esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidat')
,(3,34,18,'laboris nisi ut aliqui')
,(14,11,4,'exercitation ullamco laboris nisi ut')
,(18,41,4,'mollit anim id est laborum.Lorem ipsum')
,(13,24,12,'ullamco la')
,(7,54,8,'consequat. Duis aute irure dolor in reprehenderit in voluptate velit ess')
,(4,30,17,'nostrud exercitation ullamco laboris nisi ut aliquip ex e')
,(17,40,3,'exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure d')
,(16,50,7,'cupidatat non p')
,(3,24,14,'sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et d')
,(2,54,16,'in voluptate velit esse cillum dolore eu fugiat nulla pariatu')
,(17,5,11,'anim id est laborum.Lorem ipsum dolor')
,(9,17,16,'id est laborum.Lorem ipsum dolor s')
,(10,27,11,'Duis aute irure dolor in reprehenderit in voluptate velit esse cil')
,(7,41,10,'do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut ')
,(2,6,17,'adipiscing elit, sed do eiusmod tempor incididunt ut labor')
,(12,13,17,'ullamco laboris nisi ut aliquip ')
,(5,11,15,'fugiat nulla pariatur. E')
,(17,47,2,'in voluptate velit esse cillum dolore eu fugiat nulla pariatur. E')
,(4,19,14,'id est laborum.Lorem');
