/*Для целей выполнения и проверки задания была создана база данных warehouse.
В решении использован язык mysql.*/
   
drop database if exists warehouse;

create database warehouse;
use warehouse;

/* Описание таблиц БД: 
 *   1. t_workers (данные по сотрудникам склада):
    • worker_id		- уникальный код сотрудника
    • worker_name		- имя сотрудника
    • worker_start_date	- дата приема сотрудника в штат
    • worker_finish_date 	- дата увольнения сотрудника (NULL, если сотрудник в штате)
    2. t_tasks (данные по выполненным сотрудниками задачам):
    • task_id			- уникальный код задачи
    • worker_id		- внешний ключ (ссылка) на запись таблицы t_workers
    • task_date		- дата выполнения задачи
    • task_name		- наименование задачи*/

-- создание таблиц

drop table if exists t_workers;
create table t_workers(
	worker_id serial primary key,
	worker_name varchar(50),
    worker_start_date datetime default now(), -- дата приема сотрудника в штат
    worker_finish_date datetime default null -- дата увольнения сотрудника (NULL, если сотрудник в штате)
);
    
insert into t_workers(worker_name, worker_start_date, worker_finish_date)
values 
('Иван', '2018.03.01', null),
('Петр', '2019.04.26', '2023.08.10'),
('Павел', '2020.02.15', null),
('Ирина', '2021.11.06', '2023.12.17'); 

drop table if exists t_tasks;
create table t_tasks(
	task_id serial primary key,
	worker_id bigint unsigned not null,	-- внешний ключ (ссылка) на запись таблицы t_workers
	task_date datetime default now(), -- дата выполнения задачи
	task_name varchar(100), -- наименование задачи
    	foreign key (worker_id) REFERENCES t_workers(worker_id) on update cascade on delete cascade);
   
   
insert into t_tasks(worker_id, task_date, task_name)
values 
(1, '2018.03.02', 'Отборка коробов'),
(4, '2022.03.02', 'Отборка коробов'),
(2, '2019.04.27', 'Размещение коробов в зоне хранения'),
(3, '2021.11.07', 'Упаковка коробов для транспортировки'),
(1, '2018.05.02', 'Отборка коробов'),
(1, '2018.06.02', 'Отборка коробов'),
(2, '2019.05.27', 'Размещение коробов в зоне хранения'),
(3, '2021.12.07', 'Упаковка коробов для транспортировки'),
(1, '2022.03.02', 'Отборка коробов'),
(1, '2022.05.02', 'Отборка коробов'),
(2, '2023.04.27', 'Размещение коробов в зоне хранения'),
(3, '2023.11.07', 'Упаковка коробов для транспортировки'),
(3, '2024.06.07', 'Упаковка коробов для транспортировки'),
(1, '2024.06.02', 'Отборка коробов'),
(3, '2024.06.08', 'Отборка коробов'),
(1, '2024.06.10', 'Размещение коробов в зоне хранения'),
(3, '2024.06.11', 'Упаковка коробов для транспортировки'),
(3, '2024.06.07', 'Упаковка коробов для транспортировки'),
(1, '2024.06.02', 'Отборка коробов'),
(3, '2024.06.08', 'Отборка коробов'),
(3, '2024.06.10', 'Размещение коробов в зоне хранения'),
(3, '2024.06.11', 'Упаковка коробов для транспортировки'),
(3, '2024.06.01', 'Упаковка коробов для транспортировки'),
(1, '2024.06.01', 'Отборка коробов'),
(1, '2024.06.08', 'Отборка коробов'),
(1, '2024.06.10', 'Размещение коробов в зоне хранения'),
(3, '2024.06.01', 'Упаковка коробов для транспортировки'),
(3, '2024.06.01', 'Упаковка коробов для транспортировки'),
(1, '2024.06.01', 'Отборка коробов'),
(3, '2024.06.01', 'Отборка коробов'),
(1, '2024.06.01', 'Размещение коробов в зоне хранения'),
(3, '2024.06.01', 'Упаковка коробов для транспортировки');


/* Запросы
 * Задание 1
 * Список сотрудников, работающих по состоянию на определенную дату (report_date, worker_id, worker_name);*/
 
set @report_date = '2024.06.01';
SELECT * FROM t_workers WHERE (worker_start_date <= @report_date) AND (worker_finish_date >= @report_date OR worker_finish_date is NULL);


/* Задание 2. Количество незадействованных сотрудников за текущий месяц по состоянию на каждый день (date, worker_cnt);
    
Для формирования отчета создадим процедуру, которая создаст таблицу дат и рассчитает количество незадействованных сотрудников по состоянию на каждый день текущего месяца.
Для целей задачи полагаем, что незадействованные сотрудники - это не имеющие на день отчета ни одной задачи, задействованные - имеющие одну и более задачу.*/

drop procedure if exists worker_cnt_daily_report;
delimiter //
create procedure worker_cnt_daily_report()
begin
	drop table if exists date_table;    
	CREATE TABLE date_table (
	date_of_month datetime,
	worker_cnt int);
	set @end_date = now();
	set @start_date = DATE_SUB(@end_date, INTERVAL DAYOFMONTH(@end_date)-1 DAY);

	WHILE (@start_date <= @end_date) DO
		INSERT INTO date_table VALUES (@start_date, 
		(select (SELECT count(DISTINCT worker_id) as worker_cnt FROM t_workers WHERE (worker_start_date <= date(@start_date)) 
		AND (worker_finish_date >= date(@start_date) OR worker_finish_date is NULL))
		-
		(select COUNT(DISTINCT worker_id) as busy_workers_number from t_tasks where task_date = date(@start_date)) as cnt_free));
	    	SET @start_date = DATE_ADD(@start_date, INTERVAL 1 DAY);
	END WHILE;	
	select * from date_table;
end//
delimiter ;

CALL worker_cnt_daily_report(); 

 
/* Задание 3. Средняя производительность (количество выполненных задач в день) сотрудников за текущий месяц по состоянию на каждый день (date, avg_worker_power).

Для формирования отчета создадим процедуру, которая создаст таблицу дат и рассчитает среднюю производительность. Полагаем, что необходимо рассчитать, сколько задач в среднем выполнял один сотрудник в каждый день месяца. Учитываем всех работающих по состоянию на определенную дату сотрудников (не только тех, кто получил задание) */
 
 
drop procedure if exists avg_worker_power;
delimiter //
create procedure avg_worker_power()
begin
	drop table if exists date_table_power;    
	CREATE TABLE date_table_power (
	date_of_month datetime,
	avg_worker_power FLOAT);
	set @end_date = now();
	set @start_date = DATE_SUB(@end_date, INTERVAL DAYOFMONTH(@end_date)-1 DAY);

	WHILE (@start_date <= @end_date) DO
		INSERT INTO date_table_power VALUES (@start_date, 
		(select (select COUNT(*) as task_num from t_tasks where task_date = date(@start_date))
		/
		(SELECT count(DISTINCT worker_id) as worker_cnt FROM t_workers WHERE (worker_start_date <= date(@start_date) 
		AND (worker_finish_date >= date(@start_date) OR worker_finish_date is NULL))) as avg_p));
	    	SET @start_date = DATE_ADD(@start_date, INTERVAL 1 DAY);
	END WHILE;	
	select * from date_table_power;
end//
delimiter ;

CALL avg_worker_power(); 

