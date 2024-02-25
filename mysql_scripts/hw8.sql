use vk;
/*1 Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, 
который больше всех общался с выбранным пользователем (написал ему сообщений).*/

select
	concat(u.firstname, ' ', u.lastname) as most_comm_user
from 
	users u
    join
    friend_requests fr 
		on (fr.initiator_user_id = u.id or fr.target_user_id = u.id) and (fr.initiator_user_id = 1 or fr.target_user_id = 1)
    join
    messages m 
		on m.to_user_id = 1 and m.from_user_id = u.id
where 
	fr.status = 'approved'
group by 
	most_comm_user
order by 
	count(*) desc
limit 1;

-- 2 Подсчитать общее количество лайков, которые получили пользователи младше 11 лет.

select
	count(*) as cnt
from
	profiles as p
	join
	media as m on p.user_id = m.user_id
	join
	likes as l on l.media_id = m.id
where 
	timestampdiff(year, p.birthday, now())<11;

-- 3 Определить кто больше поставил лайков (всего): мужчины или женщины.

select
	gender,
	count(*) as 'likes'
from
	profiles as p
	join
	likes as l on p.user_id = l.user_id
group by
	gender
order by 
	count(*) desc;