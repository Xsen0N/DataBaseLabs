--select TEACHER[Код], TEACHER_NAME [Имя], GENDER[Пол], PULPIT[Кафедра]
--from TEACHER;
use UNIVER
go
create view [Преподователь]
as select TEACHER[Код], TEACHER_NAME [Имя], GENDER[Пол], PULPIT[Кафедра]
from TEACHER;
go
select * from [Преподователь]
go
--2
create view [Количество_кафедр]
as select FACULTY_NAME[факультет], COUNT(*)[количество кафедр ]
from PULPIT inner join FACULTY on FACULTY.FACULTY = PULPIT.FACULTY
group by FACULTY_NAME
go
--3
create view [Аудитории]
as select AUDITORIUM[Код], AUDITORIUM_TYPE[Наименование аудитории]
from AUDITORIUM
where AUDITORIUM_TYPE like 'ЛК%'
go

--4
create view [Лекционные_аудитории]
as select AUDITORIUM, AUDITORIUM_TYPE
from AUDITORIUM
where AUDITORIUM_TYPE like 'ЛК%' with check option;
go
--5
create view [Дисциплины]
as select top 10 SUBJECT.SUBJECT[Код], SUBJECT.SUBJECT_NAME[наименование дисциплины ], SUBJECT.PULPIT[код кафедры]
from SUBJECT
order by SUBJECT_NAME
go
--6
alter view [Количество_кафедр] with schemabinding
as select FACULTY_NAME[факультет], COUNT(*)[количество кафедр ]
from dbo.PULPIT inner join  dbo.FACULTY on FACULTY.FACULTY = PULPIT.FACULTY
group by FACULTY_NAME;
go
select * from [Количество_кафедр]

--7
--7,1
use Zhuk_Base
go
create view [Преподаватель]
as select Преподаватели.ID_лектора [Код] , Преподаватели.Кафедра[Название кафедры], Преподаватели.Телефон[Данные] 
from Преподаватели;
go
--7,2
create view [Кол-во студентов]
as select Факультативы.Название_факультатива[Факультатив], count(*)[кол-во студентов]
from Студенты inner join Факультативы on Студенты.Факультатив = Факультативы.Название_факультатива
group by Название_факультатива;
go
--7,3
create view [Факультативы 2 курса]
as select Факультативы.Название_факультатива [Факультатив], Факультативы.Oбъем_лекций[Кол-во лекций]
from Факультативы
where Факультативы.Курс = 2
go
--7,4
create view [Факультатив]
as select Факультативы.Название_факультатива [Факультатив], Факультативы.Oбъем_лекций[Кол-во лекций]
from Факультативы
where Факультативы.Курс = 2 with check option;
go
--5
insert [Факультатив] values ('рсымры', 3)
create view [Лучшие студенты]
as select top 5 Успеваемость.Номер_студенческого [Код],Успеваемость.Средняя_оценка [Оценка]
from Успеваемость
order by Средняя_оценка desc;
go
----6
alter view [Кол-во студентов] with schemabinding
as select Факультативы.Название_факультатива[Факультатив], count(*)[кол-во студентов]
from dbo.Студенты inner join dbo.Факультативы on Студенты.Факультатив = Факультативы.Название_факультатива
group by Название_факультатива;
go
select * from [Кол-во студентов] 
drop table Факультативы


insert [Кол-во студентов] values (1, 1111, 2,3)