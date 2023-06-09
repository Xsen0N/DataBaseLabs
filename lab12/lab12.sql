--lab12

--create table #STRINGS
--(id int,
--cc int identity(1,1),
--name varchar(100)
--);
--go
--set nocount on;
--declare @i int =0;
--while @i < 10000
--begin 
--insert #STRINGS(id, name) 
--values (floor(3000*rand()),'string');
--set @i = @i+1;
--end;
--go;


set nocount on
if  exists (select * from  SYS.OBJECTS        -- ������� X ����?
	where OBJECT_ID= object_id(N'DBO.STRINGS') )	            
drop table #STRINGS;           
declare @c int, @flag char = 'c';           -- commit ��� rollback?
SET IMPLICIT_TRANSACTIONS  ON   -- �����. ����� ������� ����������
CREATE table #STRINGS(K int );                         -- ������ ���������� 
INSERT #STRINGS values (1),(2),(3);
set @c = (select count(*) from #STRINGS);
print '���������� ����� � ������� #STRINGS: ' + cast( @c as varchar(2));
if @flag = 'c'  commit;                   -- ���������� ����������: �������� 
else   rollback;                                 -- ���������� ����������: �����  
SET IMPLICIT_TRANSACTIONS  OFF   -- ������. ����� ������� ����������

if  exists (select * from  SYS.OBJECTS       -- ������� X ����?
	            where OBJECT_ID= object_id(N'DBO.STRINGS') )
print '������� #STRINGS ����';  
   else print '������� #STRINGS ���'

----------------------------
--task2
use UNIVER
begin try
begin tran
delete TEACHER where TEACHER.PULPIT = '��';
delete SUBJECT where SUBJECT.SUBJECT_NAME like '%������%';
insert SUBJECT values ('��','�������������� ������', '����');
insert SUBJECT values ('��','���������� �������� ', '��');
commit tran;
end try 
begin catch
print 'error: '+ case
when error_number()=2627 and patindex('%SUBJECT_PK%', error_message())>0
then '������������'
when error_number()=547 
then '������ � ������������ FOREIGN KEY'
else '����������� ������: '+ cast(error_number()as varchar(5))+ error_message()
end;
if @@trancount > 0 rollback tran;
end catch

--task3
declare @point varchar(32);
begin try
  begin tran
  delete SUBJECT where SUBJECT.SUBJECT = 'MA';
  set @point = 'p1';save tran @point;
  insert SUBJECT values ('��','�������������� ������', '����');
  set @point = 'p2';save tran @point;
  insert SUBJECT values ('��','���������� �������� ', '��');
  set @point = 'p3';save tran @point;
  update STUDENT 
  set IDSTUDENT = 1006 where IDSTUDENT = 1005
  commit tran;
end try
begin catch
   print 'error: '+ case
      when error_number()=2627 and patindex('%SUBJECT_PK%', error_message())>0
      then '������������'
      when error_number()=2627 and patindex('%STUDENT_PK%', error_message())>0
      then '������������� �������� �����'
      when error_number()=547 
      then '������  � ������������ FOREIGN KEY'
      else '����������� ������: '+ cast(error_number()as varchar(5))+ error_message()
   end;
if @@trancount > 0 
  begin 
  print '����������� �����: ' + @point;
  rollback tran @point;
  commit tran;
end;
end catch

--task4

--A---
set transaction isolation level READ UNCOMMITTED 
	begin transaction 
---t1
select @@SPID, 'insert SUBJECT''���������',* from SUBJECT
where SUBJECT.SUBJECT like ('�_%');
select @@SPID, 'update Progress' '���������',PROGRESS.SUBJECT,
PROGRESS.NOTE from PROGRESS where PROGRESS.SUBJECT like ('�_%');
commit;
---------t2----------------
--B
begin transaction 
select @@SPID
insert SUBJECT values ('��','������������� �������', '����')
update Progress set PROGRESS.SUBJECT = '��'
where PROGRESS.SUBJECT = '�T'
------t1-----
-------t2----------
rollback;

--task 5
--A--
set transaction isolation level READ COMMITTED 
	begin transaction
select count(*) from PROGRESS where NOTE < 4;
------t1-----
-------t2----------
select 'update PROGRESS ''result', count(*)[���-��]
from PROGRESS where Note < 4;
commit;

----B---
begin transaction 
-----------t1--------
update PROGRESS set Note = Note+1
where Note < 4
commit;
-----------t2------------

--task6---
-- A ---
set transaction isolation level  REPEATABLE READ 
	begin transaction 
	select PROGRESS.IDSTUDENT from PROGRESS where Note = 7;
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
select case
when PROGRESS.SUBJECT like ('%�%') then 'insert PROGRESS' else ''
end 'result',SUBJECT from PROGRESS where Note >6;
-------------------------------
commit;

--B--
begin transaction 
---------t1--------
insert PROGRESS values('���', 1009, '01.12.2013', 6);
commit;
-------t2-------

--task7
      -- A ---
set transaction isolation level SERIALIZABLE 
	begin transaction 
delete PROGRESS where SUBJECT = '��'; 
insert PROGRESS values('��', 1007, '01.12.2013', 6);
update PROGRESS set Note = Note-1 where SUBJECT= '��';
select Note from PROGRESS where SUBJECT= '��';
------------t1--------------
--select Note from PROGRESS where SUBJECT= '��';
----------t2-------------
commit;

--B--
begin transaction 
delete PROGRESS where SUBJECT = '��'; 
insert PROGRESS values('��', 1007, '01.12.2013', 6);
update PROGRESS set Note = Note-1 where SUBJECT= '��';
select Note from PROGRESS where SUBJECT= '��';
------------t1--------------
commit;
select Note from PROGRESS where SUBJECT= '��';
----------t2-------------

--task8
begin tran
insert SUBJECT values ('���','������������ ���-����������', '����');
begin tran
update PROGRESS set  PROGRESS.SUBJECT= '���'where IDSTUDENT = 1010 and IDSTUDENT = 1005 ;
commit;
if @@TRANCOUNT > 0 rollback;
select 
(select count(*) from SUBJECT where SUBJECT= '���' )'Test',
(select count(*) from PROGRESS where SUBJECT= '���' )'Students';

-- task9---

--9.1
create table Zhuk
(id int,
cc int identity(1,1),
name varchar(100)
);
go
set nocount on;
declare @i int =0;
while @i < 10000
begin 
insert Zhuk(id, name) 
values (floor(3000*rand()),'string');
set @i = @i+1;
end;
go;
use Zhuk_Base
set nocount on
if  exists (select * from  SYS.OBJECTS        -- ������� X ����?
	where OBJECT_ID= object_id(N'DBO.Zhuk') )	            
drop table Zhuk;           
declare @c int, @flag char = 'c';           -- commit ��� rollback?
SET IMPLICIT_TRANSACTIONS  ON   -- �����. ����� ������� ����������
CREATE table Zhuk(K int );                         -- ������ ���������� 
INSERT Zhuk values (1),(2), (3);
set @c = (select count(*) from Zhuk);
print '���������� ����� � ������� Zhuk: ' + cast( @c as varchar(2));
if @flag = 'c'  commit;                   -- ���������� ����������: �������� 
else   rollback;                                 -- ���������� ����������: �����  
SET IMPLICIT_TRANSACTIONS  OFF   -- ������. ����� ������� ����������

if  exists (select * from  SYS.OBJECTS       -- ������� Zhuk ����?
	            where OBJECT_ID= object_id(N'DBO.Zhuk') )
print '������� Zhuk ����';  
   else print '������� Zhuk ���'

--9.2

begin try
begin tran
delete �������� where ��������.����������� = '��';
delete ������������ where ������������.O����_������������ = 4;
insert ������������ values ('�������� �������������',7, 15,4, 3);
insert ������������ values ('�������',15,45,1,2 );
commit tran;
end try 
begin catch
print 'error: '+ case
when error_number()=2627 and patindex('%PK_��������%', error_message())>0
then '������������'
when error_number()=547 
then '������ � ������������ FOREIGN KEY'
else '����������� ������: '+ cast(error_number()as varchar(5))+ error_message()
end;
if @@trancount > 0 rollback tran;
end catch

--9.3

declare @point varchar(32);
begin try
  begin tran
  delete ������������ where ������������.��������_������������ = '�������';
  set @point = 'p1';save tran @point;
  insert ������������ values ('�������� �������������',7, 15,4, 3);
  set @point = 'p2';save tran @point;
  insert ������������ values ('�������',6, 14,4, 4);
  set @point = 'p3';save tran @point;
  update �������� 
  set �����_������������� = 22222 where �����_������������� = 55555
  commit tran;
end try
begin catch
   print 'error: '+ case
      when error_number()=2627 and patindex('%PK_��������%', error_message())>0
      then '������������'
      when error_number()=2627 and patindex('%PK_��������%', error_message())>0
      then '������������� �������� �����'
      when error_number()=547 
      then '������ � ������������ FOREIGN KEY'
      else '����������� ������: '+ cast(error_number()as varchar(5))+ error_message()
   end;
if @@trancount > 0 
  begin 
  print '����������� �����: ' + @point;
  rollback tran @point;
  commit tran;
end;
end catch

--9.4

--A---
set transaction isolation level READ UNCOMMITTED 
	begin transaction 
---t1
select @@SPID, 'insert ��������''���������',* from ��������
where ��������.����������� = '��������';
select @@SPID, 'update ������������' '���������',������������.��������_������������, ������������.ID_�������
from ������������ where ������������.��������_������������ = '��������';
commit;
---------t2----------------
begin transaction 
select @@SPID
insert ������������ values ('������� ��������', 6, 7, 1, 2)
update �������� set ��������.����������� = '������� ��������' where ��������.����������� = '�������'

rollback;

--task 5
--A--
set transaction isolation level READ COMMITTED 
	begin transaction
select count(*) from �������� where ��������.����������� = '����������';
------t1-----
-------t2----------
select 'update PROGRESS ''result', count(*)[���-��]
from �������� where ��������.����������� = '����������';
commit;

----B---
begin transaction 
-----------t1--------
update �������� set ��������.����������� = '���������'
where ���� = 1
commit;
-----------t2------------

--task6---
set transaction isolation level  REPEATABLE READ 
	begin transaction 
	select ��������.�����_������������� from �������� where ��������.����������� = '����������';
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
select case
when ��������.���� = 2  then 'insert ��������' else ''
end 'result',��������.����������� from �������� where ��������.����������� = '����������';
commit;

--B--
begin transaction 
---------t1--------
insert �������� values(15154, '���', '����', '����������',1);
commit;
-------t2-------

--task7
set transaction isolation level SERIALIZABLE 
	begin transaction 
delete �������� where ��������.����������� = '������'; 
insert �������� values(12356, '�����', '������', '������',1);
update �������� set ����������� ='������' where ���= '������';
select ��������.�����_������������� from �������� where �����������= '������';
------------t1--------------
select ��������.�����_������������� from �������� where �����������= '������';
----------t2-------------
commit;

--B--
begin transaction 
delete �������� where ��������.����������� = '������'; 
insert �������� values(12356, '�����', '������', '������',1);
update �������� set ����������� ='������' where ���= '������';
select ��������.�����_������������� from �������� where �����������= '������';
------------t1--------------
commit;
select ��������.�����_������������� from �������� where �����������= '������';
----------t2-------------

--task8
begin tran
insert ������������ values ('��������', 15, 14, 2,2)
begin tran
update �������� set  ��������.�����������= '��������'where �����_������������� = 8888 and �����_������������� = 7777 ;
commit;
if @@TRANCOUNT > 0 rollback;
select 
(select count(*) from �������� where �����������= '��������' )'��������',
(select count(*) from ����������� where �����������.�����������= '��������' )'�����������';
