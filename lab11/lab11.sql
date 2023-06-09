--lab11
--task1
declare @sub char(20), @s char(300)='';
declare IsitSub cursor 
for select SUBJECT.SUBJECT from SUBJECT where SUBJECT.PULPIT = 'ИСиТ'
open IsitSub
fetch IsitSub into @sub
print 'Дисциплины на ИСИТ'
while @@FETCH_STATUS = 0
begin
set  @s = RTRIM(@sub) + ','+ @s;
fetch IsitSub into @sub
end;
print @s;
Close IsitSub
go;
--task2
--local
declare Faculty cursor local 
for select FACULTY.FACULTY, FACULTY_NAME from FACULTY
declare @faculty char(3), @name char(50);
open Faculty;
fetch Faculty into @faculty, @name
print '1.'+@faculty+ '- '+ @name;
go
declare @faculty char(20), @name char(30);
fetch Faculty into @faculty, @name
print '2.'+@faculty+ ' - '+ @name;
go
--global
declare Faculty cursor global 
for select FACULTY.FACULTY, FACULTY_NAME from FACULTY
declare @faculty char(3), @name char(50);
open Faculty;
fetch Faculty into @faculty, @name
print '1.'+@faculty+ '- '+ @name;
go
declare @faculty char(3), @name char(50);
fetch Faculty into @faculty, @name
print '2.'+@faculty+ ' - '+ @name;
close Faculty;
deallocate Faculty;

go
--task3
--static
declare @audit char(6), @type char(3), @capa int
declare audit_cursor CURSOR LOCAL STATIC
for select AUDITORIUM, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY  FROM AUDITORIUM where AUDITORIUM_CAPACITY > 20
OPEN audit_cursor
UPDATE AUDITORIUM
	SET AUDITORIUM.AUDITORIUM_CAPACITY = AUDITORIUM_CAPACITY + 2
	WHERE AUDITORIUM_TYPE like ('%ЛК%')
insert AUDITORIUM values('412-3', 'ЛБ-СК', 35,'412-3');
FETCH  audit_cursor INTO @audit, @type, @capa;
WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT @audit+' ' + @type + ' '  + cast(@capa as varchar(5));
    FETCH NEXT FROM audit_cursor INTO @audit, @type, @capa
END;
CLOSE audit_cursor;
go;
--dinamic
declare @audit char(6), @type char(3), @capa int
declare audit_cursor CURSOR LOCAL DYNAMIC
for select AUDITORIUM, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY  FROM AUDITORIUM where AUDITORIUM_CAPACITY > 20
OPEN audit_cursor
UPDATE AUDITORIUM
	SET AUDITORIUM.AUDITORIUM_CAPACITY = AUDITORIUM_CAPACITY - 2
	WHERE AUDITORIUM_TYPE like ('%ЛК%')
insert AUDITORIUM values('417-3', 'ЛБ-СК', 35,'417-3');
FETCH  audit_cursor INTO @audit, @type, @capa;
WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT @audit+' ' + @type + ' '  + cast(@capa as varchar(5));
    FETCH NEXT FROM audit_cursor INTO @audit, @type, @capa
END;
CLOSE audit_cursor;
go;
--task4
declare @a int, @audit char(10);
declare auditorium cursor local dynamic scroll
for select ROW_NUMBER() over(order by AUDITORIUM_CAPACITY )N,
AUDITORIUM from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE ='ЛБ-К'
open auditorium;
fetch auditorium into @a, @audit
print 'строка :' + cast(@a as varchar(3))+', '+ rtrim(@audit);
fetch Last from auditorium into @a, @audit;
print 'последняя строка :' + cast(@a as varchar(3))+ ', '+ rtrim(@audit);
fetch FIRST from auditorium into @a, @audit;
print '1  строка   :' + cast(@a as varchar(3))+ ', '+ rtrim(@audit);
fetch NEXT  from auditorium into @a, @audit;
print '2  строка :' + cast(@a as varchar(3))+ ', '+ rtrim(@audit);
fetch prior  from auditorium into @a, @audit;
print 'Предыдущая строка от текущей  :' + cast(@a as varchar(3))+ ', '+ rtrim(@audit);
fetch ABSOLUTE 4  from auditorium into @a, @audit;
print '4 строка от начала :' + cast(@a as varchar(3))+ ', '+ rtrim(@audit);
fetch ABSOLUTE  -4  from auditorium into @a, @audit;
print '4 строка от конца :' + cast(@a as varchar(3))+ ', '+ rtrim(@audit);
fetch RELATIVE  2  from auditorium into @a, @audit;
print '2 строка вперед от текущей :' + cast(@a as varchar(3))+ ', '+ rtrim(@audit);
fetch RELATIVE  -1  from auditorium into @a, @audit;
print '1 строка назад от текущей :' + cast(@a as varchar(3))+ ', '+ rtrim(@audit);
close auditorium
go;
--task5
declare @audit char(6), @type char(3), @capa int
declare task5 CURSOR LOCAL DYNAMIC
for select AUDITORIUM, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY  FROM AUDITORIUM for update;
OPEN task5
FETCH  task5 INTO @audit, @type, @capa;
delete AUDITORIUM where current of task5;
FETCH  task5 INTO @audit, @type, @capa;
UPDATE AUDITORIUM 
	SET AUDITORIUM.AUDITORIUM_CAPACITY = AUDITORIUM_CAPACITY + 2
	WHERE current of task5
CLOSE task5;
go;
--task6
--6,1
declare @prog char(6), @mark int, @faculty char(20)
declare BadStudent CURSOR local DYNAMIC
for select PROGRESS.NOTE, STUDENT.IDSTUDENT, GROUPS.FACULTY  FROM PROGRESS 
inner join STUDENT on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
inner join GROUPS on GROUPS.IDGROUP = STUDENT.IDGROUP for update;
OPEN BadStudent
delete PROGRESS where NOTE <4;
FETCH  BadStudent INTO @prog, @mark, @faculty;
CLOSE BadStudent;
go;

--6.2
declare @prog char(6), @mark int, @faculty char(20)
declare GoodStudent CURSOR local DYNAMIC
for select PROGRESS.NOTE, STUDENT.IDSTUDENT, GROUPS.FACULTY  FROM PROGRESS 
inner join STUDENT on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
inner join GROUPS on GROUPS.IDGROUP = STUDENT.IDGROUP for update;
OPEN GoodStudent
FETCH  GoodStudent INTO @prog, @mark, @faculty;
UPDATE PROGRESS 
	SET PROGRESS.NOTE = PROGRESS.NOTE + 1
	WHERE PROGRESS.IDSTUDENT in (1004, 1010, 1001)
FETCH  GoodStudent INTO @prog, @mark, @faculty;
CLOSE GoodStudent;
go;

--task7

--7.1
declare @facult char(20), @s char(300)='';
declare facultative  cursor 
for select Факультативы.Название_факультатива from Факультативы where Факультативы.Oбъем_лекций > 15
open facultative
fetch facultative into @facult
print 'Факультативы'
while @@FETCH_STATUS = 0
begin
set  @s = RTRIM(@facult) + ' ,'+ @s;
fetch facultative into @facult
end;
print @s;
Close facultative
go;

--7,2
--local
declare Teathers cursor local 
for select Преподаватели.ID_лектора, Преподаватели.Кафедра from Преподаватели
declare @id int, @pulpit char(50);
open Teathers;
fetch Teathers into @id, @pulpit
print '1.'+cast(@id as char(3))+ '- '+ @pulpit;
go
declare @id int, @pulpit char(50);
fetch Teathers into @id, @pulpit
print '2.'+cast(@id as char(3))+ '- '+ @pulpit;
go
--global
declare Teathers cursor global 
for select Преподаватели.ID_лектора, Преподаватели.Кафедра from Преподаватели
declare @id int, @pulpit char(50);
open Teathers;
fetch Teathers into @id, @pulpit
print '1.'+cast(@id as char(3))+ '- '+ @pulpit;
go
declare @id int, @pulpit char(50);
fetch Teathers into @id, @pulpit
print '2.'+cast(@id as char(3))+ '- '+ @pulpit;
close Teathers;
deallocate Teathers;
go

--7.3
--static
declare @id int, @pulp char(30), @numb char(10)
declare UniverTeathers CURSOR LOCAL STATIC
for select Преподаватели.ID_лектора, Преподаватели.Кафедра from Преподаватели
OPEN UniverTeathers
insert Преподаватели values(2, 'Информатики', 4444444);
FETCH  UniverTeathers INTO @id, @pulp;
WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT cast(@id as char(3))+' ' + @pulp + ' ';
    FETCH  UniverTeathers INTO @id, @pulp;
END;
CLOSE UniverTeathers;
go;
--dinamic
declare @id int, @pulp char(30), @numb char(10)
declare UniverTeathers CURSOR LOCAL Dynamic
for select Преподаватели.ID_лектора, Преподаватели.Кафедра from Преподаватели
OPEN UniverTeathers
insert Преподаватели values(7, 'Музыки', 55555);
FETCH  UniverTeathers INTO @id, @pulp;
WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT cast(@id as char(3))+' ' + @pulp + ' ';
    FETCH  UniverTeathers INTO @id, @pulp;
END;
CLOSE UniverTeathers;
go;

--7.4
declare @a int, @mark char(10);
declare Marks cursor local dynamic scroll
for select ROW_NUMBER() over(order by ID )N,
Успеваемость.Номер_студенческого from Успеваемость 
open Marks;
fetch Marks into @a, @mark
print 'строка :' + cast(@a as varchar(3))+', '+ rtrim(@mark);
fetch Last from Marks into @a, @mark;
print 'последняя строка :' + cast(@a as varchar(3))+ ', '+ rtrim(@mark);
fetch FIRST from Marks into @a, @mark;
print '2  строка   :' + cast(@a as varchar(3))+ ', '+ rtrim(@mark);
fetch NEXT  from Marks into @a, @mark;
print '2  строка :' + cast(@a as varchar(3))+ ', '+ rtrim(@mark);
fetch NEXT  from Marks into @a, @mark;
print 'Предыдущая строка от текущей  :' + cast(@a as varchar(3))+ ', '+ rtrim(@mark);
fetch ABSOLUTE 4  from Marks into @a, @mark;
print '4 строка от начала :' + cast(@a as varchar(3))+ ', '+ rtrim(@mark);
fetch ABSOLUTE  -4  from Marks into @a, @mark;
print '4 строка от конца :' + cast(@a as varchar(3))+ ', '+ rtrim(@mark);
fetch RELATIVE  2  from Marks into @a, @mark;
print '2 строка вперед от текущей :' + cast(@a as varchar(3))+ ', '+ rtrim(@mark);
fetch RELATIVE  -1  from Marks into @a, @mark;
print '1 строка назад от текущей :' + cast(@a as varchar(3))+ ', '+ rtrim(@mark);
close Marks
go;

--7.5
declare @id int, @mark int
declare task5 CURSOR LOCAL DYNAMIC
for select Успеваемость.ID, Успеваемость.Средняя_оценка from Успеваемость for update;
OPEN task5
FETCH  task5 INTO @id, @mark;
delete Успеваемость where current of task5;
FETCH  task5 INTO @id, @mark;
UPDATE Успеваемость 
	SET Успеваемость.Средняя_оценка = Средняя_оценка - 1
	WHERE current of task5
CLOSE task5;
go;

--7.6.1
declare @id int, @mark int
declare BadStudent CURSOR local DYNAMIC
for select Успеваемость.ID, Успеваемость.Средняя_оценка from Успеваемость for update;
OPEN BadStudent
delete Успеваемость where Успеваемость.Средняя_оценка <3;
FETCH  BadStudent INTO @id, @mark;
CLOSE BadStudent;
go;

--7.6.2
declare @id int, @mark int
declare GoodStudent CURSOR local DYNAMIC
for select Успеваемость.ID, Успеваемость.Средняя_оценка from Успеваемость for update;
OPEN GoodStudent
FETCH  GoodStudent INTO @id, @mark;
UPDATE Успеваемость 
	SET Успеваемость.Средняя_оценка = Средняя_оценка + 1
	WHERE Успеваемость.Номер_студенческого in (8888, 6666, 3333)
FETCH  GoodStudent INTO @id, @mark;
CLOSE GoodStudent;
go;