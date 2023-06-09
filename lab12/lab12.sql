--lab12

--create table #STRINGS
--(id int,
--cc int identity(1,1),
--name varchar(100)
--);
--go
--set nocount on;
--declare @i int =0;
--while @i < 10000
--begin 
--insert #STRINGS(id, name) 
--values (floor(3000*rand()),'string');
--set @i = @i+1;
--end;
--go;


set nocount on
if  exists (select * from  SYS.OBJECTS        -- таблица X есть?
	where OBJECT_ID= object_id(N'DBO.STRINGS') )	            
drop table #STRINGS;           
declare @c int, @flag char = 'c';           -- commit или rollback?
SET IMPLICIT_TRANSACTIONS  ON   -- включ. режим неявной транзакции
CREATE table #STRINGS(K int );                         -- начало транзакции 
INSERT #STRINGS values (1),(2),(3);
set @c = (select count(*) from #STRINGS);
print 'количество строк в таблице #STRINGS: ' + cast( @c as varchar(2));
if @flag = 'c'  commit;                   -- завершение транзакции: фиксация 
else   rollback;                                 -- завершение транзакции: откат  
SET IMPLICIT_TRANSACTIONS  OFF   -- выключ. режим неявной транзакции

if  exists (select * from  SYS.OBJECTS       -- таблица X есть?
	            where OBJECT_ID= object_id(N'DBO.STRINGS') )
print 'таблица #STRINGS есть';  
   else print 'таблицы #STRINGS нет'

----------------------------
--task2
use UNIVER
begin try
begin tran
delete TEACHER where TEACHER.PULPIT = 'ЛВ';
delete SUBJECT where SUBJECT.SUBJECT_NAME like '%основы%';
insert SUBJECT values ('МА','Математический анализ', 'ИСиТ');
insert SUBJECT values ('ИГ','Инженерная геодезия ', 'ЛУ');
commit tran;
end try 
begin catch
print 'error: '+ case
when error_number()=2627 and patindex('%SUBJECT_PK%', error_message())>0
then 'дублирование'
when error_number()=547 
then 'ошибка с ограничением FOREIGN KEY'
else 'неизвестная ошибка: '+ cast(error_number()as varchar(5))+ error_message()
end;
if @@trancount > 0 rollback tran;
end catch

--task3
declare @point varchar(32);
begin try
  begin tran
  delete SUBJECT where SUBJECT.SUBJECT = 'MA';
  set @point = 'p1';save tran @point;
  insert SUBJECT values ('МА','Математический анализ', 'ИСиТ');
  set @point = 'p2';save tran @point;
  insert SUBJECT values ('ИГ','Инженерная геодезия ', 'ЛУ');
  set @point = 'p3';save tran @point;
  update STUDENT 
  set IDSTUDENT = 1006 where IDSTUDENT = 1005
  commit tran;
end try
begin catch
   print 'error: '+ case
      when error_number()=2627 and patindex('%SUBJECT_PK%', error_message())>0
      then 'дублирование'
      when error_number()=2627 and patindex('%STUDENT_PK%', error_message())>0
      then 'Повторяющееся значение ключа'
      when error_number()=547 
      then 'ошибка  с ограничением FOREIGN KEY'
      else 'неизвестная ошибка: '+ cast(error_number()as varchar(5))+ error_message()
   end;
if @@trancount > 0 
  begin 
  print 'контрольная точка: ' + @point;
  rollback tran @point;
  commit tran;
end;
end catch

--task4

--A---
set transaction isolation level READ UNCOMMITTED 
	begin transaction 
---t1
select @@SPID, 'insert SUBJECT''результат',* from SUBJECT
where SUBJECT.SUBJECT like ('Э_%');
select @@SPID, 'update Progress' 'результат',PROGRESS.SUBJECT,
PROGRESS.NOTE from PROGRESS where PROGRESS.SUBJECT like ('Э_%');
commit;
---------t2----------------
--B
begin transaction 
select @@SPID
insert SUBJECT values ('ЭР','Экономические расчеты', 'МиЭП')
update Progress set PROGRESS.SUBJECT = 'ЭР'
where PROGRESS.SUBJECT = 'ЭT'
------t1-----
-------t2----------
rollback;

--task 5
--A--
set transaction isolation level READ COMMITTED 
	begin transaction
select count(*) from PROGRESS where NOTE < 4;
------t1-----
-------t2----------
select 'update PROGRESS ''result', count(*)[Кол-во]
from PROGRESS where Note < 4;
commit;

----B---
begin transaction 
-----------t1--------
update PROGRESS set Note = Note+1
where Note < 4
commit;
-----------t2------------

--task6---
-- A ---
set transaction isolation level  REPEATABLE READ 
	begin transaction 
	select PROGRESS.IDSTUDENT from PROGRESS where Note = 7;
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
select case
when PROGRESS.SUBJECT like ('%О%') then 'insert PROGRESS' else ''
end 'result',SUBJECT from PROGRESS where Note >6;
-------------------------------
commit;

--B--
begin transaction 
---------t1--------
insert PROGRESS values('ООП', 1009, '01.12.2013', 6);
commit;
-------t2-------

--task7
      -- A ---
set transaction isolation level SERIALIZABLE 
	begin transaction 
delete PROGRESS where SUBJECT = 'ЭП'; 
insert PROGRESS values('ЭП', 1007, '01.12.2013', 6);
update PROGRESS set Note = Note-1 where SUBJECT= 'ЭП';
select Note from PROGRESS where SUBJECT= 'ЭП';
------------t1--------------
--select Note from PROGRESS where SUBJECT= 'ЭП';
----------t2-------------
commit;

--B--
begin transaction 
delete PROGRESS where SUBJECT = 'ЭП'; 
insert PROGRESS values('ЭП', 1007, '01.12.2013', 6);
update PROGRESS set Note = Note-1 where SUBJECT= 'ЭП';
select Note from PROGRESS where SUBJECT= 'ЭП';
------------t1--------------
commit;
select Note from PROGRESS where SUBJECT= 'ЭП';
----------t2-------------

--task8
begin tran
insert SUBJECT values ('ТВП','Тестирование веб-приложений', 'ИСиТ');
begin tran
update PROGRESS set  PROGRESS.SUBJECT= 'ТВП'where IDSTUDENT = 1010 and IDSTUDENT = 1005 ;
commit;
if @@TRANCOUNT > 0 rollback;
select 
(select count(*) from SUBJECT where SUBJECT= 'ТВП' )'Test',
(select count(*) from PROGRESS where SUBJECT= 'ТВП' )'Students';

-- task9---

--9.1
create table Zhuk
(id int,
cc int identity(1,1),
name varchar(100)
);
go
set nocount on;
declare @i int =0;
while @i < 10000
begin 
insert Zhuk(id, name) 
values (floor(3000*rand()),'string');
set @i = @i+1;
end;
go;
use Zhuk_Base
set nocount on
if  exists (select * from  SYS.OBJECTS        -- таблица X есть?
	where OBJECT_ID= object_id(N'DBO.Zhuk') )	            
drop table Zhuk;           
declare @c int, @flag char = 'c';           -- commit или rollback?
SET IMPLICIT_TRANSACTIONS  ON   -- включ. режим неявной транзакции
CREATE table Zhuk(K int );                         -- начало транзакции 
INSERT Zhuk values (1),(2), (3);
set @c = (select count(*) from Zhuk);
print 'количество строк в таблице Zhuk: ' + cast( @c as varchar(2));
if @flag = 'c'  commit;                   -- завершение транзакции: фиксация 
else   rollback;                                 -- завершение транзакции: откат  
SET IMPLICIT_TRANSACTIONS  OFF   -- выключ. режим неявной транзакции

if  exists (select * from  SYS.OBJECTS       -- таблица Zhuk есть?
	            where OBJECT_ID= object_id(N'DBO.Zhuk') )
print 'таблица Zhuk есть';  
   else print 'таблицы Zhuk нет'

--9.2

begin try
begin tran
delete Студенты where Студенты.Факультатив = 'ТВ';
delete Факультативы where Факультативы.Oбъем_лабораторных = 4;
insert Факультативы values ('Культура средневековья',7, 15,4, 3);
insert Факультативы values ('Рисунок',15,45,1,2 );
commit tran;
end try 
begin catch
print 'error: '+ case
when error_number()=2627 and patindex('%PK_Факульта%', error_message())>0
then 'дублирование'
when error_number()=547 
then 'ошибка с ограничением FOREIGN KEY'
else 'неизвестная ошибка: '+ cast(error_number()as varchar(5))+ error_message()
end;
if @@trancount > 0 rollback tran;
end catch

--9.3

declare @point varchar(32);
begin try
  begin tran
  delete Факультативы where Факультативы.Название_факультатива = 'История';
  set @point = 'p1';save tran @point;
  insert Факультативы values ('Культура средневековья',7, 15,4, 3);
  set @point = 'p2';save tran @point;
  insert Факультативы values ('История',6, 14,4, 4);
  set @point = 'p3';save tran @point;
  update Студенты 
  set Номер_студенческого = 22222 where Номер_студенческого = 55555
  commit tran;
end try
begin catch
   print 'error: '+ case
      when error_number()=2627 and patindex('%PK_Студенты%', error_message())>0
      then 'дублирование'
      when error_number()=2627 and patindex('%PK_Факульта%', error_message())>0
      then 'Повторяющееся значение ключа'
      when error_number()=547 
      then 'ошибка с ограничением FOREIGN KEY'
      else 'неизвестная ошибка: '+ cast(error_number()as varchar(5))+ error_message()
   end;
if @@trancount > 0 
  begin 
  print 'контрольная точка: ' + @point;
  rollback tran @point;
  commit tran;
end;
end catch

--9.4

--A---
set transaction isolation level READ UNCOMMITTED 
	begin transaction 
---t1
select @@SPID, 'insert Студенты''результат',* from Студенты
where Студенты.Факультатив = 'Немецкий';
select @@SPID, 'update Факультативы' 'результат',Факультативы.Название_факультатива, Факультативы.ID_лектора
from Факультативы where Факультативы.Название_факультатива = 'Немецкий';
commit;
---------t2----------------
begin transaction 
select @@SPID
insert Факультативы values ('Мировая культура', 6, 7, 1, 2)
update Студенты set Студенты.Факультатив = 'Мировая культура' where Студенты.Факультатив = 'История'

rollback;

--task 5
--A--
set transaction isolation level READ COMMITTED 
	begin transaction
select count(*) from Студенты where Студенты.Факультатив = 'Математика';
------t1-----
-------t2----------
select 'update PROGRESS ''result', count(*)[Кол-во]
from Студенты where Студенты.Факультатив = 'Математика';
commit;

----B---
begin transaction 
-----------t1--------
update Студенты set Студенты.Факультатив = 'Геометрия'
where Курс = 1
commit;
-----------t2------------

--task6---
set transaction isolation level  REPEATABLE READ 
	begin transaction 
	select Студенты.Номер_студенческого from Студенты where Студенты.Факультатив = 'Английский';
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
select case
when Студенты.Курс = 2  then 'insert Студенты' else ''
end 'result',Студенты.Факультатив from Студенты where Студенты.Факультатив = 'Английский';
commit;

--B--
begin transaction 
---------t1--------
insert Студенты values(15154, 'Кот', 'Петр', 'Английский',1);
commit;
-------t2-------

--task7
set transaction isolation level SERIALIZABLE 
	begin transaction 
delete Студенты where Студенты.Факультатив = 'Логика'; 
insert Студенты values(12356, 'Котов', 'Сергей', 'Логика',1);
update Студенты set Факультатив ='Логика' where Имя= 'Сергей';
select Студенты.Номер_студенческого from Студенты where Факультатив= 'Логика';
------------t1--------------
select Студенты.Номер_студенческого from Студенты where Факультатив= 'Логика';
----------t2-------------
commit;

--B--
begin transaction 
delete Студенты where Студенты.Факультатив = 'Логика'; 
insert Студенты values(12356, 'Котов', 'Сергей', 'Логика',1);
update Студенты set Факультатив ='Логика' where Имя= 'Сергей';
select Студенты.Номер_студенческого from Студенты where Факультатив= 'Логика';
------------t1--------------
commit;
select Студенты.Номер_студенческого from Студенты where Факультатив= 'Логика';
----------t2-------------

--task8
begin tran
insert Факультативы values ('Черчение', 15, 14, 2,2)
begin tran
update Студенты set  Студенты.Факультатив= 'Черчение'where Номер_студенческого = 8888 and Номер_студенческого = 7777 ;
commit;
if @@TRANCOUNT > 0 rollback;
select 
(select count(*) from Студенты where Факультатив= 'Черчение' )'Студенты',
(select count(*) from Факультатив where Факультатив.Факультатив= 'Черчение' )'Факультатив';
