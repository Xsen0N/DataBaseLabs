--select TEACHER[���], TEACHER_NAME [���], GENDER[���], PULPIT[�������]
--from TEACHER;
use UNIVER
go
create view [�������������]
as select TEACHER[���], TEACHER_NAME [���], GENDER[���], PULPIT[�������]
from TEACHER;
go
select * from [�������������]
go
--2
create view [����������_������]
as select FACULTY_NAME[���������], COUNT(*)[���������� ������ ]
from PULPIT inner join FACULTY on FACULTY.FACULTY = PULPIT.FACULTY
group by FACULTY_NAME
go
--3
create view [���������]
as select AUDITORIUM[���], AUDITORIUM_TYPE[������������ ���������]
from AUDITORIUM
where AUDITORIUM_TYPE like '��%'
go

--4
create view [����������_���������]
as select AUDITORIUM, AUDITORIUM_TYPE
from AUDITORIUM
where AUDITORIUM_TYPE like '��%' with check option;
go
--5
create view [����������]
as select top 10 SUBJECT.SUBJECT[���], SUBJECT.SUBJECT_NAME[������������ ���������� ], SUBJECT.PULPIT[��� �������]
from SUBJECT
order by SUBJECT_NAME
go
--6
alter view [����������_������] with schemabinding
as select FACULTY_NAME[���������], COUNT(*)[���������� ������ ]
from dbo.PULPIT inner join  dbo.FACULTY on FACULTY.FACULTY = PULPIT.FACULTY
group by FACULTY_NAME;
go
select * from [����������_������]

--7
--7,1
use Zhuk_Base
go
create view [�������������]
as select �������������.ID_������� [���] , �������������.�������[�������� �������], �������������.�������[������] 
from �������������;
go
--7,2
create view [���-�� ���������]
as select ������������.��������_������������[�����������], count(*)[���-�� ���������]
from �������� inner join ������������ on ��������.����������� = ������������.��������_������������
group by ��������_������������;
go
--7,3
create view [������������ 2 �����]
as select ������������.��������_������������ [�����������], ������������.O����_������[���-�� ������]
from ������������
where ������������.���� = 2
go
--7,4
create view [�����������]
as select ������������.��������_������������ [�����������], ������������.O����_������[���-�� ������]
from ������������
where ������������.���� = 2 with check option;
go
--5
insert [�����������] values ('������', 3)
create view [������ ��������]
as select top 5 ������������.�����_������������� [���],������������.�������_������ [������]
from ������������
order by �������_������ desc;
go
----6
alter view [���-�� ���������] with schemabinding
as select ������������.��������_������������[�����������], count(*)[���-�� ���������]
from dbo.�������� inner join dbo.������������ on ��������.����������� = ������������.��������_������������
group by ��������_������������;
go
select * from [���-�� ���������] 
drop table ������������


insert [���-�� ���������] values (1, 1111, 2,3)