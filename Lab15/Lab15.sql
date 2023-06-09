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
print '�������� �������';
set @a1 = (select[TEACHER] from INSERTED );
set @a2 = (select [TEACHER_NAME] from INSERTED );
set @a3 = (select [GENDER] from INSERTED );
set @a4 = (select [PULPIT] from INSERTED );
set @in = @a1+ ' ' + @a2 + ' '+ @a3 + ' '+ @a4;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('INS','TR_TEACHER_IN', @in);
return;

insert TEACHER values('���', '����� ���� ��������', '�','��')
select * from TR_AUDIT 

--task2
go
create trigger TR_TEACHER_DEL on TEACHER after DELETE
as declare @a1 char(10), @a2 varchar(100),@a3 char(1), @a4 char(20), @in varchar(300);
print '�������� ��������';
set @a1 = (select[TEACHER] from deleted );
set @a2 = (select [TEACHER_NAME] from deleted );
set @a3 = (select [GENDER] from deleted );
set @a4 = (select [PULPIT] from deleted );
set @in = @a1+ ' ' + @a2 + ' '+ @a3 + ' '+ @a4;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('DEL','TR_TEACHER_DEL', @in);
return;

delete from TEACHER where TEACHER.TEACHER = '���';
select * from TR_AUDIT 
--task3
go
create trigger TR_TEACHER_UPD on TEACHER after UPDATE
as declare @a1 char(10), @a2 varchar(100),@a3 char(1), @a4 char(20), @in varchar(300);
print '�������� ����������';
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

update TEACHER set PULPIT = '����' where TEACHER = '���'
select * from TR_AUDIT 

--task4--------
go
create trigger TR_TEACHER on TEACHER after INSERT, DELETE, UPDATE  
as declare @a1 char(10), @a2 varchar(100),@a3 char(1), @a4 char(20), @in varchar(300);
declare @ins int = (select count(*) from inserted),
@del int = (select count(*) from deleted); 
if  @ins > 0 and  @del = 0  
begin
print '�������: INSERT';
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
print '�������: DELETE';
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
print '�������: UPDATE';
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

insert TEACHER values('���', '������ ���� ��������', '�','��')
update TEACHER set PULPIT = '����' where TEACHER.TEACHER = '���'
delete from TEACHER where TEACHER.TEACHER = '���';
select * from TR_AUDIT 

--task5
go
create trigger TR_PROG_UPD on PROGRESS after UPDATE
as declare @a1 char(10), @a2 varchar(100),@a3 char(1), @a4 char(20), @in varchar(300);
print '�������� ����������'; 
set @a1 = (select [IDSTUDENT] from INSERTED );
set @a2 = (select [NOTE] from INSERTED );
set @a3 = (select [PDATE] from INSERTED );
set @a4 = (select [SUBJECT] from INSERTED );
set @in = @a1+ ' ' + @a2 + ' '+ @a3 + ' '+ @a4;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('UPD','TR_PROG_UPD', @in);
return;

alter table PROGRESS add constraint NOTE check (NOTE <= 10)
update PROGRESS set PROGRESS.NOTE = 11 where PROGRESS.SUBJECT = '��'

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
raiserror('����� ��������������� �� ����� ���� > 600', 10 ,1);
rollback;
end
return;
update AUDITORIUM set AUDITORIUM_CAPACITY = 150 where AUDITORIUM.AUDITORIUM='413-1'

--task8
go
create trigger Teach_INSTEAD_OF on TEACHER instead of DELETE
as raiserror(N'�������� ���������',10,1);
return;
delete from TEACHER where TEACHER.TEACHER = '���';
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
     print '��� �������: '+@t;
     print '��� �������: '+@t1;
     print '��� �������: '+@t2;
     raiserror( N'�������� � �������� TEACHER ���������', 16, 1);  
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
create or alter trigger TR_STUD_IN on �������� after INSERT
as declare @a1 char(10), @a2 nvarchar(30),@a3 nvarchar(30), @a4 nvarchar(50),@a5 int, @in varchar(300);
print '�������� �������';
set @a1 = (select [�����_�������������] from INSERTED );
set @a2 = (select [�������] from INSERTED );
set @a3 = (select [���] from INSERTED );
set @a4 = (select [�����������] from INSERTED );
set @a5 = (select [����] from INSERTED );
set @in = @a1+ ' ' + @a2 + ' '+ @a3 + ' '+ @a4;
insert into TR_MyBase(STMT, TRNAME, CC) values ('INS','TR_STUD_IN', @in);
return;

insert �������� values('14178', '������', '����','������', 4)
select * from TR_MyBase 

--10.2
go
create or alter trigger TR_STUD_DEL on �������� after DELETE
as declare @a1 char(10), @a2 nvarchar(30),@a3 nvarchar(30), @a4 nvarchar(50),@a5 int, @in varchar(300);
print '�������� ��������';
set @a1 = (select [�����_�������������] from deleted );
set @a2 = (select [�������] from deleted );
set @a3 = (select [���] from deleted );
set @a4 = (select [�����������] from deleted );
set @a5 = (select [����] from deleted );
set @in = @a1+ ' ' + @a2 + ' '+ @a3 + ' '+ @a4;
insert into TR_MyBase(STMT, TRNAME, CC) values ('DEL','TR_STUD_DEL', @in);
return;
go
delete from �������� where ��������.�����_������������� = '14178'

select * from TR_MyBase 

--10.3
go;
create or alter trigger TR_STUD_UPD on �������� after INSERT
as declare @a1 char(10), @a2 nvarchar(30),@a3 nvarchar(30), @a4 nvarchar(50),@a5 int, @in varchar(300);
print '�������� ����������';
set @a1 = (select [�����_�������������] from INSERTED );
set @a2 = (select [�������] from INSERTED );
set @a3 = (select [���] from INSERTED );
set @a4 = (select [�����������] from INSERTED );
set @a5 = (select [����] from INSERTED );
set @in = @a1+ ' ' + @a2 + ' '+ @a3 + ' '+ @a4;
set @a1 = (select [�����_�������������] from deleted );
set @a2 = (select [�������] from deleted );
set @a3 = (select [���] from deleted );
set @a4 = (select [�����������] from deleted );
set @a5 = (select [����] from deleted );
set @in = @a1+ ' ' + @a2 + ' '+ @a3 + ' '+ @a4 + '' +@in;
insert into TR_MyBase(STMT, TRNAME, CC) values ('UPD','TR_STUD_UPD', @in);
return;

--insert �������� values('14178', '������', '����','������', 4)
update �������� set ���� = 4 where ��� ='������'
select * from TR_MyBase

go;
--10.4

create trigger TR_STUDENT on �������� after INSERT, DELETE, UPDATE  
as declare @a1 char(10), @a2 nvarchar(30),@a3 nvarchar(30), @a4 nvarchar(50),@a5 int, @in varchar(300);
declare @ins int = (select count(*) from inserted),
@del int = (select count(*) from deleted); 
if  @ins > 0 and  @del = 0  
begin
print '�������: INSERT';
set @a1 = (select [�����_�������������] from INSERTED );
set @a2 = (select [�������] from INSERTED );
set @a3 = (select [���] from INSERTED );
set @a4 = (select [�����������] from INSERTED );
set @a5 = (select [����] from INSERTED );
set @in = @a1+ ' ' + @a2 + ' '+ @a3 + ' '+ @a4;
insert into TR_MyBase(STMT, TRNAME, CC) values ('INS','TR_STUD_IN', @in);
end
else
if @ins = 0 and  @del > 0 
begin
print '�������: DELETE';
set @a1 = (select [�����_�������������] from deleted );
set @a2 = (select [�������] from deleted );
set @a3 = (select [���] from deleted );
set @a4 = (select [�����������] from deleted );
set @a5 = (select [����] from deleted );
set @in = @a1+ ' ' + @a2 + ' '+ @a3 + ' '+ @a4;
insert into TR_MyBase(STMT, TRNAME, CC) values ('DEL','TR_STUD_DEL', @in);
end
else 
if @ins > 0 and  @del > 0  
begin 
print '�������: UPDATE';
set @a1 = (select [�����_�������������] from INSERTED );
set @a2 = (select [�������] from INSERTED );
set @a3 = (select [���] from INSERTED );
set @a4 = (select [�����������] from INSERTED );
set @a5 = (select [����] from INSERTED );
set @in = @a1+ ' ' + @a2 + ' '+ @a3 + ' '+ @a4;
set @a1 = (select [�����_�������������] from deleted );
set @a2 = (select [�������] from deleted );
set @a3 = (select [���] from deleted );
set @a4 = (select [�����������] from deleted );
set @a5 = (select [����] from deleted );
set @in = @a1+ ' ' + @a2 + ' '+ @a3 + ' '+ @a4 + '' +@in;
insert into TR_MyBase(STMT, TRNAME, CC) values ('UPD','TR_STUD_UPD', @in);
end;
return;

--10.5
alter table �������� add constraint ���� check(����<7)
go
update �������� set ���� = 10 where ���= '������'

--10,6

go
create trigger TR_STUD_DEL1 on �������� after Delete 
as print 'TR_STUD_DELETE_1';
RETURN ;
go
create trigger TR_STUD_DEL2 on �������� after Delete 
as print 'TR_STUD_DELETE_2';
RETURN ;
go
create trigger TR_STUD_DEL3 on �������� after Delete 
as print 'TR_STUD_DELETE_3';
RETURN ;
go
select t.name, e.type_desc 
from sys.triggers  t join  sys.trigger_events e  
on t.object_id = e.object_id  
where OBJECT_NAME(t.parent_id) = '��������' and 
e.type_desc = 'Delete';  

exec  SP_SETTRIGGERORDER @triggername = 'TR_STUD_DEL2', 
 @order = 'Last', @stmttype = 'Delete';

exec  SP_SETTRIGGERORDER @triggername = 'TR_STUD_DEL3', 
 @order = 'First', @stmttype = 'Delete';
 go

 --10,7

create or alter trigger Stud_Tran on �������� AFTER INSERT, DELETE, UPDATE 
as declare @c int = (select ���� from �������� where ��������.�����_�������������='15154');
if(@c < 0)
begin 
raiserror('���� �� ����� ���� < 0', 10 ,1);
rollback;
end
return;
update �������� set ���� = -7 where  ��������.�����_�������������='15154'

--10.8
go
create trigger STUD_INSTEAD_OF on �������� instead of DELETE
as raiserror(N'�������� ���������',10,1);
return;
delete from �������� where ��������.�����_������������� = '77777';

go
create or alter  trigger DDL_STUD on database 
for DDL_DATABASE_LEVEL_EVENTS  as   
declare @t varchar(50) =  EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]', 'varchar(50)');
declare @t1 varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]', 'varchar(50)');
declare @t2 varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectType)[1]', 'varchar(50)'); 
if @t1 = '��������' 
begin
     print '��� �������: '+@t;
     print '��� �������: '+@t1;
     print '��� �������: '+@t2;
     raiserror( N'�������� � �������� �������� ���������', 16, 1);  
     rollback;    
 end;
 alter table �������� Drop Column ���
