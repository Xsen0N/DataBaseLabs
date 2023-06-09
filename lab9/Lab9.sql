--lab9

--task1
declare @ch char = 'a',
@vch varchar(2)= 'va',
@datet datetime = getdate(),
@ta time,
@i int,
@si smallint,
@ti tinyint,
@n numeric(12,5);
SET @ta = '10:25:10';
SET @i = 16;
SET @si = 2;
SET @ti = 0;
SET @n= 1234567.89412;
select @ch ch, @datet datet,@ta t ;
print 'si = ' +cast(@si as varchar(10));
print 'ti = ' +cast(@ti as varchar(10));
print 'n = ' +cast(@si as varchar(13));

--task2
use UNIVER
declare @count int, @sumcap numeric(8,3) = (select cast(sum (AUDITORIUM_CAPACITY)as numeric(8,3))from AUDITORIUM),
@cap real, @avgcap numeric(8,3)

if @sumcap> 200
begin 
SELECT @count = (select cast(count(*)as  numeric(8,3)) from AUDITORIUM),
@avgcap = (select cast(avg(AUDITORIUM_CAPACITY) as  numeric(8,3)) from AUDITORIUM )
set @cap = (select cast(COUNT(*) as  numeric(8,3)) from AUDITORIUM where AUDITORIUM_CAPACITY < @sumcap )
select @sumcap 'Общая', @count 'Кол-во', @avgcap 'Средняя вместимость',
@cap 'количество аудиторий, вместимость которых меньше средней'
end 
else if @sumcap < 200 print 'Общая вместимость < 200'

--task3
print 'число обработанных строк :'+ cast(@@ROWCOUNT as varchar(12));
print 'версия SQL Server: '+ cast(@@VERSION as varchar(max));
print 'cистемный идентификатор процесса, назначенный сервером текущему подключению: '+ cast(@@SPID  as varchar(5));
print 'код последней ошибки: '+ cast(@@ERROR  as varchar(12));
print 'имя сервера: '+ cast(@@SERVERNAME   as varchar(12));
print 'уровень вложенности транзакции: '+ cast(@@TRANCOUNT as varchar(12));
print 'проверка результата считывания строк результирующего набора: '+ cast(@@FETCH_STATUS as varchar(12));
print 'уровень вложенности текущей процедуры: '+ cast(@@NESTLEVEL as varchar(12));

--task4
--4.1
declare @t float = 14.5, @x float = 14.5, @z float
if( @t > @x )
set @z = power( sin(@t), 2);
else if ( @t < @x ) set @z = 4*(@t + @x);
else set @z = 1 - exp(@x -2);
print 'z = '+ cast(@z as varchar(10));
-----------------------------
--4.2
declare  @student nvarchar(max) = (select top(1) STUDENT.NAME from STUDENT), @surname varchar(20),@fname varchar(20), @midname varchar(20), @Shortname nvarchar(100);
set @surname = substring(@student, 1,CHARINDEX(' ', @student));
set @fname = LEFT(substring(@student, CHARINDEX(' ', @student)+1,Len(@surname)), 1)
set @midname = LEFT(substring(@student, CHARINDEX(' ', @student, CHARINDEX(' ', @student)+1)+1, LEN(@student)), 1)
set @Shortname = CONCAT( @surname, ' ',@fname, '. ', @midname, ' ' )
print   @student +' | '+ @Shortname ;
-----------------------------
--4.3 
Select STUDENT.NAME [Имя студента], STUDENT.BDAY [Дата рождения], DATEDIFF(YEAR, STUDENT.BDAY, SYSDATETIME()) AS [Полных лет]
FROM STUDENT 
WHERE MONTH(STUDENT.BDAY) = MONTH(DATEADD(m, 7, SYSDATETIME()))
------------------------
--4.4
DECLARE @testday date
SET @testday = (SELECT PROGRESS.PDATE
        FROM PROGRESS Inner Join STUDENT ON PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
        WHERE PROGRESS.SUBJECT in('БД') and STUDENT.IDSTUDENT in('1001'))
PRINT 'День недели, в который студент 1002 сдавал экзамен по БД: ' + CONVERT (varchar(12), DATEPART(dw, @testday))
---------------------------------------
--5
declare @capacity int = (select count(*) from AUDITORIUM_TYPE)
if (select count(*) from AUDITORIUM_TYPE) > 4 
begin
print 'кол-во типов аудиторий > 4';
print 'Их ' + cast(@capacity as varchar(10));
end;
else
begin
print 'кол-во аудиторий < 4';
print 'Их' + cast(@capacity as varchar(10));
end;
--6
select case
when Note between 0 and 3 then 'плохо'
when Note between 4 and 6 then 'нормально'
when Note between 7 and 9 then 'хорошо'
else 'очень хорошо'
end PROGRESS, COUNT(*)[Кол-во]
from dbo.PROGRESS
group by case
when Note between 0 and 3 then 'плохо'
when Note between 4 and 6 then 'нормально'
when Note between 7 and 9 then 'хорошо'
else 'очень хорошо'
end
--7
create table #Cats
( Имя varchar(30),
Возраст int,
Порода varchar(30) 
);
set nocount on;
declare @iter int = 0;
while @iter< 10
begin 
insert #Cats(Имя, Возраст, Порода )
values('Пума', floor(rand()*(10-5+1)+5), 'Дворняшка');
if @iter % 3 = 0
print @iter;
set @iter = @iter+1;
end;
--8
declare @item int = 0
print @item +1
print @item +2
print @item +3
return
print @item +10
--9
begin try
update dbo.STUDENT set IDSTUDENT = '1003' where IDSTUDENT = '1004'
end try
begin catch
print error_number()
print ERROR_MESSAGE()
print ERROR_LINE()
print ERROR_PROCEDURE()
print ERROR_SEVERITY()
print ERROR_STATE()
end catch