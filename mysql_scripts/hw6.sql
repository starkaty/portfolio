-- Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение. Агрегация данных”
/*1.Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, 
который больше всех общался с нашим пользователем.*/
use vk; -- используем БД vk
/*Пусть заданный пользователь с id = 1. 
Предположим, что общение - это обмен сообщениями (сообщения, который наш пользователь получает от друзей 
и которые наш пользователь отаправляет друзьям), а также лайки, которые наш пользователь ставит друзьям на их media 
и которые его media получают от друзей.*/

select firstname, lastname from users where id = (
with temp_tab as 
((select user_id, count(id) as count1 from likes 
where (user_id = 1 and media_id in (select id from media where user_id in (select id from users
where id in (select if(initiator_user_id = 1, target_user_id, initiator_user_id) from friend_requests
where (initiator_user_id = 1 or target_user_id = 1) and status = 'approved')))) or (user_id in (select id from users
where id in (select if(initiator_user_id = 1, target_user_id, initiator_user_id) from friend_requests
where (initiator_user_id = 1 or target_user_id = 1) and status = 'approved')) and media_id in (select id from media where user_id = 1))
group by user_id)
union
(select user_id, count(id) as count1 from media where id in (select media_id from likes 
where (user_id = 1 and media_id in (select id from media where user_id in (select id from users
where id in (select if(initiator_user_id = 1, target_user_id, initiator_user_id) from friend_requests
where (initiator_user_id = 1 or target_user_id = 1) and status = 'approved')))) or (user_id in (select id from users
where id in (select if(initiator_user_id = 1, target_user_id, initiator_user_id) from friend_requests
where (initiator_user_id = 1 or target_user_id = 1) and status = 'approved')) and media_id in (select id from media where user_id = 1)))
group by user_id)
union
(select if(from_user_id = 1, to_user_id, from_user_id) as user_id, count(*) as count1  from messages where (from_user_id = 1 and to_user_id in (select if(initiator_user_id = 1, target_user_id, initiator_user_id) from friend_requests
where (initiator_user_id = 1 or target_user_id = 1) and status = 'approved')) or (to_user_id = 1 and from_user_id in (select if(initiator_user_id = 1, target_user_id, initiator_user_id) from friend_requests
where (initiator_user_id = 1 or target_user_id = 1))) group by user_id))
select user_id from temp_tab where user_id != 1 group by user_id order by sum(count1) desc limit 1);

-- 2.Подсчитать общее количество лайков, которые получили пользователи младше 11 лет.

select count(*) from likes 
where media_id in (select id from media 
where user_id in (select user_id from profiles where timestampdiff(year, birthday, now()) < 11));

-- 3.Определить кто больше поставил лайков (всего): мужчины или женщины.

select if ((select count(*) from likes where user_id in (select user_id from profiles where gender = 'm'))>
(select count(*) from likes where user_id in (select user_id from profiles where gender = 'f')), 
'more likes from male users', if ((select count(*) from likes where user_id in (select user_id 
from profiles where gender = 'm')) < (select count(*) from likes 
where user_id in (select user_id from profiles where gender = 'f')), 
'more likes from female users', 'equal amount of likes from male and female'));