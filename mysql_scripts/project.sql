/* База данных "Российская кинологическая федерация".

Содержит информацию о породах собак, собаках, питомниках, их владельцах, 
родословных щенков, выставках, судьях и титулах, полученных собаками на выставках.
Также содержит таблицу учета перехода прав собственности на собак (от рождения щенка до последнего хозяина).

Решает задачи хранения, учета и анализа всех данных, входящих в сферу деятельности и контроля РКФ.
Позволяет анализировать популяцию, сроки жизни, развитие породы и успехи конкретных представителей породы,
Позволяет оценить, какие питомники успешно проводят племенную работу, какие их выпускники получают титулы,
и при дальнейшем разведени улучшают породу. Позволяет анализировать численность щенков в пометах питомникав, а также
количество свободных к продаже щенков, выдавать лицензии питомникам на осуществление племенной работы или отзыв лицензий в
случае отсутствия работы или ее низкого качества.

Данные занесены вручную для дальнейшего обеспечения проведения аналитических процедур и наличия необходимых выборок.
*/

/*В базе данных индексы заданы в учебных целях. Т.к.данных в БД не много, в индексах нет необходимости, 
поскольку они требуют использования дополнительных ресурсов системы.*/

drop database if exists rcf;
create database rcf;
use rcf;

drop table if exists breeds; -- таблица пород и породных групп (собаки), таблица небольшая, индексы не требуются
create table breeds(
	id serial primary key,
	name varchar(50),
	origin_country varchar(50),
	breed_group varchar(100),
	created_at datetime default now(),
	updated_at datetime default now()
);
insert into breeds(name, origin_country, breed_group)
values ('Бельгийская овчарка','Бельгия','Пастушьи и скотогонные собаки, кроме швейцарских скотогонных собак'),
('Уиппет','Великобритания','Борзые'),
('Английский бульдог','Великобритания','Пинчеры и шнауцеры, молоссы, горные и швейцарские скотогонные собаки'),
('Французский бульдог','Франция','Декоративные и собаки-компаньоны'),
('Бишон фризе','Франция','Декоративные и собаки-компаньоны'),
('Грейхаунд','Великобритания','Борзые'),
('Австралийская овчарка','Австралия','Пастушьи и скотогонные собаки, кроме швейцарских скотогонных собак'),
('Вельш-корги-пемброк','Великобритания','Пастушьи и скотогонные собаки, кроме швейцарских скотогонных собак'),
('Русская псовая борзая','Россия','Борзые'),
('Самоед','Россия','Шпицы и примитивные породы'),
('Бордер-колли','Великобритания','Пастушьи и скотогонные собаки, кроме швейцарских скотогонных собак'),
('Левретка','Италия','Борзые'),
('Ризеншнауцер','Германия','Пинчеры и шнауцеры, молоссы, горные и швейцарские скотогонные собаки'),
('Пудель','Франция','Декоративные и собаки-компаньоны'),
('Мопс','Китай','Декоративные и собаки-компаньоны'),
('Салюки','Ближний Восток','Борзые'),
('Золотистый ретривер','Великобритания','Ретриверы, спаниели и водяные собаки'),
('Веймаранер','Германия','Легавые'),
('Русская гончая','Россия','Гончие и родственные породы'),
('Сибирский хаски','Россия','Шпицы и примитивные породы');

drop table if exists users; -- таблица участников - владельцы собак, заводчики, судьи на выставках, сотрудники РКФ
create table users (
	id serial primary key,
    firstname varchar(50) comment 'Имя',
    lastname varchar(50) comment 'Фамилия',
    email varchar(50) unique,
    phone bigint,
    adress varchar(100),
    birthday date,
    is_deleted bit default 0,
    index users_fn_ln_idx(firstname, lastname) -- для поиска по имени и фамилии
);

insert into users(firstname, lastname, email, phone, adress, birthday)
values 
('Анна', 'Иванова', 'anna@mail.ru', '12345678', 'qwery, 1-2-3', '1999-12-11'),
('Петр', 'Иванов', 'petr@mail.ru', '22345678', 'qwery, 2-2-3', '1998-10-10'),
('Алина', 'Петрова', 'alina@mail.ru', '12345673', 'qwery, 5-2-3', '2000-12-11'),
('Нина', 'Петрова', 'nina@mail.ru', '12345675', 'qwery, 6-2-3', '2001-08-11'),
('Антон', 'Антонов', 'anton@mail.ru', '62345673', 'qwery, 7-2-3', '2002-06-11'),
('Сергей', 'Сергеев', 'serg@mail.ru', '82345673', 'qwery, 8-2-3', '1968-05-11'),
('Дмитрий', 'Дмитриевич', 'dmit@mail.ru', '88345673', 'qwery, 9-2-3', '2000-12-03'),
('Андрей', 'Андреевич', 'andr@mail.ru', '33345673', 'qwery, 10-2-3', '1988-12-11'),
('Алексей', 'Алексеев', 'alexey@mail.ru', '55545673', 'qwery, 11-2-3', '1995-01-01'),
('Маргарита', 'Матвева', 'margo@mail.ru', '55545673', 'qwery, 12-2-3', '1996-12-11'),
('Максим', 'Максимов', 'max@mail.ru', '99945673', 'qwery, 13-2-3', '1993-07-01'),
('Роман', 'Романов', 'roman@mail.ru', '11145673', 'qwery, 14-2-3', '1990-12-11'),
('Александр', 'Александров', 'alex@mail.ru', '66645673', 'qwery, 15-2-3', '1997-02-10'),
('Александр', 'Петров', 'alp@mail.ru', '12345655', 'qwery, 16-2-3', '1958-12-11'),
('Степан', 'Степанов', 'step@mail.ru', '12399973', 'qwery, 5-12-3', '1950-02-01'),
('Мария', 'Сусликова', 'suslik@mail.ru', '12311173', 'qwery, 5-16-3', '2001-12-11'),
('Алладин', 'Алладинов', 'allad@mail.ru', '12345111', 'qwery, 65-1-3', '1998-02-12'),
('Заяц', 'Зайцев', 'zay@mail.ru', '19995673', 'qwery, 23-17-3', '1985-12-11'),
('Алина', 'Земляникина', 'zemlia@mail.ru', '12888673', 'qwery, 85-2-3', '2002-03-18'),
('Антонина', 'Петухова', 'pet@mail.ru', '12347773', 'qwery, 44-44-23', '1982-08-08'),
('Максим', 'Симонов', 'maxs@mail.ru', '99955673', 'qwery, 23-2-3', '1993-07-01'),
('Петр', 'Романов', 'romanp@mail.ru', '11745673', 'qwery, 44-2-3', '1990-02-11'),
('Артемон', 'Артемонов', 'art@mail.ru', '16645673', 'qwery, 85-2-3', '1997-02-10'),
('Александр', 'Дмитриев', 'ald@mail.ru', '12345755', 'qwery, 76-2-3', '1958-12-11'),
('Степан', 'Смирнов', 'stepsm@mail.ru', '19399973', 'qwery, 45-12-3', '1950-02-01'),
('Дарья', 'Сусликова', 'dsuslik@mail.ru', '12371173', 'qwery, 95-16-3', '2001-12-11'),
('Алладин', 'Мишуткин', 'alladm@mail.ru', '12345911', 'qwery, 85-1-3', '1998-02-12'),
('Заяц', 'Медведев', 'zaymed@mail.ru', '19997673', 'qwery, 43-17-3', '1985-12-11'),
('Ангелина', 'Земляникина', 'zemliaa@mail.ru', '12988673', 'qwery, 105-2-3', '2002-03-18'),
('Антонина', 'Курочкина', 'hen@mail.ru', '12947773', 'qwery, 144-44-23', '1982-08-08')
;

drop table if exists kennels; -- таблица питомники
create table kennels(
	id serial primary key,
	name varchar(30) unique,
	adress varchar(100),
	phone bigint, -- для данного проекта полагаем, что телефон у питомника один
    owner_id bigint unsigned not null, -- для данного проекта полагаем, что владелец у питомника один
    email varchar(50) unique,-- для данного проекта полагаем, что у питомника один email
    internet_page varchar(50) unique,
	created_at datetime default now(),-- дата создания питомника
	is_closed bit default 0, -- если питомник не действующий, значение будет 1
	foreign key (owner_id) REFERENCES users(id) on update cascade on delete cascade,
    index kennels_created_idx(created_at), -- индекс для поиска и сортировке питомников по дате создания
    unique index kennels_name_idx(name) -- индекс для поиска и сортировке питомников названию (оно должно быть уникальное)
);

insert into kennels(name, adress, email, phone, internet_page, created_at, owner_id)
values 
('Step', 'Poiu, 12-23', 'step@mail.ru', '12445678', 'www.step.ru', '1999-12-11 17:27:00', 1),
('Lukomorye', 'Vass, 12-55', 'luk@mail.ru', '92445678', 'www.luko.ru', '2011-01-11 17:27:00', 5),
('Beliy veter', 'Vereteno, 103-23', 'veter@mail.ru', '91445678', 'www.veter.ru', '2010-03-11 17:27:00', 6),
('Sokol', 'Serovo, 15-43', 'sero@mail.ru', '12498678', 'www.sero.ru', '2005-12-11 17:27:00', 7),
('Utep', 'Toiu, 12-23', 'utep@mail.ru', '12445670', 'www.utep.ru', '1993-10-11 17:27:00', 10),
('Mukomorye', 'Mass, 22-55', 'muk@mail.ru', '90445678', 'www.muko.ru', '2019-01-11 17:27:00', 15),
('Silniy veter', 'Miteno, 20-23', 'silve@mail.ru', '91045678', 'www.sveter.ru', '2004-03-11 17:27:00', 19),
('Mordochki', 'Vasino, 105-43', 'mord@mail.ru', '12498608', 'www.mord.ru', '2018-12-11 17:27:00', 17),
('Morkovky', 'Fasino, 105-43', 'mork@mail.ru', '17498608', 'www.mork.ru', '1999-12-11 17:27:00', 18),
('Marusya', 'Rasino, 105-43', 'maru@mail.ru', '18498608', 'www.maru.ru', '1999-12-11 17:27:00', 20);

drop table if exists kennels_breeds; -- таблица питомники-породы обеспечивает связь многие ко многим
-- питомники, которые имеют право осуществлять племенную работу по определенным породам
create table kennels_breeds(
	kennel_id bigint unsigned not null,
    breed_id bigint unsigned not null,
    
    primary key (kennel_id, breed_id),    
    foreign key (kennel_id) REFERENCES kennels(id) on update cascade on delete cascade,
    foreign key (breed_id) REFERENCES breeds(id) on update cascade on delete cascade
);

insert into kennels_breeds(kennel_id, breed_id)
values
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,8),
(1,9),
(2,10),
(3,11),
(4,12),
(5,13),
(6,14),
(7,15),
(8,16),
(1,17),
(2,18),
(3,19),
(4,20),
(8,1),
(7,2),
(6,3),
(5,4),
(4,5),
(3,6),
(2,7),
(1,8),
(7,10),
(6,11),
(5,12),
(4,13),
(3,14),
(2,15),
(1,16),
(8,17),
(7,18),
(6,19),
(5,20),
(4,1),
(6,5),
(7,8),
(8,9),
(9,9),
(10,10);

drop table if exists dogs; -- таблица учета собак
create table dogs(
	id serial primary key,
	name varchar(50),
    birthday date,
    gender enum ('m', 'f'), 
    color varchar(50),
    description text,
	breed_id bigint unsigned not null,
    kennel_id bigint unsigned not null, -- id питомника, в котором родилась собака
    end_date date default null,-- дата конца жизни собаки позволит учитывать и анализировать историю развития породы, родословные и работу питомников

    foreign key (breed_id) REFERENCES breeds(id) on update cascade on delete cascade,
    foreign key (kennel_id) REFERENCES kennels(id) on update cascade on delete cascade,
    index dogs_birthday_gender_idx(birthday, gender) -- для поиска и сортировки по возрасту и полу
);

insert into dogs(name, birthday, gender, color, description, breed_id, kennel_id, end_date)
values
('bob', '2021-10-10', 'm', 'black', 'qweet', 1, 1, null),
('boba', '2021-10-10', 'f', 'black', 'qwert', 1, 1, null),
('quob', '2018-10-10', 'm', 'white', 'qweet', 1, 1, null),
('toba', '2015-10-10', 'f', 'black and white', 'qwert', 8, 1, null),
('tob', '2019-10-10', 'm', 'black and grey', 'qweet', 8, 1, null),
('moba', '2011-10-10', 'f', 'white and brown', 'qwert', 8, 1, null),
('muob', '2018-10-10', 'm', 'white and pink', 'qweet', 17, 1, null),
('ruoba', '2017-10-10', 'f', 'black and white', 'qwert', 17, 1, null),
('puob', '2020-10-10', 'm', 'white and pink', 'qweet', 17, 1, null),
('puoba', '2020-10-10', 'f', 'black and white', 'qwert', 17, 1, null),
('guob', '2020-10-10', 'm', 'white and pink', 'qweet', 17, 1, null),
('guoba', '2020-10-10', 'f', 'black and white', 'qwert', 17, 1, null),
('wob', '2018-10-10', 'm', 'black', 'qweet', 1, 1, null),
('woba', '2018-10-10', 'f', 'black', 'qwert', 1, 1, null),
('duob', '2021-10-10', 'm', 'white', 'qweet', 1, 1, null),
('doba', '2021-10-10', 'f', 'black and white', 'qwert', 8, 1, null),
('tob', '2021-10-10', 'm', 'black and grey', 'qweet', 8, 1, null),
('moba', '2021-10-10', 'f', 'white and brown', 'qwert', 8, 1, null),
('muob', '2021-10-10', 'm', 'white and pink', 'qweet', 17, 1, null),
('ruoba', '2021-10-10', 'f', 'black and white', 'qwert', 17, 1, null),
('puob', '2021-10-10', 'm', 'white and pink', 'qweet', 17, 1, null),
('puoba', '2021-10-10', 'f', 'black and white', 'qwert', 17, 1, null),
('guob', '2021-10-10', 'm', 'white and pink', 'qweet', 17, 1, null),
('guoba', '2021-10-10', 'f', 'black and white', 'qwert', 17, 1, null),
('bob', '2020-10-10', 'm', 'black', 'qweet', 2, 2, null),
('boba', '2021-10-10', 'f', 'black', 'qwert', 2, 2, null),
('quob', '2018-10-10', 'm', 'white', 'qweet', 7, 2, null),
('toba', '2015-10-10', 'f', 'black and white', 'qwert', 7, 2, null),
('tob', '2019-10-10', 'm', 'black and grey', 'qweet', 10, 2, null),
('moba', '2011-10-10', 'f', 'white and brown', 'qwert', 10, 2, null),
('muob', '2018-10-10', 'm', 'white and pink', 'qweet', 10, 2, null),
('ruoba', '2017-10-10', 'f', 'black and white', 'qwert', 10, 2, null),
('cob', '2016-10-10', 'm', 'black', 'qweet', 2, 2, null),
('coba', '2016-10-10', 'f', 'black', 'qwert', 2, 2, null),
('nuob', '2021-10-10', 'm', 'white', 'qweet', 7, 2, null),
('noba', '2021-10-10', 'f', 'black and white', 'qwert', 7, 2, null),
('kob', '2021-10-10', 'm', 'black and grey', 'qweet', 10, 2, null),
('koba', '2021-10-10', 'f', 'white and brown', 'qwert', 10, 2, null),
('luob', '2021-10-10', 'm', 'white and pink', 'qweet', 10, 2, null),
('luoba', '2021-10-10', 'f', 'black and white', 'qwert', 10, 2, null),
('bob', '2021-10-10', 'm', 'black', 'qweet', 3, 3, null),
('boba', '2021-10-10', 'f', 'black', 'qwert', 3, 3, null),
('quob', '2018-10-10', 'm', 'white', 'qweet', 3, 3, null),
('toba', '2015-10-10', 'f', 'black and white', 'qwert', 3, 3, null),
('tob', '2019-10-10', 'm', 'black and grey', 'qweet', 3, 3, null),
('moba', '2011-10-10', 'f', 'white and brown', 'qwert', 3, 3, '2020-10-05'),
('muob', '2018-10-10', 'm', 'white and pink', 'qweet', 6, 3, null),
('ruoba', '2017-10-10', 'f', 'black and white', 'qwert', 6, 3, null),
('puob', '2020-10-10', 'm', 'white and pink', 'qweet', 6, 3, null),
('puoba', '2020-10-10', 'f', 'black and white', 'qwert', 6, 3, null),
('guob', '2020-10-10', 'm', 'white and pink', 'qweet', 6, 3, null),
('guoba', '2020-10-10', 'f', 'black and white', 'qwert',6, 3, null),
('wob', '2018-10-10', 'm', 'black', 'qweet', 3, 3, null),
('woba', '2018-10-10', 'f', 'black', 'qwert', 3, 3, null),
('duob', '2021-10-10', 'm', 'white', 'qweet', 3, 3, null),
('doba', '2021-10-10', 'f', 'black and white', 'qwert', 6, 3, null),
('tob', '2021-10-10', 'm', 'black and grey', 'qweet', 6, 3, null),
('moba', '2021-10-10', 'f', 'white and brown', 'qwert', 6, 3, null),
('muob', '2021-10-10', 'm', 'white and pink', 'qweet', 6, 3, null),
('ruoba', '2021-10-10', 'f', 'black and white', 'qwert', 6, 3, null),
('puob', '2021-10-10', 'm', 'white and pink', 'qweet', 6, 3, null),
('puoba', '2021-10-10', 'f', 'black and white', 'qwert', 6, 3, null),
('guob', '2021-10-10', 'm', 'white and pink', 'qweet', 6, 3, null),
('guoba', '2021-10-10', 'f', 'black and white', 'qwert', 6,3, null),
('bob', '2021-10-10', 'm', 'black', 'qweet', 12, 4, null),
('boba', '2021-10-10', 'f', 'black', 'qwert', 12, 4, null),
('quob', '2018-10-10', 'm', 'white', 'qweet', 12, 4, null),
('toba', '2015-10-10', 'f', 'black and white', 'qwert', 12, 4, null),
('tob', '2019-10-10', 'm', 'black and grey', 'qweet', 12, 4, null),
('moba', '2011-10-10', 'f', 'white and brown', 'qwert', 12, 4, '2022-01-20'),
('muob', '2018-10-10', 'm', 'white and pink', 'qweet', 12, 4, null),
('ruoba', '2017-10-10', 'f', 'black and white', 'qwert', 12, 4, null),
('puob', '2020-10-10', 'm', 'white and pink', 'qweet', 12, 4, null),
('puoba', '2020-10-10', 'f', 'black and white', 'qwert', 12, 4, null),
('guob', '2020-10-10', 'm', 'white and pink', 'qweet', 12, 4, null),
('guoba', '2020-10-10', 'f', 'black and white', 'qwert',12, 4, null),
('wob', '2018-10-10', 'm', 'black', 'qweet', 13, 4, null),
('woba', '2018-10-10', 'f', 'black', 'qwert', 13, 4, null),
('duob', '2021-10-10', 'm', 'white', 'qweet', 13, 4, null),
('doba', '2021-10-10', 'f', 'black and white', 'qwert', 13, 4, null),
('tob', '2021-10-10', 'm', 'black and grey', 'qweet', 13, 4, null),
('moba', '2021-10-10', 'f', 'white and brown', 'qwert', 13, 4, null),
('muob', '2021-10-10', 'm', 'white and pink', 'qweet', 13, 4, null),
('ruoba', '2021-10-10', 'f', 'black and white', 'qwert', 13, 4, null),
('puob', '2021-10-10', 'm', 'white and pink', 'qweet', 13, 4, null),
('puoba', '2021-10-10', 'f', 'black and white', 'qwert', 13, 4, null),
('guob', '2021-10-10', 'm', 'white and pink', 'qweet', 13, 4, null),
('guoba', '2021-10-10', 'f', 'black and white', 'qwert', 13,4 , null);

drop table if exists dog_owners; -- таблица учета прав собственности на собак
create table dog_owners(
	id serial primary key,
	number varchar(30) comment 'номер документа, удостоверяющего переход прав собственности на животное', -- в номере договора могут быть буквы, поэтому не int
    description text, -- описание документа
    contract_date date, -- дата заключения договора/создания документа
    from_owner_id bigint unsigned default null, -- если это первая запись о собственности на животное, графа остается с значением null
    to_owner_id bigint unsigned not null, -- если это первая запись о собственности на животное, ставится id заводчика/первого собственика щенка
    dog_id bigint unsigned not null,
    created_at datetime default now(), -- дата внесения документа в базу

    foreign key (to_owner_id) REFERENCES users(id) on update cascade on delete cascade,
    foreign key (from_owner_id) REFERENCES users(id) on update cascade on delete cascade,
    foreign key (dog_id) REFERENCES dogs(id) on update cascade on delete cascade
);

insert into dog_owners(number, description, contract_date, from_owner_id, to_owner_id, dog_id)
values
('123', 'zxcv', '2021-10-10', null, 1, 1),
('124', 'zxcvm', '2021-12-10', 1, 30, 1),
('124', 'zxcvm', '2022-02-10', 30, 20, 1),
('122', 'сzxcv', '2021-10-10', null, 1, 2),
('125', 'сzxcvm', '2021-12-10', 1, 17, 2),
('250', 'azxcv', '2020-10-10', null, 5, 25),
('251', 'azxcv', '2020-10-10', 5, 19, 25),
('350', 'zxkcv', '2021-10-10', null, 5, 35),
('351', 'zykcv', '2021-10-10', 5, 15, 35),
('160', 'uzxkcv', '2021-10-10', null, 1, 16),
('161', 'tuzxkcv', '2021-10-10', 1, 6, 16),
('162', 'gtuzxkcv', '2022-05-10', 6, 30, 16),
('163', 'ytuzxkcv', '2022-06-10', 17, 20, 14);

drop table if exists pedigrees; -- таблица учета родословных
create table pedigrees(
	id serial primary key,
	number varchar(30) comment 'номер', -- в номере родословной могут быть буквы, поэтому не int
    description text, -- описание
    dog_id bigint unsigned not null, -- id щенка
    parent_m_id bigint unsigned not null, -- id отца
    parent_f_id bigint unsigned not null, -- id матери
    litter_of_puppies varchar(10), -- помет щенков, буква
    created_at datetime default now(), -- дата внесения в базу ркф
    updated_at datetime default now(), -- дата внесения изменений

    foreign key (parent_f_id) REFERENCES dogs(id) on update cascade on delete cascade,
    foreign key (parent_m_id) REFERENCES dogs(id) on update cascade on delete cascade,
    foreign key (dog_id) REFERENCES dogs(id) on update cascade on delete cascade
);

insert into pedigrees(number, description, dog_id, parent_m_id, parent_f_id, litter_of_puppies)
values
('111', 'asdf', 1, 3, 14, 'A'),
('112', 'gasdf', 2, 3, 14, 'A'),
('113', 'hasdf', 15, 3, 14, 'A'),
('114', 'nhasdf', 16, 5, 4, 'B'),
('115', 'nahsdf', 17, 5, 4, 'B'),
('116', 'nashdf', 18, 5, 4, 'B'),
('017', 'ngasedf', 9, 7, 8, 'F'),
('018', 'najsedf', 10, 7, 8, 'F'),
('019', 'nasledf', 11, 7, 8, 'F'),
('020', 'ncasedf', 12, 7, 8, 'F'),
('021', 'anagsedf', 19, 7, 8, 'G'),
('022', 'nsagsedf', 20, 7, 8, 'G'),
('023', 'nacgsedf', 21, 7, 8, 'G'),
('024', 'nagvsedf', 22, 7, 8, 'G'),
('025', 'nagsbedf', 23, 7, 8, 'G'),
('026', 'lnagsendf', 24, 7, 8, 'G'),
('027', 'xynagsendf', 37, 31, 32, 'C'),
('028', 'vynagsendf', 38, 31, 32, 'C'),
('029', 'bynagsendf', 39, 31, 32, 'C'),
('030', 'nynagsendf', 40, 31, 32, 'C');

drop table if exists dog_photo; -- таблица фото животных
create table dog_photo(
	id serial primary key,
	user_id bigint unsigned not null, -- владелец фото
    dog_id bigint unsigned not null, -- животное
    body text,
    filename varchar(250),
    size int,
    metadata json,
    created_at datetime default now(), -- дата и время размещения фото
    
    foreign key (dog_id) REFERENCES dogs(id) on update cascade on delete cascade,
    foreign key (user_id) REFERENCES users(id) on update cascade on delete cascade
    );

insert into dog_photo(user_id, dog_id, body, filename, size, metadata)
values
(1, 1, 'qqq', 'qwe.jpg', 12, '{"12":12}'),
(1, 2, 'lqqq', 'qwle.jpg', 11, '{"17":12}'),
(1, 5, 'qqqj', 'qjwe.jpg', 30, '{"30":12}'),
(1, 7, 'uqqq', 'uqwe.jpg', 72, '{"72":12}'),
(1, 8, 'cqqq', 'cqwe.jpg', 42, '{"82":12}'),
(1, 9, 'lcqqq', 'cqwle.jpg', 31, '{"47":12}'),
(1, 10, 'qcqqj', 'cqjwe.jpg', 20, '{"35":12}'),
(1, 11, 'uqcqq', 'uqqwe.jpg', 62, '{"75":12}'),
(5, 21, 'qqq', 'bqwe.jpg', 12, '{"12":12}'),
(5, 22, 'lqqq', 'bqwle.jpg', 11, '{"17":12}'),
(5, 25, 'qqqj', 'bqjwe.jpg', 30, '{"30":12}'),
(5, 27, 'uqqq', 'buqwe.jpg', 72, '{"72":12}'),
(5, 38, 'cqqq', 'bcqwe.jpg', 42, '{"82":12}'),
(5, 39, 'lcqqq', 'bcqwle.jpg', 31, '{"47":12}'),
(5, 40, 'qcqqj', 'bcqjwe.jpg', 20, '{"35":12}'),
(5, 31, 'uqcqq', 'buqqwe.jpg', 62, '{"75":12}')
;

drop table if exists dog_shows; -- выставки
create table dog_shows(
	id serial primary key,
    name varchar(50),
    place varchar (100), -- адрес проведения
    show_date datetime default null,
    status enum ('planned', 'held', 'cancelled'),
    created_at datetime default now(),
    updated_at datetime default now(),
    index show_date_idx(show_date), -- для поиска и сортировки выставок по дате проведения
    index show_name_idx(name) -- для поиска по названию выставки
);

insert into dog_shows(name, place, show_date, status, created_at)
values
('windy plain', 'asd, 12-22', '2018-01-02', 'held', '2017-10-10'),
('cloudy sky', 'asd, 12-22', '2019-01-02', 'held', '2018-10-10'),
('rainforest', 'asd, 12-22', '2020-01-02', 'held', '2019-10-10'),
('sunny wind', 'asd, 12-22', '2021-01-02', 'held', '2020-10-10'),
('pretty tail', 'asd, 12-22', '2017-01-02', 'held', '2016-10-10'),
('sunny plain', 'asd, 12-22', '2018-11-02', 'held', '2017-10-10'),
('sunny sky', 'asd, 12-22', '2019-11-02', 'held', '2018-10-10'),
('rainy rainforest', 'asd, 12-22', '2020-11-02', 'held', '2019-10-10'),
('autumn wind', 'asd, 12-22', '2021-11-02', 'held', '2020-10-10'),
('pretty paw', 'asd, 12-22', '2017-11-02', 'held', '2016-10-10'),
('pretty paw', 'asd, 12-22', '2022-05-02', 'held', '2021-10-10');

drop table if exists shows_judges; -- хранит информацию о судьях, работавших на выставках по различным породам
create table shows_judges(
	id serial primary key,
    judge_id bigint unsigned not null, -- судья
    show_id bigint unsigned not null, -- выставка
    breed_id bigint unsigned not null, -- порода, с которой работает судья
    foreign key (judge_id) REFERENCES users(id) on update cascade on delete cascade,
    foreign key (show_id) REFERENCES dog_shows(id) on update cascade on delete cascade,
    foreign key (breed_id) REFERENCES breeds(id) on update cascade on delete cascade
);

insert into shows_judges(judge_id, show_id, breed_id)
values
(21, 1, 1),
(21, 1, 2),
(22, 1, 3),
(23, 1, 4),
(24, 1, 5),
(25, 1, 6),
(26, 1, 7),
(27, 1, 8),
(28, 1, 9),
(29, 1, 10),
(30, 1, 11),
(14, 1, 12),
(14, 1, 13),
(2, 1, 14),
(3, 1, 15),
(4, 1, 16),
(8, 1, 17),
(9, 1, 18),
(11, 1, 19),
(12, 1, 20),
(23, 2, 1),
(21, 2, 2),
(22, 2, 3),
(23, 2, 4),
(24, 2, 5),
(25, 2, 6),
(26, 2, 7),
(27, 2, 8),
(28, 2, 9),
(29, 2, 10),
(30, 2, 11),
(2, 2, 12),
(3, 2, 13),
(4, 2, 14),
(8, 2, 15),
(9, 2, 16),
(11, 2, 17),
(12, 2, 18),
(13, 2, 19),
(14, 2, 20),
(20, 10, 1),
(21, 10, 2),
(22, 10, 3),
(23, 10, 4),
(24, 10, 5),
(25, 10, 6),
(26, 10, 7),
(27, 10, 8),
(28, 10, 9),
(29, 10, 10),
(30, 10, 11),
(16, 10, 12),
(8, 10, 13),
(2, 10, 14),
(2, 10, 15),
(2, 10, 16),
(2, 10, 17),
(2, 10, 18),
(3, 10, 19),
(3, 10, 20),
(20, 3, 1),
(21, 3, 2),
(22, 3, 3),
(23, 3, 4),
(24, 3, 5),
(25, 3, 6),
(26, 3, 7),
(27, 3, 8),
(28, 3, 9),
(29, 3, 10),
(30, 3, 11),
(3, 3, 12),
(3, 3, 13),
(3, 3, 14),
(3, 3, 15),
(3, 3, 16),
(3, 3, 17),
(3, 3, 18),
(3, 3, 19),
(3, 3, 20),
(20, 4, 1),
(21, 4, 2),
(22, 4, 3),
(23, 4, 4),
(24, 4, 5),
(25, 4, 6),
(26, 4, 7),
(27, 4, 8),
(28, 4, 9),
(29, 4, 10),
(30, 4, 11),
(3, 4, 12),
(3, 4, 13),
(3, 4, 14),
(3, 4, 15),
(3, 4, 16),
(3, 4, 17),
(3, 4, 18),
(3, 4, 19),
(3, 4, 20),
(20, 11, 1),
(21, 11, 2),
(22, 11, 3),
(23, 11, 4),
(24, 11, 5),
(25, 11, 6),
(26, 11, 7),
(27, 11, 8),
(28, 11, 9),
(29, 11, 10),
(30, 11, 11),
(3, 11, 12),
(3, 11, 13),
(3, 11, 14),
(3, 11, 15),
(3, 11, 16),
(3, 11, 17),
(3, 11, 18),
(3, 11, 19),
(3, 11, 20);

drop table if exists dog_titles; -- титулы собак
create table dog_titles(
	id serial primary key,
    dog_id bigint unsigned not null, -- id собаки
    dog_shows_id bigint unsigned not null, -- выставка, на которой получен титул
    title enum ('best in show', 'best in group', 'best of breed', 'best male', 'best female', 'BOB veteran'),
    
    foreign key (dog_shows_id) REFERENCES dog_shows(id) on update cascade on delete cascade,
    foreign key (dog_id) REFERENCES dogs(id) on update cascade on delete cascade,
    index title_idx(title) -- для поиска и сортировки по титулам
);

insert into dog_titles(dog_id, dog_shows_id, title)
values
(3, 3, 'best in show'),
(3, 2, 'best of breed'),
(3, 4, 'best male'),
(5, 3, 'best of breed'),
(5, 4, 'best male'),
(7, 3, 'best in group'),
(7, 2, 'best of breed'),
(7, 4, 'best male'),
(14, 3, 'best female'),
(14, 2, 'best female'),
(14, 4, 'best female'),
(4, 10, 'best in show'),
(4, 1, 'best of breed'),
(4, 2, 'best of breed'),
(8, 1, 'best in show'),
(8, 2, 'best female'),
(8, 3, 'best female'),
(8, 4, 'best female'),
(32, 1, 'best of breed'),
(32, 2, 'best female'),
(32, 3, 'best of breed'),
(32, 4, 'best female'),
(31, 2, 'best male'),
(31, 3, 'best male'),
(31, 4, 'best male'),
(1, 11, 'best in show'),
(2, 11, 'best female');

