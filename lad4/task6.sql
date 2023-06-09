--lab4
USE UNIVER
--1
SELECT AUDITORIUM.AUDITORIUM, AUDITORIUM.AUDITORIUM_TYPE
FROM AUDITORIUM
INNER JOIN AUDITORIUM_TYPE ON AUDITORIUM_TYPE.AUDITORIUM_TYPE = AUDITORIUM.AUDITORIUM_TYPE;
--2
SELECT AUDITORIUM.AUDITORIUM, AUDITORIUM.AUDITORIUM_TYPE
FROM AUDITORIUM
INNER JOIN AUDITORIUM_TYPE ON AUDITORIUM_TYPE.AUDITORIUM_TYPE = AUDITORIUM.AUDITORIUM_TYPE and 
             AUDITORIUM_TYPE.AUDITORIUM_TYPENAME Like '%������������%';
			 --3
--Select PROGRESS.IDSTUDENT, STUDENT.NAME, FACULTY.FACULTY_NAME, PULPIT.PULPIT, PROFESSION.PROFESSION, PROGRESS.SUBJECT,
--case PROGRESS.NOTE
--when 6 then '�����'
--when 7 then '����'
--when 8 then '������'
--else '������'
--end [������]
--from PROGRESS inner join STUDENT on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
--inner join SUBJECT on PROGRESS.SUBJECT = SUBJECT.SUBJECT
--inner join PULPIT on SUBJECT.PULPIT = PULPIT.PULPIT
--inner join FACULTY on PULPIT.FACULTY = FACULTY.FACULTY
--inner join PROFESSION on FACULTY.FACULTY = PROFESSION.FACULTY
--order by  PROGRESS.NOTE DESC;

use UNIVER
Select PROGRESS.IDSTUDENT, STUDENT.NAME, FACULTY.FACULTY_NAME, PULPIT.PULPIT, PROFESSION.PROFESSION, PROGRESS.SUBJECT,PROGRESS.NOTE,
Case 
when (PROGRESS.NOTE between 6 and 8) then ' �� ����� �� ������'
else '������'
end [������]
from PROGRESS inner join STUDENT on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
inner join SUBJECT on PROGRESS.SUBJECT = SUBJECT.SUBJECT
inner join PULPIT on SUBJECT.PULPIT = PULPIT.PULPIT
inner join FACULTY on PULPIT.FACULTY = FACULTY.FACULTY
inner join PROFESSION on FACULTY.FACULTY = PROFESSION.FACULTY
order by  PROGRESS.NOTE DESC;
--4
Select isnull (TEACHER.TEACHER_NAME, '**' )[�������������], PULPIT.PULPIT_NAME
from PULPIT left outer join TEACHER on TEACHER.PULPIT = PULPIT.PULPIT
-- 5
Select * from PROGRESS FULL OUTER JOIN  STUDENT
On PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where STUDENT.IDSTUDENT is Null
order by STUDENT.IDSTUDENT

select * from STUDENT full outer join PROGRESS
on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
where PROGRESS.IDSTUDENT is null
order by PROGRESS.IDSTUDENT

select * from STUDENT full outer join PROGRESS 
on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
where PROGRESS.IDSTUDENT is not null
--6
select AUDITORIUM.AUDITORIUM_NAME, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME
from AUDITORIUM cross join AUDITORIUM_TYPE
--7
use Zhuk_Base
--task1
select ������������.��������_������������, �������������.�������
from ������������ inner join ������������� 
on ������������.ID_������� = �������������.ID_�������
-- task2
select ��������.���, ������������.�����_���������
from �������� inner join ������������ 
on ��������.�����_������������� = ������������.�����_�������������
and ��������.�����_������������� like '%2%'
--task3
select ��������.�����_�������������, ������������.��������_������������,�������������.�������, ������������.�������_������,
Case 
when (������������.�������_������ between 4 and 7) then 'bad'
else 'good'
end [Result]
from �������� inner join ������������ on ��������.����������� = ������������.��������_������������
inner join ������������� on �������������.ID_������� = ������������.ID_�������
inner join ������������ on ��������.�����_������������� = ������������.�����_�������������
--task4
select isnull(�������������.�������, '***')[Phone], ������������.��������_������������, �������������.ID_�������
from ������������ left outer join �������������
on ������������.ID_������� = �������������.ID_�������
--task5
select * from �������������
full outer join ������������
on �������������.ID_������� = ������������.ID_�������
where ������������.ID_������� is null

select * from ������������
full outer join �������������
on �������������.ID_������� = ������������.ID_�������
where �������������.ID_������� is null

select * from ������������
full outer join �������������
on �������������.ID_������� = ������������.ID_�������
where �������������.ID_������� is not null
-- task6
select ������������.��������_������������, �������������.�������
from ������������ cross join ������������� 
where ������������.ID_������� = �������������.ID_�������
