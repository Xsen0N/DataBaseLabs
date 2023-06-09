--lab4
USE UNIVER
--1
SELECT AUDITORIUM.AUDITORIUM, AUDITORIUM.AUDITORIUM_TYPE
FROM AUDITORIUM
INNER JOIN AUDITORIUM_TYPE ON AUDITORIUM_TYPE.AUDITORIUM_TYPE = AUDITORIUM.AUDITORIUM_TYPE;
--2
SELECT AUDITORIUM.AUDITORIUM, AUDITORIUM.AUDITORIUM_TYPE
FROM AUDITORIUM
INNER JOIN AUDITORIUM_TYPE ON AUDITORIUM_TYPE.AUDITORIUM_TYPE = AUDITORIUM.AUDITORIUM_TYPE and 
             AUDITORIUM_TYPE.AUDITORIUM_TYPENAME Like '%компьютерный%';
			 --3
--Select PROGRESS.IDSTUDENT, STUDENT.NAME, FACULTY.FACULTY_NAME, PULPIT.PULPIT, PROFESSION.PROFESSION, PROGRESS.SUBJECT,
--case PROGRESS.NOTE
--when 6 then 'шесть'
--when 7 then 'семь'
--when 8 then 'восемь'
--else 'другое'
--end [Оценка]
--from PROGRESS inner join STUDENT on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
--inner join SUBJECT on PROGRESS.SUBJECT = SUBJECT.SUBJECT
--inner join PULPIT on SUBJECT.PULPIT = PULPIT.PULPIT
--inner join FACULTY on PULPIT.FACULTY = FACULTY.FACULTY
--inner join PROFESSION on FACULTY.FACULTY = PROFESSION.FACULTY
--order by  PROGRESS.NOTE DESC;

use UNIVER
Select PROGRESS.IDSTUDENT, STUDENT.NAME, FACULTY.FACULTY_NAME, PULPIT.PULPIT, PROFESSION.PROFESSION, PROGRESS.SUBJECT,PROGRESS.NOTE,
Case 
when (PROGRESS.NOTE between 6 and 8) then ' от шести до восьми'
else 'другое'
end [Оценка]
from PROGRESS inner join STUDENT on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
inner join SUBJECT on PROGRESS.SUBJECT = SUBJECT.SUBJECT
inner join PULPIT on SUBJECT.PULPIT = PULPIT.PULPIT
inner join FACULTY on PULPIT.FACULTY = FACULTY.FACULTY
inner join PROFESSION on FACULTY.FACULTY = PROFESSION.FACULTY
order by  PROGRESS.NOTE DESC;
--4
Select isnull (TEACHER.TEACHER_NAME, '**' )[Преподаватели], PULPIT.PULPIT_NAME
from PULPIT left outer join TEACHER on TEACHER.PULPIT = PULPIT.PULPIT
-- 5
Select * from PROGRESS FULL OUTER JOIN  STUDENT
On PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where STUDENT.IDSTUDENT is Null
order by STUDENT.IDSTUDENT

select * from STUDENT full outer join PROGRESS
on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
where PROGRESS.IDSTUDENT is null
order by PROGRESS.IDSTUDENT

select * from STUDENT full outer join PROGRESS 
on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
where PROGRESS.IDSTUDENT is not null
--6
select AUDITORIUM.AUDITORIUM_NAME, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME
from AUDITORIUM cross join AUDITORIUM_TYPE
--7
use Zhuk_Base
--task1
select Факультативы.Название_факультатива, Преподаватели.Кафедра
from Факультативы inner join Преподаватели 
on Факультативы.ID_лектора = Преподаватели.ID_лектора
-- task2
select Студенты.Имя, Успеваемость.Число_пропусков
from Студенты inner join Успеваемость 
on Студенты.Номер_студенческого = Успеваемость.Номер_студенческого
and Студенты.Номер_студенческого like '%2%'
--task3
select Студенты.Номер_студенческого, Факультативы.Название_факультатива,Преподаватели.Кафедра, Успеваемость.Средняя_оценка,
Case 
when (Успеваемость.Средняя_оценка between 4 and 7) then 'bad'
else 'good'
end [Result]
from Студенты inner join Факультативы on Студенты.Факультатив = Факультативы.Название_факультатива
inner join Преподаватели on Преподаватели.ID_лектора = Факультативы.ID_лектора
inner join Успеваемость on Студенты.Номер_студенческого = Успеваемость.Номер_студенческого
--task4
select isnull(Преподаватели.Телефон, '***')[Phone], Факультативы.Название_факультатива, Преподаватели.ID_лектора
from Факультативы left outer join Преподаватели
on Факультативы.ID_лектора = Преподаватели.ID_лектора
--task5
select * from Преподаватели
full outer join Факультативы
on Преподаватели.ID_лектора = Факультативы.ID_лектора
where Факультативы.ID_лектора is null

select * from Факультативы
full outer join Преподаватели
on Преподаватели.ID_лектора = Факультативы.ID_лектора
where Преподаватели.ID_лектора is null

select * from Факультативы
full outer join Преподаватели
on Преподаватели.ID_лектора = Факультативы.ID_лектора
where Преподаватели.ID_лектора is not null
-- task6
select Факультативы.Название_факультатива, Преподаватели.Кафедра
from Факультативы cross join Преподаватели 
where Факультативы.ID_лектора = Преподаватели.ID_лектора
