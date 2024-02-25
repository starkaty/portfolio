/*1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. 
Используйте транзакции.*/

/*"переместить" понимаем как добавить к имеющимся строкам одной таблицы и удалить из другой таблицы 
(новая запись не заменит запись с id = 1 таблицы sample, а лишь будет добавлена)
Tак как в таблице sample.users у нас всего два столбца: id и name, 
то из таблицы shop.users выберем только те же 2 столбца.*/

start transaction;
insert into sample.users (name) --  id вставлять не будем, так как это поле AI и вставится автоматически после имеющихся id
select name from shop.users where id = 1;
delete from shop.users where id = 1; -- после вставки записи в одну таблицу удаляем ее из другой
commit;

/*2. Создайте представление, которое выводит название name товарной позиции из таблицы products 
и соответствующее название каталога name из таблицы catalogs.*/

use shop;
create or replace view prod_cat(prod_name, cat_name) as
select 
	p.name, c.name
	from products p left join catalogs c
	on c.id = p.catalog_id;

/* 3. (по желанию) Пусть имеется таблица с календарным полем created_at. 
В ней размещены разряженые календарные записи за август 2018 года 
'2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17. 
Составьте запрос, который выводит полный список дат за август, 
выставляя в соседнем поле значение 1, если дата присутствует в исходном таблице и 0, если она отсутствует.*/

use sample; -- используем для задания БД sample
drop table if exists august_dates; -- создаем исходную таблицу
create table august_dates(
created_at date);
insert into august_dates(created_at)
values
('2018-08-01'), ('2018-08-04'), ('2018-08-16'), ('2018-08-17');
 
 delimiter //
 drop temporary table if exists aug_dates//
 create temporary table aug_dates(created_at date)// -- создадим временную таблицу для заполнения ее всеми датами августа 2018
 
 drop procedure if exists sp_fill_aug_dates// -- создадим процедуру заполнения временной таблицы датами августа
 create procedure sp_fill_aug_dates()
	begin
		declare aug_date date default '2018-07-31'; -- объявляем переменную дата августа
		while aug_date < '2018-08-31' do -- в цикле меняем значение переменной и заносим новое значение во временную таблицу
			set aug_date = adddate(aug_date, 1);
			insert into aug_dates(created_at) values(aug_date);
		end while;
	end//
call sp_fill_aug_dates()// -- вызываем процедуру заполнения временной таблицы

delimiter ;
select -- создаем запрос из исходной таблицы и временной таблицы дат августа
	tad.created_at,
    if (ad.created_at is null, '0', '1') as 'in_august_dates'
    from
	aug_dates tad left join august_dates ad on tad.created_at = ad.created_at;
drop procedure if exists sp_fill_aug_dates; -- процедура создавалась для временной таблицы, поэтому ее удаляем после использования

 
/*4.(по желанию) Пусть имеется любая таблица с календарным полем created_at. 
Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.*/

use sample; -- используем для задания БД sample
drop table if exists five_dates; -- создаем исходную таблицу
create table five_dates(
created_at date);
insert into five_dates(created_at)
values
('2018-08-01'), ('2018-08-04'), ('2018-08-16'), ('2018-08-17'),
('2018-08-02'), ('2018-08-03'), ('2018-08-05'), ('2018-08-06');

drop temporary table if exists five_dates_temp; -- создадим временную таблицу для записей, которые удалять не нужно
create temporary table five_dates_temp(created_at date);
insert into five_dates_temp(created_at)
select created_at from five_dates order by created_at desc limit 5;

delete from five_dates 
where created_at not in (select created_at from five_dates_temp); -- удалим все записи, которые не вошли во временную таблицу 


/*Практическое задание по теме “Хранимые процедуры и функции, триггеры"
1.
Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", 
с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".
*/

use sample; -- ипользуем БД sample для сохранения в ней функции
delimiter //
drop function if exists hello//
create function hello()
returns text no sql -- функция не запрашивает данные таблиц, а просто делает расчет, поэтому no sql
begin
	declare hello text;
	case
		when hour(curtime()) between 6 and 11 then
        set hello = 'Доброе утро';
        when hour(curtime()) between 12 and 17 then
        set hello = 'Добрый день';
        when hour(curtime()) between 18 and 23 then
        set hello = 'Добрый вечер';
        else
        set hello = 'Доброй ночи';
	end case;
    return hello;
end//
delimiter ;
select hello(); -- проверяем работу функции

/* 2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
Допустимо присутствие обоих полей или одно из них. 
Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
При попытке присвоить полям NULL-значение необходимо отменить операцию.*/

use shop;

delimiter //
drop trigger if exists check_null_name_descr//
create trigger check_null_name_descr before insert on products for each row
begin
	if (new.name is null and new.description is null) then
		signal sqlstate '45000' set message_text = 'Name and description may not be both "NULL"';
	end if;
end//

insert into products(name, description, catalog_id, created_at, updated_at) -- проверка работы триггера
values(null, null, 1, now(), now());

/*3. (по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. 
Числами Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел. 
Вызов функции FIBONACCI(10) должен возвращать число 55.*/

use sample;
drop function if exists fibonacci;
delimiter //
create function fibonacci(f_num_count int)
returns bigint deterministic -- число Фибоначчи при одном и том же параметре будет одинаковым
begin
	declare a0 int default 0;
    declare a1 int default 1;
    declare n int default 2;  -- счетчик
	if f_num_count = 0 then set a1 = 0;
    elseif f_num_count = 1 then set a1 = a1; 
    else
		while n <= f_num_count do
            set a1 = a0 + a1;
            set a0 = a1 - a0;
            set n = n + 1;
		end while;	
	end if;
	return a1;
end//
delimiter ;
select fibonacci(10); -- проверяем работу функции