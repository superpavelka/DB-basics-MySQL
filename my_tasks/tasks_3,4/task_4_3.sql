-- найти произведение чисел в столбце
DROP DATABASE IF EXISTS values_dat;
CREATE DATABASE values_dat;
USE values_dat;

CREATE TABLE values_table (
  id INT NOT NULL);

INSERT INTO values_table VALUES
(1),(2),(3),(4),(5);

SELECT *  FROM values_table;
SELECT ROUND(EXP(SUM(LOG(id))),0) FROM values_table;