--lab14
use UNIVER
--task1
go 
drop function COUNT_STUDENTS
go
create function COUNT_STUDENTS( @faculty varchar(20) ) returns int
as begin declare @rc int = 0;
set @rc = (select count(*) from STUDENT inner join GROUPS on STUDENT.IDGROUP = GROUPS.IDGROUP inner join FACULTY on GROUPS.FACULTY = FACULTY.FACULTY where FACULTY.FACULTY = @faculty);
return @rc
end;
go

declare  @faculty int = dbo.COUNT_STUDENTS('��');
print '���-�� ���������= ' + cast(@faculty as varchar(4));
select  dbo.COUNT_STUDENTS('��')
select FACULTY.FACULTY, dbo.COUNT_STUDENTS(FACULTY.FACULTY) from FACULTY
go 

alter function COUNT_STUDENTS( @faculty varchar(20), @prof varchar(20) = null) returns int
as begin declare @rc int = 0;
set @rc = (select count(*) from STUDENT inner join GROUPS on STUDENT.IDGROUP = GROUPS.IDGROUP inner join FACULTY on GROUPS.FACULTY = FACULTY.FACULTY where FACULTY.FACULTY = @faculty or GROUPS.PROFESSION = @prof);
return @rc
end;
go
select  dbo.COUNT_STUDENTS('��','1-25 01 07')

go
--task2
drop function FSUBJECTS
go
create function FSUBJECTS( @p varchar(20) ) returns varchar(300) 
as begin 
declare @sb char(20);  
declare @k varchar(300) = '����������: ';  
declare Disc cursor local
for select SUBJECT.SUBJECT_NAME from SUBJECT where SUBJECT.PULPIT = @p;
open Disc
fetch Disc into @sb;
while @@fetch_status = 0 
begin 
set @k = @k+ ', ' + rtrim(@sb);   
fetch Disc into @sb;
end;
return @k;
end;
go
select SUBJECT.PULPIT, dbo.FSUBJECTS(SUBJECT.PULPIT) from SUBJECT group by SUBJECT.PULPIT
go

--task3--

drop function FSUBJECTS
go
create function FFACPUL(@facult varchar(20), @pulp varchar(30)) returns table 
as
return 
select f.FACULTY, p.PULPIT from FACULTY f
inner join PULPIT p on f.FACULTY= p.FACULTY 
where f.FACULTY = isnull(@facult,f.FACULTY)
and p.PULPIT = isnull(@pulp, p.PULPIT);

go
select * from dbo.FFACPUL('��', null)
select * from dbo.FFACPUL(null, null)
select * from dbo.FFACPUL('��', '����')
select * from dbo.FFACPUL('��', '��� ')
select * from dbo.FFACPUL(null, '����')
go
--task4
drop function FCTEACHER
go
create function FCTEACHER(@pulp as varchar(20)) returns int
as
begin
declare @c int =  (select count(*) from TEACHER 
inner join PULPIT on TEACHER.PULPIT = PULPIT.PULPIT where TEACHER.PULPIT = isnull(@pulp,TEACHER.PULPIT))
return @c
end
go
select PULPIT.PULPIT, dbo.FCTEACHER(PULPIT)[���-�� ��������������] from PULPIT
select dbo.FCTEACHER(null)[����� ��������������]

--task5
--task5.1
go 
Use Zhuk_Base
drop function COUNT_STUDENT
go
create function COUNT_STUDENT( @facult varchar(20) ) returns int
as
begin
declare @rc int = 0;
set @rc = (select count(*) from �������� 
inner join ������������ on ��������.����������� = ������������.��������_������������
where ��������.����������� = @facult);
return @rc
end;
go
declare  @facult int = dbo.COUNT_STUDENT('����������');
print '���-�� ��������� �� ������������= ' + cast(@facult as varchar(4));
select  dbo.COUNT_STUDENT('����������')
select ������������.��������_������������, dbo.COUNT_STUDENT(������������.��������_������������) from ������������
go 
alter function COUNT_STUDENT( @facult varchar(20),@id int ) returns int
as
begin
declare @rc int = 0;
set @rc = (select count(*) from �������� 
inner join ������������ on ��������.����������� = ������������.��������_������������
inner join ������������� on ������������.ID_������� = �������������.ID_�������
where ��������.����������� = @facult and  ������������.ID_������� = @id );
return @rc
end;
go
select  dbo.COUNT_STUDENT('����������',27)
select ������������.��������_������������, dbo.COUNT_STUDENT(������������.��������_������������, 6) from ������������
go

--task 5.2-----------------------------------

drop function IDFACULT
go
create function IDFACULT( @id int  ) returns varchar(300) 
as begin 
declare @sb char(20);  
declare @k varchar(300) = '������������: ';  
declare Disc cursor local
for select ������������.��������_������������ from  ������������ where ������������.ID_������� = @id
open Disc
fetch Disc into @sb;
while @@fetch_status = 0 
begin 
set @k = @k+ ', ' + rtrim(@sb);   
fetch Disc into @sb;
end;
return @k;
end;
go
select ������������.ID_�������, dbo.IDFACULT(������������.ID_�������) from ������������ group by ������������.ID_�������
go

--task5.3--

drop function FFACULT
go
create function FFACULT(@facult varchar(20), @id int) returns table 
as
return 
select f.��������_������������, p.ID_������� from ������������ f
inner join ������������� p  on f.ID_�������= p.ID_������� 
where f.��������_������������ = isnull(@facult,f.��������_������������)
and p.ID_������� = isnull(@id,p.ID_�������);

go
select * from dbo.FFACULT('��������', null)
select * from dbo.FFACULT(null, null)
select * from dbo.FFACULT('��������', '6')
select * from dbo.FFACULT('��������', '21 ')
select * from dbo.FFACULT(null, '6')
go
--task4,4
drop function FSTUD
go
create function FSTUD(@facult as varchar(20)) returns int
as
begin
declare @c int =  (select count(*) from �������� 
inner join ������������ on ��������.����������� =������������.��������_������������  where ��������.����������� = isnull(@facult,��������.�����������))
return @c
end
go
select ������������.��������_������������, dbo.FSTUD(������������.��������_������������)[���-�� ���������] from ������������
select dbo.FSTUD(null)[����� ]

--task6
use UNIVER
go
create or alter function FACULTY_REPORT(@c int) returns @fr table
( [���������] varchar(50), [���������� ������] int, [���������� �����]  int, 
 [���������� ���������] int, [���������� ��������������] int )
as begin 
declare cc CURSOR static for 
select FACULTY from FACULTY 
where dbo.COUNT_STUDENTS(FACULTY, default) > @c; 
declare @f varchar(30);
open cc;  
fetch cc into @f;
while @@fetch_status = 0
begin
insert @fr values( @f,  (select count(PULPIT) from PULPIT where FACULTY = @f),
(select count(IDGROUP) from GROUPS where FACULTY = @f),   dbo.COUNT_STUDENTS(@f, default),
(select count(PROFESSION) from PROFESSION where FACULTY = @f)   ); 
fetch cc into @f;  
end;   
return; 
end;
go
--select  PROFESSION.FACULTY,PROFESSION.PROFESSION , dbo.COUNT_STUDENTS(PROFESSION.FACULTY,PROFESSION.PROFESSION),dbo.FACULTY_REPORT(dbo.COUNT_STUDENTS) from  PROFESSION
select * from dbo.FACULTY_REPORT(0)
-----------
go
drop function COUNT_GROUP
go
create function COUNT_GROUP( @f varchar(20) ) returns int
as begin declare @rc int = 0;
set @rc = (select count(IDGROUP) from GROUPS where FACULTY = @f);
return @rc
end;
go 
select GROUPS.FACULTY, dbo.COUNT_GROUP(GROUPS.FACULTY) from GROUPS
drop function COUNT_PROF
go
create function COUNT_PROF( @f varchar(20) ) returns int
as begin declare @rc int = 0;
set @rc = (select count(PULPIT) from PULPIT where FACULTY = @f);
return @rc
end;
go
select PULPIT.FACULTY, dbo. COUNT_PROF(PULPIT.FACULTY) from PULPIT
drop function COUNT_PULPIT
go
create function COUNT_PULPIT( @f varchar(20) ) returns int
as begin declare @rc int = 0;
set @rc = (select count(PROFESSION) from PROFESSION where FACULTY = @f);
return @rc
end;
go
select PROFESSION.FACULTY, dbo. COUNT_PULPIT(PROFESSION.FACULTY) from PROFESSION