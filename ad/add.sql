--пред с кафедры исит через запятую
use UNIVER
declare @t nvarchar(30), @s varchar(max) = ' '
declare Prepod cursor 
for
select TEACHER.TEACHER_NAME from TEACHER where TEACHER.PULPIT = 'ИСиТ'
open Prepod
fetch Prepod into @t
while @@FETCH_STATUS = 0
begin 
set @s = RTRIM(@t) +','+ @s ;
fetch Prepod into @t;
end 
print @s
close Prepod

go
use univer
declare Qwert cursor
for select AUDITORIUM.AUDITORIUM from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = 'ЛК'
declare @a nvarchar(30), @all Nvarchar(max) = ' '
open Qwert 
fetch Qwert into @a
while @@FETCH_STATUS = 0
begin 
if @a != '317-1'
begin
set @all  = RTRIM(@a ) + ','+ @all
end
fetch Qwert into @a

end 
print @all ;
close Qwert
go

use Zhuk_Base
go
create or alter procedure Iprodec @S int
as 
begin 
select * from Студенты where Курс =  @S
end 
go
declare @S int = 0
exec Iprodec @S = 2


use UNIVER
go
create or alter procedure FINDXT @p nvarchar(6)
as
begin try
declare @rc int = 1;
	select PULPIT [Кафедра] from PULPIT where PULPIT.FACULTY = @p
	return @rc
end try
begin catch
	set @rc = -1
	return @rc;
end catch
go
declare @rc int 
exec @rc = FINDXT  @p = 'GVG'
print 'Cocтояние ' + cast(@rc as varchar(3)); 

go
create or alter procedure FINDXT @p nvarchar(6)
as
begin 
declare @rc int = 1;
	select PULPIT [Кафедра] from PULPIT where PULPIT.FACULTY = @p
	
end 
go
declare @p nvarchar(6)
exec FINDXT @p = 'ХТиТ'

go
create or alter function Qqwe (@f varchar(30), @k varchar(30)) returns int
as 
begin 
declare @c int = 0
set @c = (select count(*) from STUDENT inner join GROUPS on STUDENT.IDGROUP = GROUPS.IDGROUP  where  GROUPS.FACULTY = @f and GROUPS.PROFESSION = @k)
return @c
end
go
select GROUPS.FACULTY, GROUPS.PROFESSION, dbo.Qqwe('ХТиТ','1-36 07 01') from GROUPS


--cursors

declare @pr varchar(30), @s varchar(max)=' '
declare NewCUr cursor
for select AUDITORIUM from AUDITORIUM where AUDITORIUM_TYPE = 'ЛК'
open NewCUr 
fetch NewCUr into @pr
while @@FETCH_STATUS=0
begin
set @s = RTRIM(@pr)+ ' '+@s;
fetch NewCUr into @pr
end
print @s
close NewCUr

go

create or alter procedure Procqw  @a varchar(30)
as 
begin
select COUNT(*) from AUDITORIUM where AUDITORIUM_TYPE = @a
end

declare @a varchar(30)
exec Procqw @a ='ЛК'



declare Curse cursor
for 
select AUDITORIUM from AUDITORIUM where AUDITORIUM_TYPE='ЛК'
declare @p varchar(30), @str varchar(300) = ''
open Curse
fetch Curse into @p
while @@FETCH_STATUS=0
begin
set @str = RTRIM(@p)+','+@str
fetch Curse into @p
end
print @str
close Curse
go
crEATE PROCEDURE Prte @p varchar(30)
as
begin
select count(*) from AUDITORIUM where AUDITORIUM_TYPE = @p
end

declare @p varchar(30)
exec Prte @p = 'ЛК'
print 'scwcwcw='+ cast(@p as varchar(10))

go
create function Func (@p varchar(30), @k varchar(30)) returns int
as 
begin
declare @c int
set @c = (select count(*) from )
end
