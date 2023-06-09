--lab7
use UNIVER
select PROGRESS.SUBJECT, GROUPS.PROFESSION, avg(PROGRESS.NOTE)[Средняя оценка]
from FACULTY inner join GROUPS on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT on STUDENT.IDGROUP =GROUPS.IDGROUP
inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
where FACULTY.FACULTY = 'ТОВ'
group by PROGRESS.SUBJECT, GROUPS.PROFESSION
--1
select PROGRESS.SUBJECT, GROUPS.PROFESSION, avg(PROGRESS.NOTE)[Средняя оценка]
from FACULTY inner join GROUPS on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT on STUDENT.IDGROUP =GROUPS.IDGROUP
inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
where FACULTY.FACULTY = 'ТОВ'
group by rollup( PROGRESS.SUBJECT, GROUPS.PROFESSION)
--2

select PROGRESS.SUBJECT, GROUPS.PROFESSION, avg(PROGRESS.NOTE)[Средняя оценка]
from FACULTY inner join GROUPS on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT on STUDENT.IDGROUP =GROUPS.IDGROUP
inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
where FACULTY.FACULTY = 'ТОВ'
group by cube( PROGRESS.SUBJECT, GROUPS.PROFESSION)
--3
select PROGRESS.SUBJECT, GROUPS.PROFESSION, avg(PROGRESS.NOTE)[Средняя оценка]
from FACULTY inner join GROUPS on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT on STUDENT.IDGROUP =GROUPS.IDGROUP
inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
where FACULTY.FACULTY = 'ТОВ'
group by PROGRESS.SUBJECT, GROUPS.PROFESSION
union
select PROGRESS.SUBJECT, GROUPS.PROFESSION, avg(PROGRESS.NOTE)[Средняя оценка]
from FACULTY inner join GROUPS on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT on STUDENT.IDGROUP =GROUPS.IDGROUP
inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
where FACULTY.FACULTY = 'ХТиТ'
group by PROGRESS.SUBJECT, GROUPS.PROFESSION
--
select PROGRESS.SUBJECT, GROUPS.PROFESSION, avg(PROGRESS.NOTE)[Средняя оценка]
from FACULTY inner join GROUPS on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT on STUDENT.IDGROUP =GROUPS.IDGROUP
inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
where FACULTY.FACULTY = 'ТОВ'
group by PROGRESS.SUBJECT, GROUPS.PROFESSION
union all
select PROGRESS.SUBJECT, GROUPS.PROFESSION, avg(PROGRESS.NOTE)[Средняя оценка]
from FACULTY inner join GROUPS on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT on STUDENT.IDGROUP =GROUPS.IDGROUP
inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
where FACULTY.FACULTY = 'ХТиТ'
group by PROGRESS.SUBJECT, GROUPS.PROFESSION
--4
select PROGRESS.SUBJECT, GROUPS.PROFESSION, avg(PROGRESS.NOTE)[Средняя оценка]
from FACULTY inner join GROUPS on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT on STUDENT.IDGROUP =GROUPS.IDGROUP
inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
where FACULTY.FACULTY = 'ТОВ'
group by PROGRESS.SUBJECT, GROUPS.PROFESSION
INTERSECT
select PROGRESS.SUBJECT, GROUPS.PROFESSION, avg(PROGRESS.NOTE)[Средняя оценка]
from FACULTY inner join GROUPS on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT on STUDENT.IDGROUP =GROUPS.IDGROUP
inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
where FACULTY.FACULTY = 'ХТиТ'
group by PROGRESS.SUBJECT, GROUPS.PROFESSION
--5
select PROGRESS.SUBJECT, GROUPS.PROFESSION, avg(PROGRESS.NOTE)[Средняя оценка]
from FACULTY inner join GROUPS on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT on STUDENT.IDGROUP =GROUPS.IDGROUP
inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
where FACULTY.FACULTY = 'ТОВ'
group by PROGRESS.SUBJECT, GROUPS.PROFESSION
EXCEPT
select PROGRESS.SUBJECT, GROUPS.PROFESSION, avg(PROGRESS.NOTE)[Средняя оценка]
from FACULTY inner join GROUPS on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT on STUDENT.IDGROUP =GROUPS.IDGROUP
inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
where FACULTY.FACULTY = 'ХТиТ'
group by PROGRESS.SUBJECT, GROUPS.PROFESSION/
--task6

use Zhuk_Base
select  Факультативы.Название_факультатива, avg(Успеваемость.Средняя_оценка)[Средняя оценка]
from Студенты inner join Факультативы on Студенты.Факультатив = Факультативы.Название_факультатива
inner join Успеваемость on Студенты.Номер_студенческого = Успеваемость.Номер_студенческого
where Факультативы.Название_факультатива in ('Математика')
group by Факультативы.Название_факультатива
--
select  Факультативы.Название_факультатива, avg(Успеваемость.Средняя_оценка)[Средняя оценка]
from Студенты inner join Факультативы on Студенты.Факультатив = Факультативы.Название_факультатива
inner join Успеваемость on Студенты.Номер_студенческого = Успеваемость.Номер_студенческого
where Факультативы.Название_факультатива in ('Математика')
group by rollup (Факультативы.Название_факультатива)
--
select  Факультативы.Название_факультатива, avg(Успеваемость.Средняя_оценка)[Средняя оценка]
from Студенты inner join Факультативы on Студенты.Факультатив = Факультативы.Название_факультатива
inner join Успеваемость on Студенты.Номер_студенческого = Успеваемость.Номер_студенческого
where Факультативы.Название_факультатива in ('Математика')
group by cube (Факультативы.Название_факультатива)
--
select  Факультативы.Название_факультатива, avg(Успеваемость.Средняя_оценка)[Средняя оценка]
from Студенты inner join Факультативы on Студенты.Факультатив = Факультативы.Название_факультатива
inner join Успеваемость on Студенты.Номер_студенческого = Успеваемость.Номер_студенческого
where Факультативы.Название_факультатива in ('Математика')
group by Факультативы.Название_факультатива
union
select  Факультативы.Название_факультатива, avg(Успеваемость.Средняя_оценка)[Средняя оценка]
from Студенты inner join Факультативы on Студенты.Факультатив = Факультативы.Название_факультатива
inner join Успеваемость on Студенты.Номер_студенческого = Успеваемость.Номер_студенческого
where Факультативы.Название_факультатива in ('Английский')
group by Факультативы.Название_факультатива

select  Факультативы.Название_факультатива, avg(Успеваемость.Средняя_оценка)[Средняя оценка]
from Студенты inner join Факультативы on Студенты.Факультатив = Факультативы.Название_факультатива
inner join Успеваемость on Студенты.Номер_студенческого = Успеваемость.Номер_студенческого
where Факультативы.Название_факультатива in ('Математика')
group by Факультативы.Название_факультатива
union all
select  Факультативы.Название_факультатива, avg(Успеваемость.Средняя_оценка)[Средняя оценка]
from Студенты inner join Факультативы on Студенты.Факультатив = Факультативы.Название_факультатива
inner join Успеваемость on Студенты.Номер_студенческого = Успеваемость.Номер_студенческого
where Факультативы.Название_факультатива in ('Английский')
group by Факультативы.Название_факультатива
--4
select  Факультативы.Название_факультатива, avg(Успеваемость.Средняя_оценка)[Средняя оценка]
from Студенты inner join Факультативы on Студенты.Факультатив = Факультативы.Название_факультатива
inner join Успеваемость on Студенты.Номер_студенческого = Успеваемость.Номер_студенческого
where Факультативы.Название_факультатива in ('Математика')
group by Факультативы.Название_факультатива
INTERSECT
select  Факультативы.Название_факультатива, avg(Успеваемость.Средняя_оценка)[Средняя оценка]
from Студенты inner join Факультативы on Студенты.Факультатив = Факультативы.Название_факультатива
inner join Успеваемость on Студенты.Номер_студенческого = Успеваемость.Номер_студенческого
where Факультативы.Название_факультатива in ('Английский')
group by Факультативы.Название_факультатива
--5
select  Факультативы.Название_факультатива, avg(Успеваемость.Средняя_оценка)[Средняя оценка]
from Студенты inner join Факультативы on Студенты.Факультатив = Факультативы.Название_факультатива
inner join Успеваемость on Студенты.Номер_студенческого = Успеваемость.Номер_студенческого
where Факультативы.Название_факультатива in ('Математика')
group by Факультативы.Название_факультатива
EXCEPT
select  Факультативы.Название_факультатива, avg(Успеваемость.Средняя_оценка)[Средняя оценка]
from Студенты inner join Факультативы on Студенты.Факультатив = Факультативы.Название_факультатива
inner join Успеваемость on Студенты.Номер_студенческого = Успеваемость.Номер_студенческого
where Факультативы.Название_факультатива in ('Английский')
group by Факультативы.Название_факультатива