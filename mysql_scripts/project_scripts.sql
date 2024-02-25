
use rcf;
/*Выборки - задачи (скрипты характерных выборок):
1. Рассчитать, сколько собак каждой породы принадлежат питомникам (право собственности на собаку).
Таблица выборки содержит название питомника, породы и количество собак каждой породы.*/

select ken.name as 'kennel', b.name as 'breed', count(*) as cnt from
	(select * from dog_owners where id in (select max(id) from dog_owners group by dog_id)) as d_own -- настоящие владельцы собак
	join
	kennels as ken
	on d_own.to_owner_id = ken.owner_id
    join
    dogs d
    on d.id = d_own.dog_id
    join
    breeds b
    on b.id = d.breed_id
group by ken.name, b.name; 

/*2. Щенки (возраст менее года) каких питомников уже получили титулы на выставках?*/

select distinct k.name from
dog_titles dt
join
dogs d
on d.id = dt.dog_id
join
kennels k
on k.id = d.kennel_id
where timestampdiff(year, d.birthday, now()) < 1;

/*3 Найти, по каким породам ведут племенную работу питомники, которые существуют уже более 10 лет.
Запрос выводит таблицу, в которой указаны поля питомник, дата его создания, породы.
*/
select k.name as kennel, year(k.created_at) as created, group_concat(' ', b.name) as breed 
	from kennels k
	join kennels_breeds kb
	on k.id = kb.kennel_id
	join breeds b
	on b.id = kb.breed_id
where timestampdiff(year, k.created_at, now()) > 10
group by k.name, k.created_at
order by k.created_at; 

/* 4. Вывести всех собак, которые выиграли выставки (получили титул 'best in show') в 2018 году, 
c указанием выставки и именем судьи, который работал с данной породой на выставке.
*/

select d.name as dog, dt.title as title_2018, ds.name as dog_show, concat(u.firstname, ' ', u.lastname) as judge  
from
	dog_titles dt
    join dog_shows ds on ds.id = dt.dog_shows_id
    join dogs d on d.id = dt.dog_id
    join shows_judges sj on d.breed_id = sj.breed_id
    join users u on u.id = sj.judge_id
    
where year(ds.show_date) = 2018 and ds.id = sj.show_id and dt.title = 'best in show';

/*5. Рассчитать количество собак по полу по каждому питомнику-заводчику и породам, 
которые являются родителями щенков (указаны в качестве родителей в родословной)*/

select k.name as kennel, b.name as breed, d.gender as gender, count(*) as cnt_dogs_parents from
pedigrees p
join dogs d on p.parent_m_id = d.id or p.parent_f_id = d.id
join kennels k on k.id = d.kennel_id
join breeds b on b.id = d.breed_id

group by k.name, b.name, d.gender;

/*6. Рассчитать, сколько щенков рождалось в питомниках по породам, сгруппировать по литере помета и полу 
(все щенки одного помета имеют одну букву - литеру для идентификации помета).*/

select k.name as kennel, b.name as breed, p.litter_of_puppies as litter, 
if(d.gender = 'm', 'male puppies', 'female puppies') as gender, count(*) as cnt_puppies 
from
	pedigrees p
    join dogs d on d.id = p.dog_id
	join kennels k on k.id = d.kennel_id
    join breeds b on b.id = d.breed_id
group by k.name, b.name, p.litter_of_puppies, d.gender;

/*Представления.
1. Текущие хозяева собаки.
В базе данных РКФ все документы о переходе прав собственности на собаку учитываются в отдельной
таблице, информация о хозяине на данный момент может быть получена путем сложного запроса,
в связи с чем имеет смысл создать представление для работы с перечнем собак и хозяев собак на данный момент. 
Таблица собака - порода - хозяин (те собаки, информация о новых хозяевах которых еще 
не занесена в раздел хозяева, считаются принадлежащими владельцу питомника-заводчика)*/

create or replace view current_dog_owners (dog_name, birthday, breed, current_owner) as
select d.name as dog_name, d.birthday as birthday, b.name as breed,
/*далее условие если в таблице прав собственности на собаку есть запись о переходе права собственности к
новому владельцу, то указывается последний владелец, если нет, то указывается владелец питомника - заводчика собаки*/
if (d.id in (select dog_id from dog_owners where id in (select max(id) from dog_owners group by dog_id)),
concat(u2.firstname, ' ', u2.lastname), concat(u1.firstname, ' ', u1.lastname)) as current_owner 
from
dogs d
left join
kennels k on k.id = d.kennel_id
left join
users u1 on u1.id = k.owner_id
left join 
(select * from dog_owners where id in (select max(id) from dog_owners group by dog_id)) as don on d.id = don.dog_id
left join
users u2 on u2.id = don.to_owner_id
left join 
breeds b on d.breed_id = b.id;


/* 2. Представление 
Таблица "Рословные" - удобное предствление таблицы pedigrees для пользователя 
(для тех собак, у которых внесены в БД данные о родителях). 
Щенок считается рожденым в питомнике, к которому относится его мать,
при этом отец может быть из другого питомника, эта информация тоже будет отражаться в таблице*/
create or replace view pedigree_names 
(dog_name, breed, birthday, kennel, litter, parent_f_name, parent_m_name, parent_m_kennel) as 
select d1.name as dog_name, b.name as breed, d1.birthday as birthday, k1.name as kennel, p.litter_of_puppies as litter,
d3.name as parent_f_name, d2.name as parent_m_name, k2.name as parent_m_kennel    
from
pedigrees p
join
dogs d1 on d1.id = p.dog_id
join
dogs d2 on d2.id = p.parent_m_id
join
dogs d3 on d3.id = p.parent_f_id
join
breeds b on b.id = d1.breed_id
join
kennels k1 on k1.id = d1.kennel_id
join 
kennels k2 on k2.id = d2.kennel_id;

/*Хранимые процедуры и функции.

1. Добавление собаки. Процедура осуществляет вставку в таблицу dogs, принимаект параметры для вставки. 
Автоматически вставит dreed_id и kennel_id по их именам */

drop procedure if exists dog_add;
delimiter //
create procedure dog_add(
name varchar(100), 
birthday date,
gender enum('f', 'm'),
color varchar(30),
description text,
kennel varchar(30),
breed varchar(50),
end_date date)

begin
	if (select name from kennels where kennels.name = kennel) is not null 
    and (select name from breeds where breeds.name = breed) is not null then -- проверит, что вставляемые название породы и питомника есть в списках таблиц пород и питомников 
		set @kennel_id = (select id from kennels where kennels.name = kennel); -- для вычисления id вставляемого имени питомника
		set @breed_id = (select id from breeds where breeds.name = breed); -- для вычисления id вставляемого названия породы
		insert into dogs (name, birthday, gender, color, description, kennel_id, breed_id, end_date)
		values (name, birthday, gender, color, description, @kennel_id, @breed_id, end_date);
	else select 'Данные некорректны, проверьте название питомника и породы.';
    end if;
end//
delimiter ;
call dog_add('bobby', '2022-09-25', 'm', 'black and white', 'very nice', 'Silniy veter', 'Уиппет', null); -- проверка

/*2. Функция расчета количества собак по конкретному питомнику (рожденные в данном питомнике) */
drop function if exists sum_dogs;
delimiter //
create function sum_dogs (kennel varchar(30))
returns varchar(255) reads sql data
begin
return concat('Количество собак, рожденных в питомнике ', kennel, ': ',
(select count(*) from dogs d join kennels k on d.kennel_id = k.id
where k.name = kennel));
end//
delimiter ;

select sum_dogs('Lukomorye'); -- проверка

/*Триггеры
1. Триггер "Проверка питомник-порода при вставке". Перед вставкой в таблицу dogs проверяет по таблице kennels-breeds, 
есть ли у данного питомника право заниматься племенной работой по этой породе.*/

drop trigger if exists breed_kennel_trigger_insert;
delimiter //
create trigger breed_kennel_trigger_insert
before insert on dogs
for each row begin
	if concat(new.kennel_id, new.breed_id) not in (select concat(kennel_id, breed_id) from kennels_breeds) then
	signal sqlstate '45000' set message_text = 'Данный питомник не имеет лицензии на племенную работу по этой породе. 
    Проверьте данные.';
	end if; 
end//
delimiter ;

call dog_add('bobbyus', '2022-09-28', 'm', 'black and white', 'very nice', 'Step', 'Уиппет', null); -- проверка, выдаст ошибку, так как в таблице kennels_breeds нет такого сочетания kennel_id - breed_id.


/* 2. Триггер Триггер "Проверка питомник-порода при изменении". Перед внесением изменений таблицу dogs проверяет по таблице kennels-breeds, 
есть ли у данного питомника право заниматься племенной работой по этой породе.*/

drop trigger if exists breed_kennel_trigger_update;
delimiter //
create trigger breed_kennel_trigger_update
before update on dogs
for each row begin
	if concat(new.kennel_id, new.breed_id) not in (select concat(kennel_id, breed_id) from kennels_breeds) then
	signal sqlstate '45000' set message_text = 'Данный питомник не имеет лицензии на племенную работу по этой породе. 
    Проверьте данные.';
	end if; 
end//
delimiter ;  
update dogs set kennel_id = 1 where kennel_id = 2; -- проверка, выдает ошибку






/* 3. Триггер Проверка данных для родословной щенка при вводе информации. Проверяет, 
учтены ли щенок и его родители в таблице учета собак, корректно ли выбраны данные о родителях 
по полу (не учтен ли отец собакой женского пола, а мать мужского), щенок и его родители должны быть разнми собаками,
щенок не может быть старше родителей. Данная проверка проводится в учебных целях. Для практического применения 
возможно потребуются дополнительные проверки. */

drop trigger if exists pedigree_trigger_ins;
delimiter //
create trigger pedigree_trigger_ins
before insert on pedigrees 
for each row begin
		if 
			new.dog_id not in (select id from dogs) 
			or new.parent_f_id not in (select id from dogs) 
			or new.parent_m_id not in (select id from dogs) 
            then
			signal sqlstate '45000' set message_text = 'Собаки не учтены в базе. Проверьте данные.';
		elseif
			 (select gender from dogs where id = new.parent_f_id) != 'f' 
             or (select gender from dogs where id = new.parent_m_id) != 'm'
             then
             signal sqlstate '45000' set message_text = 'Данные по полу родителей щенка некорректны.';
		elseif 
			new.dog_id = new.parent_f_id or new.dog_id = new.parent_m_id or new.parent_m_id = new.parent_f_id 
			then
            signal sqlstate '45000' set message_text = 'id щенка и его родителей должны отличаться.';
		elseif 
			(select birthday from dogs where id = new.dog_id) < (select birthday from dogs where id = new.parent_m_id)
            or
            (select birthday from dogs where id = new.dog_id) < (select birthday from dogs where id = new.parent_f_id)
            then 
            signal sqlstate '45000' set message_text = 'Щенок не может быть старше родителей. Проверьте данные';
		end if; 
end//
delimiter ;  

insert into pedigrees (number, description, dog_id, parent_m_id, parent_f_id, litter_of_puppies)
values('031', 'ghjjkl', 98, 33, 34, 'F');

