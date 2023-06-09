--lab5
--task1
use UNIVER
select PULPIT.PULPIT_NAME, PROFESSION.PROFESSION_NAME
from PULPIT, PROFESSION
where PULPIT.FACULTY = PROFESSION.FACULTY
and PROFESSION.PROFESSION_NAME in (select PROFESSION_NAME from PROFESSION where PROFESSION_NAME like '%технологи[и, й, я]%')
--task2
select PULPIT.PULPIT_NAME, PROFESSION.PROFESSION_NAME
from PULPIT inner join PROFESSION on PULPIT.FACULTY = PROFESSION.FACULTY
Where PROFESSION.PROFESSION_NAME in  (select PROFESSION_NAME from PROFESSION where PROFESSION_NAME like '%технологи[и, й, я]%')
--task3
select FACULTY.FACULTY, PULPIT.PULPIT_NAME, PROFESSION.PROFESSION_NAME
from PULPIT inner join FACULTY on PULPIT.FACULTY = FACULTY.FACULTY
inner join PROFESSION on PULPIT.FACULTY = PROFESSION.FACULTY
where PROFESSION.PROFESSION_NAME like '%технологи[и, й, я]%'
--task4
SELECT  AUDITORIUM_NAME 'Аудитория', AUDITORIUM_TYPE 'Тип', AUDITORIUM_CAPACITY 'Вместимость'
from AUDITORIUM a
where AUDITORIUM_CAPACITY = (SELECT TOP(1) AUDITORIUM_CAPACITY FROM AUDITORIUM aa
where a.AUDITORIUM_TYPE = aa.AUDITORIUM_TYPE
order by  AUDITORIUM_CAPACITY DESC);
--task5
select FACULTY.FACULTY from FACULTY
where  exists(select * from PULPIT
where FACULTY.FACULTY = PULPIT.FACULTY)
--task6--
select top 1
(select AVG(NOTE) from PROGRESS where SUBJECT like 'БД') [БД],
(select AVG(NOTE) from PROGRESS where SUBJECT like 'СУБД')[СУБД],
(select AVG(NOTE) from PROGRESS where SUBJECT like 'ОАиП')[ОАиП]
from PROGRESS
---task7
select PROGRESS.SUBJECT, PROGRESS.NOTE from PROGRESS
where PROGRESS.NOTE<= all(select NOTE from PROGRESS 
where SUBJECT like '%Д%' )

select PROGRESS.SUBJECT, PROGRESS.NOTE from PROGRESS
where PROGRESS.NOTE>= any(select NOTE from PROGRESS 
where SUBJECT like '%Д%' )
--task9 
--9.1
use Zhuk_Base
select Студенты.Имя, Факультативы.Курс
from Студенты, Факультативы
where Студенты.Факультатив =  Факультативы.Название_факультатива
and Факультативы.ID_лектора in (select ID_лектора from Преподаватели where Преподаватели.Кафедра like '%о%')
--9.2
select Студенты.Имя, Факультативы.Курс
from Студенты inner join Факультативы
on Студенты.Факультатив =  Факультативы.Название_факультатива
where Факультативы.ID_лектора in (select ID_лектора from Преподаватели where Преподаватели.Кафедра like '%о%')
--9.3
select Студенты.Имя, Факультативы.Курс, Преподаватели.ID_лектора
from Студенты inner join Факультативы
on Студенты.Факультатив =  Факультативы.Название_факультатива
inner join Преподаватели on Факультативы.ID_лектора = Преподаватели.ID_лектора
where Преподаватели.Кафедра like '%о%'
--9.4
select Курс, Факультатив from Студенты a
where Факультатив = (select top(1) Факультатив from Студенты aa
where aa.Факультатив = a.Факультатив
order by Курс desc)
--9.5
select Название_факультатива FROM Факультативы
where not exists (select * from Студенты 
where Факультативы.Название_факультатива = Студенты.Факультатив)
--9.6
select top 1
(select avg(Успеваемость.Средняя_оценка) from Успеваемость 
where ID <5 )[Оценка 1 группы],
(select avg(Успеваемость.Средняя_оценка) from Успеваемость 
where ID > 4 )[Оценка 2 группы]
from Успеваемость
--9,7
select Номер_студенческого from Студенты
where Курс >=all (select Курс from Студенты where Имя like '%е%')
--9,8
select Номер_студенческого from Студенты
where Курс >any (select Курс from Студенты where Имя like '%е%')


