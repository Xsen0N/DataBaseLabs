--lab6
use UNIVER
--task1-2
select AUDITORIUM_TYPE.AUDITORIUM_TYPE,
max(AUDITORIUM.AUDITORIUM_CAPACITY)[Максимальная вместимость],
min(AUDITORIUM.AUDITORIUM_CAPACITY)[Минимальная вместимость],
avg(AUDITORIUM.AUDITORIUM_CAPACITY)[Средняя вместимость],
Count(*)[Количество],
sum(AUDITORIUM.AUDITORIUM_CAPACITY)[Сумарная вместимость]
from AUDITORIUM_TYPE inner join AUDITORIUM 
on AUDITORIUM_TYPE.AUDITORIUM_TYPE = AUDITORIUM.AUDITORIUM_TYPE
group by AUDITORIUM_TYPE.AUDITORIUM_TYPE;
--task3
select *
from (select Case when PROGRESS.NOTE between 0 and 3 then 'оценка ниже 3'
when PROGRESS.NOTE between 4 and 7 then 'оценки от 4 до 7'
else 'оценки больше 7'
end[Шкала знаний],COUNT(*)[Количество]
from PROGRESS group by case 
when PROGRESS.NOTE between 0 and 3 then 'оценка ниже 3'
when PROGRESS.NOTE between 4 and 7 then 'оценки от 4 до 7'
else 'оценки больше 7'
end) as T
order by case[Шкала знаний]
when 'оценка ниже 3' then 3
when 'оценки от 4 до 7' then 2
when 'оценки больше 7' then 1
else 0
end
--task4
select FACULTY.FACULTY_NAME, GROUPS.PROFESSION, ROUND(avg(cast(PROGRESS.NOTE as float(4))),2)[Средняя оценка]
from FACULTY inner join GROUPS on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT on STUDENT.IDGROUP =GROUPS.IDGROUP
inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
group by FACULTY.FACULTY_NAME, GROUPS.PROFESSION
order by ROUND(avg(cast(PROGRESS.NOTE as float(4))),2) desc
--task5 
select FACULTY.FACULTY_NAME, GROUPS.PROFESSION, ROUND(avg(cast(PROGRESS.NOTE as float(4))),2)[Средняя оценка]
from FACULTY inner join GROUPS on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT on STUDENT.IDGROUP =GROUPS.IDGROUP
inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
where PROGRESS.SUBJECT in ('БД', 'ОАиП')
group by FACULTY.FACULTY_NAME, GROUPS.PROFESSION
order by ROUND(avg(cast(PROGRESS.NOTE as float(4))),2) desc
--task6
select PROGRESS.SUBJECT, GROUPS.PROFESSION, avg(PROGRESS.NOTE)[Средняя оценка]
from FACULTY inner join GROUPS on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT on STUDENT.IDGROUP =GROUPS.IDGROUP
inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
where FACULTY.FACULTY = 'ТОВ'
group by PROGRESS.SUBJECT, GROUPS.PROFESSION
--task7
select p2.SUBJECT, p2.NOTE, (select count(*) from PROGRESS p1 where p1.SUBJECT = p2.SUBJECT
and p1.NOTE = p2.NOTE)[Кол-во]
from PROGRESS p2
group by p2.SUBJECT, p2.NOTE
having NOTE in (8, 9)
--task9
--9.1/2
use Zhuk_Base
select  Факультативы.ID_лектора,
min(Факультативы.Oбъем_лекций)[Минимальное число лекция],
max(Факультативы.Oбъем_лекций)[Максимальное число лекция],
avg(Факультативы.Oбъем_лекций)[Среднее число лекция],
COUNT(*)[Кол-во преметов]
from Факультативы 
group by Факультативы.ID_лектора
--9.3
select * 
from (select case
when Успеваемость.Средняя_оценка between 0 and 5 then ' меньше 5'
when Успеваемость.Средняя_оценка between 6 and 8 then ' от 6 до 8'
else ' >9' 
end[Предел оценок], count(*)[кол-во]
from Успеваемость group by case
when Успеваемость.Средняя_оценка between 0 and 5 then ' меньше 5'
when Успеваемость.Средняя_оценка between 6 and 8 then ' от 6 до 8'
else ' >9' 
end) as T
order by case [Предел оценок]
when ' меньше 5' then 3
when  ' от 6 до 8' then 2
when  ' >9' then 1
else 0 
end
--9,4
select  Факультативы.Название_факультатива, ROUND(avg(cast(Успеваемость.Средняя_оценка as float(4))),2)[Средняя оценка]
from Студенты inner join Факультативы on Студенты.Факультатив = Факультативы.Название_факультатива
inner join Успеваемость on Студенты.Номер_студенческого = Успеваемость.Номер_студенческого
group by Факультативы.Название_факультатива
--9,5
select  Факультативы.Название_факультатива, ROUND(avg(cast(Успеваемость.Средняя_оценка as float(4))),2)[Средняя оценка]
from Студенты inner join Факультативы on Студенты.Факультатив = Факультативы.Название_факультатива
inner join Успеваемость on Студенты.Номер_студенческого = Успеваемость.Номер_студенческого
where Студенты.Курс <3
group by Факультативы.Название_факультатива
--9,6
select  Факультативы.Название_факультатива, avg(Успеваемость.Средняя_оценка)[Средняя оценка]
from Студенты inner join Факультативы on Студенты.Факультатив = Факультативы.Название_факультатива
inner join Успеваемость on Студенты.Номер_студенческого = Успеваемость.Номер_студенческого
where Факультативы.Название_факультатива in ('Живопись', 'Математика')
group by Факультативы.Название_факультатива
--9..7
select p1.Номер_студенческого, p1.Средняя_оценка,
(select count(*) from Успеваемость p2 
where  p1.Номер_студенческого = p2.Номер_студенческого
and p1.Средняя_оценка = p2.Средняя_оценка)[Кол-во]
from Успеваемость p1 
group by p1.Номер_студенческого,  p1.Средняя_оценка
having  Средняя_оценка > 6