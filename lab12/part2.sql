--lab12.2

--task4
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

--task5

----B---
begin transaction 
-----------t1--------
update PROGRESS set Note = Note+1
where Note < 4
commit;
-----------t2------------


--task6
--B--
begin transaction 
---------t1--------
--insert PROGRESS values('ООП', 1004, '01.12.2013', 7);
delete from PROGRESS where PROGRESS.IDSTUDENT=1009

---------
commit;
-------t2-------


--task7
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


--9,4
--B
begin transaction 
select @@SPID
insert Факультативы values ('Мировая культура', 6, 7, 1, 2)
update Студенты set Студенты.Факультатив = 'Мировая культура' where Студенты.Факультатив = 'История'
------------t1--------------
----------t2-------------
rollback;

--task 9.5
----B---
begin transaction 
-----------t1--------
update Студенты set Студенты.Факультатив = 'Геометрия'
where Курс = 1
commit;
-----------t2------------

--9.6

--B--
begin transaction 
---------t1--------
insert Студенты values(15154, 'Кот', 'Петр', 'Английский',1);
commit;
-------t2-------

--9.7
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