/*Практическое задание по теме “Оптимизация запросов”
1) Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, 
catalogs и products в таблицу logs помещается время и дата создания записи, 
название таблицы, идентификатор первичного ключа и содержимое поля name.*/
use shop;
drop table if exists logs;
create table logs (
created_at datetime default now(), 
table_name varchar(50),
row_id bigint unsigned not null,
name varchar(255)
) engine = ARCHIVE;

drop trigger if exists log_trigger_users;
delimiter //
create trigger log_trigger_users
after insert on users 
for each row begin
	insert into logs(table_name, row_id, name)
    values('users', new.id, new.name);
end//
delimiter ;  

drop trigger if exists log_trigger_catalogs;
delimiter //
create trigger log_trigger_catalogs
after insert on catalogs 
for each row begin
	insert into logs(table_name, row_id, name)
    values('catalogs', new.id, new.name);
end//
delimiter ;  

drop trigger if exists log_trigger_products;
delimiter //
create trigger log_trigger_products
after insert on products 
for each row begin
	insert into logs(table_name, row_id, name)
    values('products', new.id, new.name);
end//
delimiter ;

-- проверки:
INSERT INTO users(name, birthday_at, created_at, updated_at) VALUES ('aburisa','1991-09-27', now(), now());
INSERT INTO catalogs(name) VALUES ('osambu');
INSERT INTO products(name, description, price, catalog_id, created_at, updated_at) VALUES ('utatem', NULL, 7000, 1, now(), now());

/*2) Создайте SQL-запрос, который помещает в таблицу users миллион записей. (изначально в таблице 0 пользователей)*/

truncate users; -- очистим таблицу, чтобы занести в нее записи
insert into users (name, birthday_at) -- заполним первые 10 записей
values('a', '2000-10-02'),
('a', '2000-10-02'),
('b', '2000-10-02'),
('c', '2000-10-02'),
('d', '2000-10-02'),
('e', '2000-10-02'),
('f', '2000-10-02'),
('g', '2000-10-02'),
('h', '2000-10-02'),
('i', '2000-10-02');

insert into users (name, birthday_at) -- вставим остальные записи
select u1.name, u1.birthday_at
from
users u1
cross join users u2
cross join users u3
cross join users u4
cross join users u5
cross join users u6;

