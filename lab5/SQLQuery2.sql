--lab5
--task1
use UNIVER
select PULPIT.PULPIT_NAME, PROFESSION.PROFESSION_NAME
from PULPIT, PROFESSION
where PULPIT.FACULTY = PROFESSION.FACULTY
and PROFESSION.PROFESSION_NAME in (select PROFESSION_NAME from PROFESSION where PROFESSION_NAME like '%���������[�, �, �]%')
--task2
select PULPIT.PULPIT_NAME, PROFESSION.PROFESSION_NAME
from PULPIT inner join PROFESSION on PULPIT.FACULTY = PROFESSION.FACULTY
Where PROFESSION.PROFESSION_NAME in  (select PROFESSION_NAME from PROFESSION where PROFESSION_NAME like '%���������[�, �, �]%')
--task3
select FACULTY.FACULTY, PULPIT.PULPIT_NAME, PROFESSION.PROFESSION_NAME
from PULPIT inner join FACULTY on PULPIT.FACULTY = FACULTY.FACULTY
inner join PROFESSION on PULPIT.FACULTY = PROFESSION.FACULTY
where PROFESSION.PROFESSION_NAME like '%���������[�, �, �]%'
--task4
SELECT  AUDITORIUM_NAME '���������', AUDITORIUM_TYPE '���', AUDITORIUM_CAPACITY '�����������'
from AUDITORIUM a
where AUDITORIUM_CAPACITY = (SELECT TOP(1) AUDITORIUM_CAPACITY FROM AUDITORIUM aa
where a.AUDITORIUM_TYPE = aa.AUDITORIUM_TYPE
order by  AUDITORIUM_CAPACITY DESC);
--task5
select FACULTY.FACULTY from FACULTY
where  exists(select * from PULPIT
where FACULTY.FACULTY = PULPIT.FACULTY)
--task6--
select top 1
(select AVG(NOTE) from PROGRESS where SUBJECT like '��') [��],
(select AVG(NOTE) from PROGRESS where SUBJECT like '����')[����],
(select AVG(NOTE) from PROGRESS where SUBJECT like '����')[����]
from PROGRESS
---task7
select PROGRESS.SUBJECT, PROGRESS.NOTE from PROGRESS
where PROGRESS.NOTE<= all(select NOTE from PROGRESS 
where SUBJECT like '%�%' )

select PROGRESS.SUBJECT, PROGRESS.NOTE from PROGRESS
where PROGRESS.NOTE>= any(select NOTE from PROGRESS 
where SUBJECT like '%�%' )
--task9 
--9.1
use Zhuk_Base
select ��������.���, ������������.����
from ��������, ������������
where ��������.����������� =  ������������.��������_������������
and ������������.ID_������� in (select ID_������� from ������������� where �������������.������� like '%�%')
--9.2
select ��������.���, ������������.����
from �������� inner join ������������
on ��������.����������� =  ������������.��������_������������
where ������������.ID_������� in (select ID_������� from ������������� where �������������.������� like '%�%')
--9.3
select ��������.���, ������������.����, �������������.ID_�������
from �������� inner join ������������
on ��������.����������� =  ������������.��������_������������
inner join ������������� on ������������.ID_������� = �������������.ID_�������
where �������������.������� like '%�%'
--9.4
select ����, ����������� from �������� a
where ����������� = (select top(1) ����������� from �������� aa
where aa.����������� = a.�����������
order by ���� desc)
--9.5
select ��������_������������ FROM ������������
where not exists (select * from �������� 
where ������������.��������_������������ = ��������.�����������)
--9.6
select top 1
(select avg(������������.�������_������) from ������������ 
where ID <5 )[������ 1 ������],
(select avg(������������.�������_������) from ������������ 
where ID > 4 )[������ 2 ������]
from ������������
--9,7
select �����_������������� from ��������
where ���� >=all (select ���� from �������� where ��� like '%�%')
--9,8
select �����_������������� from ��������
where ���� >any (select ���� from �������� where ��� like '%�%')


