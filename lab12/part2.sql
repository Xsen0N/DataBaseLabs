--lab12.2

--task4
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

--task5

----B---
begin transaction 
-----------t1--------
update PROGRESS set Note = Note+1
where Note < 4
commit;
-----------t2------------


--task6
--B--
begin transaction 
---------t1--------
--insert PROGRESS values('���', 1004, '01.12.2013', 7);
delete from PROGRESS where PROGRESS.IDSTUDENT=1009

---------
commit;
-------t2-------


--task7
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


--9,4
--B
begin transaction 
select @@SPID
insert ������������ values ('������� ��������', 6, 7, 1, 2)
update �������� set ��������.����������� = '������� ��������' where ��������.����������� = '�������'
------------t1--------------
----------t2-------------
rollback;

--task 9.5
----B---
begin transaction 
-----------t1--------
update �������� set ��������.����������� = '���������'
where ���� = 1
commit;
-----------t2------------

--9.6

--B--
begin transaction 
---------t1--------
insert �������� values(15154, '���', '����', '����������',1);
commit;
-------t2-------

--9.7
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