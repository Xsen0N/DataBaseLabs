--lab7
use UNIVER
select PROGRESS.SUBJECT, GROUPS.PROFESSION, avg(PROGRESS.NOTE)[������� ������]
from FACULTY inner join GROUPS on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT on STUDENT.IDGROUP =GROUPS.IDGROUP
inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
where FACULTY.FACULTY = '���'
group by PROGRESS.SUBJECT, GROUPS.PROFESSION
--1
select PROGRESS.SUBJECT, GROUPS.PROFESSION, avg(PROGRESS.NOTE)[������� ������]
from FACULTY inner join GROUPS on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT on STUDENT.IDGROUP =GROUPS.IDGROUP
inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
where FACULTY.FACULTY = '���'
group by rollup( PROGRESS.SUBJECT, GROUPS.PROFESSION)
--2

select PROGRESS.SUBJECT, GROUPS.PROFESSION, avg(PROGRESS.NOTE)[������� ������]
from FACULTY inner join GROUPS on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT on STUDENT.IDGROUP =GROUPS.IDGROUP
inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
where FACULTY.FACULTY = '���'
group by cube( PROGRESS.SUBJECT, GROUPS.PROFESSION)
--3
select PROGRESS.SUBJECT, GROUPS.PROFESSION, avg(PROGRESS.NOTE)[������� ������]
from FACULTY inner join GROUPS on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT on STUDENT.IDGROUP =GROUPS.IDGROUP
inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
where FACULTY.FACULTY = '���'
group by PROGRESS.SUBJECT, GROUPS.PROFESSION
union
select PROGRESS.SUBJECT, GROUPS.PROFESSION, avg(PROGRESS.NOTE)[������� ������]
from FACULTY inner join GROUPS on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT on STUDENT.IDGROUP =GROUPS.IDGROUP
inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
where FACULTY.FACULTY = '����'
group by PROGRESS.SUBJECT, GROUPS.PROFESSION
--
select PROGRESS.SUBJECT, GROUPS.PROFESSION, avg(PROGRESS.NOTE)[������� ������]
from FACULTY inner join GROUPS on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT on STUDENT.IDGROUP =GROUPS.IDGROUP
inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
where FACULTY.FACULTY = '���'
group by PROGRESS.SUBJECT, GROUPS.PROFESSION
union all
select PROGRESS.SUBJECT, GROUPS.PROFESSION, avg(PROGRESS.NOTE)[������� ������]
from FACULTY inner join GROUPS on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT on STUDENT.IDGROUP =GROUPS.IDGROUP
inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
where FACULTY.FACULTY = '����'
group by PROGRESS.SUBJECT, GROUPS.PROFESSION
--4
select PROGRESS.SUBJECT, GROUPS.PROFESSION, avg(PROGRESS.NOTE)[������� ������]
from FACULTY inner join GROUPS on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT on STUDENT.IDGROUP =GROUPS.IDGROUP
inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
where FACULTY.FACULTY = '���'
group by PROGRESS.SUBJECT, GROUPS.PROFESSION
INTERSECT
select PROGRESS.SUBJECT, GROUPS.PROFESSION, avg(PROGRESS.NOTE)[������� ������]
from FACULTY inner join GROUPS on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT on STUDENT.IDGROUP =GROUPS.IDGROUP
inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
where FACULTY.FACULTY = '����'
group by PROGRESS.SUBJECT, GROUPS.PROFESSION
--5
select PROGRESS.SUBJECT, GROUPS.PROFESSION, avg(PROGRESS.NOTE)[������� ������]
from FACULTY inner join GROUPS on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT on STUDENT.IDGROUP =GROUPS.IDGROUP
inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
where FACULTY.FACULTY = '���'
group by PROGRESS.SUBJECT, GROUPS.PROFESSION
EXCEPT
select PROGRESS.SUBJECT, GROUPS.PROFESSION, avg(PROGRESS.NOTE)[������� ������]
from FACULTY inner join GROUPS on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT on STUDENT.IDGROUP =GROUPS.IDGROUP
inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
where FACULTY.FACULTY = '����'
group by PROGRESS.SUBJECT, GROUPS.PROFESSION/
--task6

use Zhuk_Base
select  ������������.��������_������������, avg(������������.�������_������)[������� ������]
from �������� inner join ������������ on ��������.����������� = ������������.��������_������������
inner join ������������ on ��������.�����_������������� = ������������.�����_�������������
where ������������.��������_������������ in ('����������')
group by ������������.��������_������������
--
select  ������������.��������_������������, avg(������������.�������_������)[������� ������]
from �������� inner join ������������ on ��������.����������� = ������������.��������_������������
inner join ������������ on ��������.�����_������������� = ������������.�����_�������������
where ������������.��������_������������ in ('����������')
group by rollup (������������.��������_������������)
--
select  ������������.��������_������������, avg(������������.�������_������)[������� ������]
from �������� inner join ������������ on ��������.����������� = ������������.��������_������������
inner join ������������ on ��������.�����_������������� = ������������.�����_�������������
where ������������.��������_������������ in ('����������')
group by cube (������������.��������_������������)
--
select  ������������.��������_������������, avg(������������.�������_������)[������� ������]
from �������� inner join ������������ on ��������.����������� = ������������.��������_������������
inner join ������������ on ��������.�����_������������� = ������������.�����_�������������
where ������������.��������_������������ in ('����������')
group by ������������.��������_������������
union
select  ������������.��������_������������, avg(������������.�������_������)[������� ������]
from �������� inner join ������������ on ��������.����������� = ������������.��������_������������
inner join ������������ on ��������.�����_������������� = ������������.�����_�������������
where ������������.��������_������������ in ('����������')
group by ������������.��������_������������

select  ������������.��������_������������, avg(������������.�������_������)[������� ������]
from �������� inner join ������������ on ��������.����������� = ������������.��������_������������
inner join ������������ on ��������.�����_������������� = ������������.�����_�������������
where ������������.��������_������������ in ('����������')
group by ������������.��������_������������
union all
select  ������������.��������_������������, avg(������������.�������_������)[������� ������]
from �������� inner join ������������ on ��������.����������� = ������������.��������_������������
inner join ������������ on ��������.�����_������������� = ������������.�����_�������������
where ������������.��������_������������ in ('����������')
group by ������������.��������_������������
--4
select  ������������.��������_������������, avg(������������.�������_������)[������� ������]
from �������� inner join ������������ on ��������.����������� = ������������.��������_������������
inner join ������������ on ��������.�����_������������� = ������������.�����_�������������
where ������������.��������_������������ in ('����������')
group by ������������.��������_������������
INTERSECT
select  ������������.��������_������������, avg(������������.�������_������)[������� ������]
from �������� inner join ������������ on ��������.����������� = ������������.��������_������������
inner join ������������ on ��������.�����_������������� = ������������.�����_�������������
where ������������.��������_������������ in ('����������')
group by ������������.��������_������������
--5
select  ������������.��������_������������, avg(������������.�������_������)[������� ������]
from �������� inner join ������������ on ��������.����������� = ������������.��������_������������
inner join ������������ on ��������.�����_������������� = ������������.�����_�������������
where ������������.��������_������������ in ('����������')
group by ������������.��������_������������
EXCEPT
select  ������������.��������_������������, avg(������������.�������_������)[������� ������]
from �������� inner join ������������ on ��������.����������� = ������������.��������_������������
inner join ������������ on ��������.�����_������������� = ������������.�����_�������������
where ������������.��������_������������ in ('����������')
group by ������������.��������_������������