--lab6
use UNIVER
--task1-2
select AUDITORIUM_TYPE.AUDITORIUM_TYPE,
max(AUDITORIUM.AUDITORIUM_CAPACITY)[������������ �����������],
min(AUDITORIUM.AUDITORIUM_CAPACITY)[����������� �����������],
avg(AUDITORIUM.AUDITORIUM_CAPACITY)[������� �����������],
Count(*)[����������],
sum(AUDITORIUM.AUDITORIUM_CAPACITY)[�������� �����������]
from AUDITORIUM_TYPE inner join AUDITORIUM 
on AUDITORIUM_TYPE.AUDITORIUM_TYPE = AUDITORIUM.AUDITORIUM_TYPE
group by AUDITORIUM_TYPE.AUDITORIUM_TYPE;
--task3
select *
from (select Case when PROGRESS.NOTE between 0 and 3 then '������ ���� 3'
when PROGRESS.NOTE between 4 and 7 then '������ �� 4 �� 7'
else '������ ������ 7'
end[����� ������],COUNT(*)[����������]
from PROGRESS group by case 
when PROGRESS.NOTE between 0 and 3 then '������ ���� 3'
when PROGRESS.NOTE between 4 and 7 then '������ �� 4 �� 7'
else '������ ������ 7'
end) as T
order by case[����� ������]
when '������ ���� 3' then 3
when '������ �� 4 �� 7' then 2
when '������ ������ 7' then 1
else 0
end
--task4
select FACULTY.FACULTY_NAME, GROUPS.PROFESSION, ROUND(avg(cast(PROGRESS.NOTE as float(4))),2)[������� ������]
from FACULTY inner join GROUPS on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT on STUDENT.IDGROUP =GROUPS.IDGROUP
inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
group by FACULTY.FACULTY_NAME, GROUPS.PROFESSION
order by ROUND(avg(cast(PROGRESS.NOTE as float(4))),2) desc
--task5 
select FACULTY.FACULTY_NAME, GROUPS.PROFESSION, ROUND(avg(cast(PROGRESS.NOTE as float(4))),2)[������� ������]
from FACULTY inner join GROUPS on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT on STUDENT.IDGROUP =GROUPS.IDGROUP
inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
where PROGRESS.SUBJECT in ('��', '����')
group by FACULTY.FACULTY_NAME, GROUPS.PROFESSION
order by ROUND(avg(cast(PROGRESS.NOTE as float(4))),2) desc
--task6
select PROGRESS.SUBJECT, GROUPS.PROFESSION, avg(PROGRESS.NOTE)[������� ������]
from FACULTY inner join GROUPS on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT on STUDENT.IDGROUP =GROUPS.IDGROUP
inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
where FACULTY.FACULTY = '���'
group by PROGRESS.SUBJECT, GROUPS.PROFESSION
--task7
select p2.SUBJECT, p2.NOTE, (select count(*) from PROGRESS p1 where p1.SUBJECT = p2.SUBJECT
and p1.NOTE = p2.NOTE)[���-��]
from PROGRESS p2
group by p2.SUBJECT, p2.NOTE
having NOTE in (8, 9)
--task9
--9.1/2
use Zhuk_Base
select  ������������.ID_�������,
min(������������.O����_������)[����������� ����� ������],
max(������������.O����_������)[������������ ����� ������],
avg(������������.O����_������)[������� ����� ������],
COUNT(*)[���-�� ��������]
from ������������ 
group by ������������.ID_�������
--9.3
select * 
from (select case
when ������������.�������_������ between 0 and 5 then ' ������ 5'
when ������������.�������_������ between 6 and 8 then ' �� 6 �� 8'
else ' >9' 
end[������ ������], count(*)[���-��]
from ������������ group by case
when ������������.�������_������ between 0 and 5 then ' ������ 5'
when ������������.�������_������ between 6 and 8 then ' �� 6 �� 8'
else ' >9' 
end) as T
order by case [������ ������]
when ' ������ 5' then 3
when  ' �� 6 �� 8' then 2
when  ' >9' then 1
else 0 
end
--9,4
select  ������������.��������_������������, ROUND(avg(cast(������������.�������_������ as float(4))),2)[������� ������]
from �������� inner join ������������ on ��������.����������� = ������������.��������_������������
inner join ������������ on ��������.�����_������������� = ������������.�����_�������������
group by ������������.��������_������������
--9,5
select  ������������.��������_������������, ROUND(avg(cast(������������.�������_������ as float(4))),2)[������� ������]
from �������� inner join ������������ on ��������.����������� = ������������.��������_������������
inner join ������������ on ��������.�����_������������� = ������������.�����_�������������
where ��������.���� <3
group by ������������.��������_������������
--9,6
select  ������������.��������_������������, avg(������������.�������_������)[������� ������]
from �������� inner join ������������ on ��������.����������� = ������������.��������_������������
inner join ������������ on ��������.�����_������������� = ������������.�����_�������������
where ������������.��������_������������ in ('��������', '����������')
group by ������������.��������_������������
--9..7
select p1.�����_�������������, p1.�������_������,
(select count(*) from ������������ p2 
where  p1.�����_������������� = p2.�����_�������������
and p1.�������_������ = p2.�������_������)[���-��]
from ������������ p1 
group by p1.�����_�������������,  p1.�������_������
having  �������_������ > 6