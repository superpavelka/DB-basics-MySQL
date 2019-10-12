-- Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости 
-- от текущего времени суток. С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", 
-- с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", 
-- с 00:00 до 6:00 — "Доброй ночи".

DELIMITER //

DROP FUNCTION IF EXISTS hello//
CREATE FUNCTION hello ()
RETURNS VARCHAR(12) DETERMINISTIC
BEGIN
	DECLARE h TINYINT;
	DECLARE s VARCHAR(12);
	SET h = HOUR(NOW());
	IF (h >= 6 AND h <= 11) THEN
		SET s = 'Доброе утро';
	ELSEIF (h >= 12 AND h <= 17) THEN
		SET s = 'Добрый день';
	ELSEIF (h >= 18 AND h <= 23) THEN
		SET s = 'Добрый вечер';
	ELSEIF (h >= 0 AND h <= 5) THEN
		SET s = 'Доброй ночи';
	END IF;
  RETURN s;
END//

SELECT hello()//