use shop; -- используем БД shop

/* Практическое задание по теме «Операторы, фильтрация, сортировка и ограничение»
1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.*/

update users set created_at = now(), updated_at = now() where id > 0;
select created_at, updated_at from users; -- проверим обновленные значения 

/*2. Таблица users была неудачно спроектирована. 
Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения 
в формате 20.10.2017 8:10. Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения*/
-- приведем формат строки к требуемому формату даты (datetime)
update users 
set 
created_at = date_format(str_to_date(concat(created_at,':00'), '%e.%c.%Y %H:%i:%s'), '%Y-%m-%d %H:%i:%s'),
updated_at = date_format(str_to_date(concat(updated_at,':00'), '%e.%c.%Y %H:%i:%s'), '%Y-%m-%d %H:%i:%s')
where id > 0;
alter table users modify created_at datetime; -- изменим тип данных для столбцов таблицы
alter table users modify updated_at datetime;
describe users; -- посмотрим структуру таблицы и убедимся, что тип данных изменен
select created_at, updated_at from users;-- проведем проверку полученного результата, данные сохранены, выводятся в нужном нам формате даты и времени

/*3. В таблице складских запасов storehouses_products в поле value 
могут встречаться самые разные цифры: 0, если товар закончился и выше нуля, 
если на складе имеются запасы. Необходимо отсортировать записи таким образом, 
чтобы они выводились в порядке увеличения значения value. 
Однако нулевые запасы должны выводиться в конце, после всех записей*/

-- Способ 1 (с дополнительным столбцом):

alter table storehouses_products add zero tinyint; -- для разделения записей с количеством 0 и не 0, создадим дополнительный столбец zero
update storehouses_products
set
zero = 1
where value = 0 and id > 0; -- если количество 0, zero 1
update storehouses_products
set
zero = 0
where value != 0 and id > 0; -- если количество не 0, zero 0
select * from storehouses_products order by zero, value; -- отсортируем записи по zero и количеству

-- Способ 2 (без дополнительного столбца):

select * from storehouses_products order by if(value > 0, 0, 1), value;

/*4. (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. 
Месяцы заданы в виде списка английских названий (may, august)*/

-- Способ 1 (месяц учтен в виде числа):
select * from users
where
substring(birthday_at, 6, 2) in ('05', '08');

-- Способ 2 (месяц учтен в виде слова): 
select * from users
where
monthname(date(birthday_at)) in ('may', 'august');

/*5. (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. 
SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN.*/

select * from catalogs where id in (5, 1, 2)
order by field(id, 5, 1, 2);

/*Практическое задание теме «Агрегация данных»
1. Подсчитайте средний возраст пользователей в таблице users.*/

select round(avg(timestampdiff(year, birthday_at, now())), 0) as avg_age from users; -- округлим средний возраст для удобства

/*2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
Следует учесть, что необходимы дни недели текущего года, а не года рождения.*/

select dayname(concat('2022-', substring(birthday_at, 6, 5))) as birthdayname_2022, count(*) from users
group by dayname(concat('2022-', substring(birthday_at, 6, 5)));

/*3. (по желанию) Подсчитайте произведение чисел в столбце таблицы.*/

-- 3.1 за основу взяли задание 2, решили задачу использования результата вызова функции count() с group by в качестве таблицы для функции, считающей произведение чисел столбца
with tab as (select count(*) as count_bday from users group by dayname(concat('2022-', substring(birthday_at, 6, 5))))
select round(exp(sum(log(count_bday))), 2) as mult_count 
from tab;

-- 3.2 произведение чисел из столбца value имеющейся таблицы storehouses_products
select round(exp(sum(log(value))), 2) as mult_count from storehouses_products
where value <= 10; -- чтобы не получилось слишком длинное число