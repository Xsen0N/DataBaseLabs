--lab15

--task1

create table TR_AUDIT(
ID int identity,
STMT varchar(20)
check (STMT in ('INS','DEL','UPD')),
TRNAME varchar(50),
CC varchar(300)
)
go
create or alter trigger TR_TEACHER_IN on TEACHER after INSERT
as declare @a1 char(10), @a2 varchar(100),@a3 char(1), @a4 char(20), @in varchar(300);
print 'Операция вставки';
set @a1 = (select[TEACHER] from INSERTED );
set @a2 = (select [TEACHER_NAME] from INSERTED );
set @a3 = (select [GENDER] from INSERTED );
set @a4 = (select [PULPIT] from INSERTED );
set @in = @a1+ ' ' + @a2 + ' '+ @a3 + ' '+ @a4;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('INS','TR_TEACHER_IN', @in);
return;

insert TEACHER values('ЩПИ', 'Щукин Петр Иванович', 'м','ТЛ')
select * from TR_AUDIT 

--task2
go
create trigger TR_TEACHER_DEL on TEACHER after DELETE
as declare @a1 char(10), @a2 varchar(100),@a3 char(1), @a4 char(20), @in varchar(300);
print 'Операция удаления';
set @a1 = (select[TEACHER] from deleted );
set @a2 = (select [TEACHER_NAME] from deleted );
set @a3 = (select [GENDER] from deleted );
set @a4 = (select [PULPIT] from deleted );
set @in = @a1+ ' ' + @a2 + ' '+ @a3 + ' '+ @a4;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('DEL','TR_TEACHER_DEL', @in);
return;

delete from TEACHER where TEACHER.TEACHER = 'ППИ';
select * from TR_AUDIT 
--task3
go
create trigger TR_TEACHER_UPD on TEACHER after UPDATE
as declare @a1 char(10), @a2 varchar(100),@a3 char(1), @a4 char(20), @in varchar(300);
print 'Операция обновления';
set @a1 = (select[TEACHER] from INSERTED );
set @a2 = (select [TEACHER_NAME] from INSERTED );
set @a3 = (select [GENDER] from INSERTED );
set @a4 = (select [PULPIT] from INSERTED );
set @in = @a1+ ' ' + @a2 + ' '+ @a3 + ' '+ @a4;
set @a1 = (select[TEACHER] from deleted );
set @a2 = (select [TEACHER_NAME] from deleted );
set @a3 = (select [GENDER] from deleted );
set @a4 = (select [PULPIT] from deleted );
set @in = @a1+ ' ' + @a2 + ' '+ @a3 + ' '+ @a4+ '' +@in;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('UPD','TR_TEACHER_UPD', @in);
return;

update TEACHER set PULPIT = 'ПОИТ' where TEACHER = 'ДТК'
select * from TR_AUDIT 

--task4--------
go
create trigger TR_TEACHER on TEACHER after INSERT, DELETE, UPDATE  
as declare @a1 char(10), @a2 varchar(100),@a3 char(1), @a4 char(20), @in varchar(300);
declare @ins int = (select count(*) from inserted),
@del int = (select count(*) from deleted); 
if  @ins > 0 and  @del = 0  
begin
print 'Событие: INSERT';
set @a1 = (select[TEACHER] from INSERTED );
set @a2 = (select [TEACHER_NAME] from INSERTED );
set @a3 = (select [GENDER] from INSERTED );
set @a4 = (select [PULPIT] from INSERTED );
set @in = @a1+ ' ' + @a2 + ' '+ @a3 + ' '+ @a4;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('INS','TR_TEACHER_IN', @in);
end
else
if @ins = 0 and  @del > 0 
begin
print 'Событие: DELETE';
set @a1 = (select[TEACHER] from deleted );
set @a2 = (select [TEACHER_NAME] from deleted );
set @a3 = (select [GENDER] from deleted );
set @a4 = (select [PULPIT] from deleted );
set @in = @a1+ ' ' + @a2 + ' '+ @a3 + ' '+ @a4;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('DEL','TR_TEACHER_IN', @in);
end
else 
if @ins > 0 and  @del > 0  
begin 
print 'Событие: UPDATE';
set @a1 = (select[TEACHER] from INSERTED );
set @a2 = (select [TEACHER_NAME] from INSERTED );
set @a3 = (select [GENDER] from INSERTED );
set @a4 = (select [PULPIT] from INSERTED );
set @in = @a1+ ' ' + @a2 + ' '+ @a3 + ' '+ @a4;
set @a1 = (select[TEACHER] from deleted );
set @a2 = (select [TEACHER_NAME] from deleted );
set @a3 = (select [GENDER] from deleted );
set @a4 = (select [PULPIT] from deleted );
set @in = @a1+ ' ' + @a2 + ' '+ @a3 + ' '+ @a4+ '' +@in;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('UPD','TR_TEACHER_IN', @in);
end;
return;

insert TEACHER values('ППК', 'Петров Петр Иванович', 'м','ТЛ')
update TEACHER set PULPIT = 'ИСиТ' where TEACHER.TEACHER = 'ППИ'
delete from TEACHER where TEACHER.TEACHER = 'ППИ';
select * from TR_AUDIT 

--task5
go
create trigger TR_PROG_UPD on PROGRESS after UPDATE
as declare @a1 char(10), @a2 varchar(100),@a3 char(1), @a4 char(20), @in varchar(300);
print 'Операция обновления'; 
set @a1 = (select [IDSTUDENT] from INSERTED );
set @a2 = (select [NOTE] from INSERTED );
set @a3 = (select [PDATE] from INSERTED );
set @a4 = (select [SUBJECT] from INSERTED );
set @in = @a1+ ' ' + @a2 + ' '+ @a3 + ' '+ @a4;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('UPD','TR_PROG_UPD', @in);
return;

alter table PROGRESS add constraint NOTE check (NOTE <= 10)
update PROGRESS set PROGRESS.NOTE = 11 where PROGRESS.SUBJECT = 'ЭТ'

select * from TR_AUDIT

--task6
go
create trigger TR_TEACHER_DEL1 on TEACHER after Delete 
as print 'TR_TEACHER_DELETE_1';
RETURN ;
go
create trigger TR_TEACHER_DEL2 on TEACHER after Delete 
as print 'TR_TEACHER_DELETE_2';
RETURN ;
go
create trigger TR_TEACHER_DEL3 on TEACHER after Delete 
as print 'TR_TEACHER_DELETE_3';
RETURN ;
go
select t.name, e.type_desc 
from sys.triggers  t join  sys.trigger_events e  
on t.object_id = e.object_id  
where OBJECT_NAME(t.parent_id) = 'TEACHER' and 
e.type_desc = 'Delete';  

exec  SP_SETTRIGGERORDER @triggername = 'TR_TEACHER_DEL2', 
 @order = 'Last', @stmttype = 'Delete';

exec  SP_SETTRIGGERORDER @triggername = 'TR_TEACHER_DEL3', 
 @order = 'First', @stmttype = 'Delete';
 go
--task7
create or alter trigger Aud_Tran on AUDITORIUM AFTER INSERT, DELETE, UPDATE 
as declare @c int = (select sum(AUDITORIUM.AUDITORIUM_CAPACITY) from AUDITORIUM);
if(@c > 600)
begin 
raiserror('Общая вместительность не может быть > 600', 10 ,1);
rollback;
end
return;
update AUDITORIUM set AUDITORIUM_CAPACITY = 150 where AUDITORIUM.AUDITORIUM='413-1'

--task8
go
create trigger Teach_INSTEAD_OF on TEACHER instead of DELETE
as raiserror(N'Удаление запрещено',10,1);
return;
delete from TEACHER where TEACHER.TEACHER = 'БРГ';
---------------------------------------------------------------------------------------------

drop trigger TR_TEACHER_IN, TR_TEACHER,TR_TEACHER_DEL1,TR_TEACHER_DEL2,TR_TEACHER_DEL3
drop trigger TR_TEACHER_DEL, TR_TEACHER_UPD
drop trigger TR_PROG_UPD
drop trigger Teach_INSTEAD_OF, Aud_Tran
--task9
go
create  trigger DDL_TEACHER on database 
for DDL_DATABASE_LEVEL_EVENTS  as   
declare @t varchar(50) =  EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]', 'varchar(50)');
declare @t1 varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]', 'varchar(50)');
declare @t2 varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectType)[1]', 'varchar(50)'); 
if @t1 = 'TEACHER' 
begin
     print 'Тип события: '+@t;
     print 'Имя объекта: '+@t1;
     print 'Тип объекта: '+@t2;
     raiserror( N'операции с таблицей TEACHER запрещены', 16, 1);  
     rollback;    
 end;
 alter table TEACHER Drop Column TEACHER_NAME

 --task10

 --10.1
 create table TR_MyBase(
ID int identity,
STMT varchar(20)
check (STMT in ('INS','DEL','UPD')),
TRNAME varchar(50),
CC varchar(300)
)
go
create or alter trigger TR_STUD_IN on Студенты after INSERT
as declare @a1 char(10), @a2 nvarchar(30),@a3 nvarchar(30), @a4 nvarchar(50),@a5 int, @in varchar(300);
print 'Операция вставки';
set @a1 = (select [Номер_студенческого] from INSERTED );
set @a2 = (select [Фамилия] from INSERTED );
set @a3 = (select [Имя] from INSERTED );
set @a4 = (select [Факультатив] from INSERTED );
set @a5 = (select [Курс] from INSERTED );
set @in = @a1+ ' ' + @a2 + ' '+ @a3 + ' '+ @a4;
insert into TR_MyBase(STMT, TRNAME, CC) values ('INS','TR_STUD_IN', @in);
return;

insert Студенты values('14178', 'Иванов', 'Петр','Логика', 4)
select * from TR_MyBase 

--10.2
go
create or alter trigger TR_STUD_DEL on Студенты after DELETE
as declare @a1 char(10), @a2 nvarchar(30),@a3 nvarchar(30), @a4 nvarchar(50),@a5 int, @in varchar(300);
print 'Операция удаления';
set @a1 = (select [Номер_студенческого] from deleted );
set @a2 = (select [Фамилия] from deleted );
set @a3 = (select [Имя] from deleted );
set @a4 = (select [Факультатив] from deleted );
set @a5 = (select [Курс] from deleted );
set @in = @a1+ ' ' + @a2 + ' '+ @a3 + ' '+ @a4;
insert into TR_MyBase(STMT, TRNAME, CC) values ('DEL','TR_STUD_DEL', @in);
return;
go
delete from Студенты where Студенты.Номер_студенческого = '14178'

select * from TR_MyBase 

--10.3
go;
create or alter trigger TR_STUD_UPD on Студенты after INSERT
as declare @a1 char(10), @a2 nvarchar(30),@a3 nvarchar(30), @a4 nvarchar(50),@a5 int, @in varchar(300);
print 'Операция обновления';
set @a1 = (select [Номер_студенческого] from INSERTED );
set @a2 = (select [Фамилия] from INSERTED );
set @a3 = (select [Имя] from INSERTED );
set @a4 = (select [Факультатив] from INSERTED );
set @a5 = (select [Курс] from INSERTED );
set @in = @a1+ ' ' + @a2 + ' '+ @a3 + ' '+ @a4;
set @a1 = (select [Номер_студенческого] from deleted );
set @a2 = (select [Фамилия] from deleted );
set @a3 = (select [Имя] from deleted );
set @a4 = (select [Факультатив] from deleted );
set @a5 = (select [Курс] from deleted );
set @in = @a1+ ' ' + @a2 + ' '+ @a3 + ' '+ @a4 + '' +@in;
insert into TR_MyBase(STMT, TRNAME, CC) values ('UPD','TR_STUD_UPD', @in);
return;

--insert Студенты values('14178', 'Иванов', 'Петр','Логика', 4)
update Студенты set Курс = 4 where Имя ='Сергей'
select * from TR_MyBase

go;
--10.4

create trigger TR_STUDENT on Студенты after INSERT, DELETE, UPDATE  
as declare @a1 char(10), @a2 nvarchar(30),@a3 nvarchar(30), @a4 nvarchar(50),@a5 int, @in varchar(300);
declare @ins int = (select count(*) from inserted),
@del int = (select count(*) from deleted); 
if  @ins > 0 and  @del = 0  
begin
print 'Событие: INSERT';
set @a1 = (select [Номер_студенческого] from INSERTED );
set @a2 = (select [Фамилия] from INSERTED );
set @a3 = (select [Имя] from INSERTED );
set @a4 = (select [Факультатив] from INSERTED );
set @a5 = (select [Курс] from INSERTED );
set @in = @a1+ ' ' + @a2 + ' '+ @a3 + ' '+ @a4;
insert into TR_MyBase(STMT, TRNAME, CC) values ('INS','TR_STUD_IN', @in);
end
else
if @ins = 0 and  @del > 0 
begin
print 'Событие: DELETE';
set @a1 = (select [Номер_студенческого] from deleted );
set @a2 = (select [Фамилия] from deleted );
set @a3 = (select [Имя] from deleted );
set @a4 = (select [Факультатив] from deleted );
set @a5 = (select [Курс] from deleted );
set @in = @a1+ ' ' + @a2 + ' '+ @a3 + ' '+ @a4;
insert into TR_MyBase(STMT, TRNAME, CC) values ('DEL','TR_STUD_DEL', @in);
end
else 
if @ins > 0 and  @del > 0  
begin 
print 'Событие: UPDATE';
set @a1 = (select [Номер_студенческого] from INSERTED );
set @a2 = (select [Фамилия] from INSERTED );
set @a3 = (select [Имя] from INSERTED );
set @a4 = (select [Факультатив] from INSERTED );
set @a5 = (select [Курс] from INSERTED );
set @in = @a1+ ' ' + @a2 + ' '+ @a3 + ' '+ @a4;
set @a1 = (select [Номер_студенческого] from deleted );
set @a2 = (select [Фамилия] from deleted );
set @a3 = (select [Имя] from deleted );
set @a4 = (select [Факультатив] from deleted );
set @a5 = (select [Курс] from deleted );
set @in = @a1+ ' ' + @a2 + ' '+ @a3 + ' '+ @a4 + '' +@in;
insert into TR_MyBase(STMT, TRNAME, CC) values ('UPD','TR_STUD_UPD', @in);
end;
return;

--10.5
alter table Студенты add constraint Курс check(Курс<7)
go
update Студенты set Курс = 10 where Имя= 'Сергей'

--10,6

go
create trigger TR_STUD_DEL1 on Студенты after Delete 
as print 'TR_STUD_DELETE_1';
RETURN ;
go
create trigger TR_STUD_DEL2 on Студенты after Delete 
as print 'TR_STUD_DELETE_2';
RETURN ;
go
create trigger TR_STUD_DEL3 on Студенты after Delete 
as print 'TR_STUD_DELETE_3';
RETURN ;
go
select t.name, e.type_desc 
from sys.triggers  t join  sys.trigger_events e  
on t.object_id = e.object_id  
where OBJECT_NAME(t.parent_id) = 'Студенты' and 
e.type_desc = 'Delete';  

exec  SP_SETTRIGGERORDER @triggername = 'TR_STUD_DEL2', 
 @order = 'Last', @stmttype = 'Delete';

exec  SP_SETTRIGGERORDER @triggername = 'TR_STUD_DEL3', 
 @order = 'First', @stmttype = 'Delete';
 go

 --10,7

create or alter trigger Stud_Tran on Студенты AFTER INSERT, DELETE, UPDATE 
as declare @c int = (select Курс from Студенты where Студенты.Номер_студенческого='15154');
if(@c < 0)
begin 
raiserror('Курс не может быть < 0', 10 ,1);
rollback;
end
return;
update Студенты set Курс = -7 where  Студенты.Номер_студенческого='15154'

--10.8
go
create trigger STUD_INSTEAD_OF on Студенты instead of DELETE
as raiserror(N'Удаление запрещено',10,1);
return;
delete from Студенты where Студенты.Номер_студенческого = '77777';

go
create or alter  trigger DDL_STUD on database 
for DDL_DATABASE_LEVEL_EVENTS  as   
declare @t varchar(50) =  EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]', 'varchar(50)');
declare @t1 varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]', 'varchar(50)');
declare @t2 varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectType)[1]', 'varchar(50)'); 
if @t1 = 'Студенты' 
begin
     print 'Тип события: '+@t;
     print 'Имя объекта: '+@t1;
     print 'Тип объекта: '+@t2;
     raiserror( N'операции с таблицей Студенты запрещены', 16, 1);  
     rollback;    
 end;
 alter table Студенты Drop Column Имя
