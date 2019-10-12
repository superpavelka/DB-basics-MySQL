/*
Хранимые процедуры и функции
Оптимизация запросов

1. Создаём функцию

Направленность дружбы
Кол-во приглашений в друзья к пользователю
/
Кол-во приглашений в друзья от пользователя

Чем больше - популярность выше
Если значение меньше единицы - пользователь инициатор связей.
*/
USE vk;

DROP FUNCTION IF EXISTS friendship_direction;

DELIMITER //
CREATE FUNCTION friendship_direction(check_user_id INT)
RETURNS FLOAT READS SQL DATA
  BEGIN
    DECLARE requests_to_user INT;
    DECLARE requests_from_user INT;
    
    SET requests_to_user = 
      (SELECT COUNT(*) 
        FROM friend_requests
          WHERE target_user_id = check_user_id);
    
    SET requests_from_user = 
      (SELECT COUNT(*) 
        FROM friend_requests
          WHERE initiator_user_id = check_user_id);
    
    RETURN requests_to_user / requests_from_user;
  END//
DELIMITER ;

SELECT friendship_direction(1);
SELECT TRUNCATE(friendship_direction(1), 2);
SELECT TRUNCATE(friendship_direction(11), 2);
/*-- ---------------------------------------------------------------------------
2. Создаём процедуру

Рассылка приглашений вида "Возможно, вам будет интересно пообщаться с ..."
Варианты:
- из одного города
- состоят в одной группе
- друзья друзей
Из выборки показывать 5 человек в случайной комбинации.
*/
drop procedure if exists friendship_offers;

delimiter //
create procedure friendship_offers(in for_user_id INT)
begin
	-- общий город
	select p2.user_id
	from profiles p1
	join profiles p2 on p1.hometown = p2.hometown
	where p1.user_id = for_user_id 
		and p2.user_id <> for_user_id 
	
		union 
		
	-- общие группы
	select uc2.user_id
	from users_communities uc1
	join users_communities uc2 on uc1.community_id = uc2.community_id
	where uc1.user_id = for_user_id 
		and uc2.user_id <> for_user_id 

		union 
		
	-- друзья друзей (работает с ошибкой - иногда выводит for_user_id)
	select fr3.target_user_id	
	from friend_requests fr1
		join friend_requests fr2 on (fr1.target_user_id = fr2.initiator_user_id or fr1.initiator_user_id = fr2.target_user_id)
		join friend_requests fr3 on (fr3.target_user_id = fr2.initiator_user_id or fr3.initiator_user_id = fr2.target_user_id)
	where (fr1.initiator_user_id = for_user_id or fr1.target_user_id = for_user_id)
	 	and fr2.status = 'approved'
	 	and fr3.status = 'approved'
		-- and fr3.initiator_user_id <> for_user_id 
		-- and fr3.target_user_id <> for_user_id 
	
	order by rand()
	limit 5;
end //
delimiter ;

CALL friendship_offers(1);

/*-- ---------------------------------------------------------------------------
3. Оптимизация (рассмотреть также в графическом анализаторе Workbench)*/
-- ALTER TABLE vk.likes DROP INDEX media_id;

-- Список медиафайлов пользователя с количеством лайков
SELECT media.filename,
  media_types.name,
  COUNT(*) AS total_likes,
  CONCAT(firstname, ' ', lastname) AS owner
  FROM media
    JOIN media_types ON media.media_type_id = media_types.id
    JOIN likes ON media.id = likes.media_id
    JOIN users ON users.id = media.user_id
  WHERE users.id = 1
  GROUP BY media.id;
  
 -- EXPLAIN works with SELECT, DELETE, INSERT, REPLACE, and UPDATE statements.
 explain
	 SELECT media.filename,
	  media_types.name,
	  COUNT(*) AS total_likes,
	  CONCAT(firstname, ' ', lastname) AS owner
	  FROM media
	    JOIN media_types ON media.media_type_id = media_types.id
	    JOIN likes ON media.id = likes.media_id
	    JOIN users ON users.id = media.user_id
	  WHERE users.id = 1
	  GROUP BY media.id;

ALTER TABLE likes ADD INDEX likes_to_subject_id_idx (media_id);
-- explain again
-- ALTER TABLE likes drop INDEX likes_to_subject_id_idx;
ALTER TABLE likes ADD FOREIGN KEY (media_id) REFERENCES media(id);
-- explain again