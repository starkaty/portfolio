-- используем БД shop для 1 и 2 заданий
use shop;
-- 1.Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

select u.name from users as u join orders as o on u.id = o.user_id group by name;

-- 2. Выведите список товаров products и разделов catalogs, который соответствует товару.

select p.name as product_name, c.name as catalog_name from products as p 
left join catalogs as c on c.id = p.catalog_id group by product_name, catalog_name; -- group by исключит повторы товаров, если они есть

-- 3.(по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов 
-- cities (label, name). Поля from, to и label содержат английские названия городов, поле name — русское. 
-- Выведите список рейсов flights с русскими названиями городов.

drop database if exists travel;
create database travel;
use travel;

drop table if exists flights;
create table flights (
id serial primary key,
from_city varchar(20),
to_city varchar(20)
);
insert into flights (from_city, to_city)
values ('moscow', 'omsk'),
('novgorod', 'kazan'),
('irkutsk', 'moscow'),
('omsk','irkutsk'),
('moscow','kazan');

drop table if exists cities;
create table cities (
id serial primary key,
label varchar(20),
name varchar(20)
);
insert into cities (label, name)
values ('moscow', 'Москва'),
('novgorod', 'Новгород'),
('irkutsk', 'Иркутск'),
('omsk','Омск'),
('kazan','Казань');

select from_city_name, to_city_name from
(select f.id as from_id, c.name as from_city_name from flights as f join cities as c on f.from_city = c.label order by f.id) as from_city
join
(select f.id as to_id, c.name as to_city_name from flights as f join cities as c on f.to_city = c.label order by f.id) as to_city
on from_id = to_id
order by from_id;

select
c1.name, c2.name
from flights as f join cities as c1 on (f.from_city = c1.label) join cities as c2 on (f.to_city = c2.label)
order by f.id;
