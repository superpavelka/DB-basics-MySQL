ALTER TABLE catalogs DROP INDEX unique_name;
INSERT INTO catalogs (name)values(NULL);
INSERT INTO catalogs (name)values(NULL);
INSERT INTO catalogs (name)values('');
SELECT * FROM catalogs;
UPDATE catalogs SET name = 'empty' WHERE name IS NULL OR name = '';
SELECT * FROM catalogs;