use vk;

-- Операторы, фильтрация, сортировка и ограничение
-- Агрегация данных
-- ------------------------------------------ пользователи
-- Находим пользователя
SELECT * FROM users LIMIT 1;
SELECT * FROM users WHERE id = 1; 
SELECT firstname, lastname FROM users WHERE id = 1;

-- Данные пользователя с заглушками
SELECT firstname, lastname, 'main_photo', 'city' FROM users WHERE id = 1;

-- Расписываем заглушки
SELECT 
  firstname, 
  lastname, 
  (SELECT filename FROM media WHERE id = 
    (SELECT photo_id FROM profiles WHERE user_id = 1)
    ) AS main_photo, 
  (SELECT hometown FROM profiles WHERE user_id = 1) AS city 
  FROM users 
  WHERE id = 1;

-- Начинаем работать с фотографиями
-- в типах медиа данных есть фото:
SELECT * FROM media_types WHERE name LIKE 'phoTo'; -- LIKE не чувствителен к регистру!

-- Выбираем фотографии пользователя
SELECT filename FROM media 
  WHERE user_id = 1
    AND media_type_id = (
      SELECT id FROM media_types WHERE name LIKE 'photo' -- в реальной жизни указали бы id = 1
    ); 
    
-- Фото другого пользователя (подменить user_id = 5)
SELECT filename FROM media 
  WHERE user_id = 5
    AND media_type_id = (
      SELECT id FROM media_types WHERE name LIKE 'photo'
    ); 
-- ------------------------------------------ новости
-- Смотрим типы объектов для которых возможны новости  
SELECT * FROM media_types;

-- Выбираем новости пользователя
select *
  FROM media 
  WHERE user_id = 1;
  
-- Выбираем путь к файлам медиа, которые есть в новостях (они же фотки)
SELECT filename FROM media 
	WHERE user_id = 1
  AND media_type_id = (
    SELECT id FROM media_types WHERE name LIKE 'photo'
);

-- Подсчитываем количество таких файлов
SELECT COUNT(*) FROM media 
	WHERE user_id = 1
  AND media_type_id = (
    SELECT id FROM media_types WHERE name LIKE 'photo'
);
-- ------------------------------------------ друзья
-- Смотрим структуру таблицы дружбы
describe friend_requests; -- фишка MySQL, в MS SQL Server такой команды нет
DESC     friend_requests; -- то же самое

-- Выбираем друзей пользователя (сначала все заявки)
SELECT * FROM friend_requests 
WHERE 
	initiator_user_id = 1 -- мои заявки
	or target_user_id = 1 -- заявки ко мне
;

-- Выбираем только друзей с подтверждённым статусом
SELECT * FROM friend_requests 
WHERE (initiator_user_id = 1 or target_user_id = 1)
	and status='approved' -- только подтвержденные друзья
;

-- Выбираем новости друзей
SELECT * FROM media WHERE user_id IN (
  SELECT initiator_user_id FROM friend_requests WHERE (target_user_id = 1) AND status='approved' -- ИД друзей, заявку которых я подтвердил
  union
  SELECT target_user_id FROM friend_requests WHERE (initiator_user_id = 1) AND status='approved' -- ИД друзей, подрвердивших мою заявку
);

-- Объединяем новости пользователя и его друзей
SELECT * FROM media WHERE user_id = 1 -- мои новости
UNION
SELECT * FROM media WHERE user_id IN (  -- новости друзей
  SELECT initiator_user_id FROM friend_requests WHERE (target_user_id = 1) AND status='approved' -- ИД друзей, заявку которых я подтвердил
  union
  SELECT target_user_id FROM friend_requests WHERE (initiator_user_id = 1) AND status='approved' -- ИД друзей, подрвердивших мою заявку
)
ORDER BY created_at desc -- упорядочиваем список
LIMIT 10; -- просто чтобы потренироваться

/*
-- Находим имена (пути) медиафайлов, на которые ссылаются новости
SELECT media_type_id FROM media WHERE user_id = 1
UNION
SELECT media_type_id FROM media WHERE user_id IN (
  SELECT user_id FROM friend_requests WHERE user_id = 1 AND status
);
*/

-- Смотрим структуру лайков
DESC likes;

-- Подсчитываем лайки для моих новостей (моих медиа)
SELECT media_id, COUNT(*) 
FROM likes 
WHERE media_id IN (
  SELECT id FROM media WHERE user_id = 1 -- мои медиа
)
GROUP BY media_id;

-- то же с JOIN
SELECT media_id, COUNT(*) 
FROM likes l
JOIN media m on l.media_id = m.id
WHERE m.user_id = 1 -- мои медиа
GROUP BY media_id;

-- Начинаем создавать архив новостей по месяцам
-- (сколько новостей в каждом месяце было создано)
SELECT COUNT(id) AS media, MONTHNAME(created_at) AS month_name, MONTH(created_at) AS month_num 
  	FROM media
  	GROUP BY month_name
	order by month_num -- упорядочим по месяцам
--  order by count(id) desc -- узнаем самые активные месяцы
  	; 

-- сколько новостей у каждого пользователя?  
SELECT COUNT(id) AS news_count, user_id AS user 
  FROM media
  GROUP BY user;
-- ------------------------------------------ сообщения  
-- Выбираем сообщения от пользователя и к пользователю (мои и ко мне)
SELECT * FROM messages
  WHERE from_user_id = 1 -- от меня
    OR to_user_id = 1 -- ко мне
  ORDER BY created_at DESC;
  
-- Непрочитанные сообщения
-- добавим колонку is_read DEFAULT FALSE
ALTER TABLE messages
ADD COLUMN is_read BOOL default false;

-- получим непрочитанные (будут все) 
SELECT * FROM messages
  WHERE to_user_id = 1
    AND is_read = 0
  ORDER BY created_at DESC;

 -- отметим прочитанными некоторые (старше какой-то даты)
 update messages
 set is_read = 1
 where created_at < DATE_SUB(NOW(), INTERVAL 100 DAY);

 -- снова получим непрочитанные
 SELECT * FROM messages
  WHERE to_user_id = 1
    AND is_read = 0
  ORDER BY created_at DESC;
 
-- Выводим друзей пользователя с преобразованием пола и возраста 
-- (поиграемся со встроенными функциями MYSQL)
SELECT user_id, 
       CASE (gender)
         WHEN 'm' THEN 'male'
         WHEN 'f' THEN 'female'
       END AS gender, 
       TIMESTAMPDIFF(YEAR, birthday, NOW()) AS age 
  FROM profiles
  WHERE user_id IN (
	  SELECT initiator_user_id FROM friend_requests WHERE (target_user_id = 1) AND status='approved' -- ИД друзей, заявку которых я подтвердил
	  union
	  SELECT target_user_id FROM friend_requests WHERE (initiator_user_id = 1) AND status='approved' -- ИД друзей, подрвердивших мою заявку
  );



  