use master;
create database Zhuk_Base;

use Zhuk_Base
create table ������������(
ID int primary key,
�����_������������� nchar(5) foreign key references ��������(�����_�������������),
�����_��������� int,
�������_������ float
);
create table ��������(
�����_������������� nchar(5) primary key,
������� nvarchar(30) not null,
��� nvarchar(30),
�������� nvarchar(30),
����������� nvarchar(50) foreign key references ������������(��������_������������)
);
create table ������������(
��������_������������ nvarchar(50) primary key,
ID_������� int foreign key references �������������(ID_�������),
O����_������ int,
O����_������������ int,
���� int
);
create table �������������(
ID_������� int primary key,
������� nvarchar(30) not null,
������� nchar(10)
);
alter table �������� add ���� int default 1 ;
alter table �������� Drop Column �������� ;
alter table ������������ add check(���� > 0);
insert into �������������(ID_�������,�������,�������)
	Values(15, '���������', 1111111),(27, '����������', 2222222),(6, '�����������_������', 3333333) ;

insert into ������������(ID,�����_�������������,�����_���������,�������_������)
	Values(1, 11111, 2, 9),
	(2, 22222, 0, 8),
	(3, 33333, 13, 4);
insert into ������������(��������_������������,ID_�������,O����_������,O����_������������,����)
	Values('��������', 15, 15, 0,3),
	('����������', 27, 8, 16,1),
	('����������', 6, 20, 12,2);

insert into ��������(�����_�������������,�������,���, �����������)
	Values(11111, '������', '����', '����������'),
	(22222, '������', '����', '����������'),
	(33333, '��������', '�������', '��������');
select * from �������������;
select ID,�����_������������� from ������������;
select COUNT(*) from ������������;
select O����_������������ from ������������;
update ������������ set O����_������������ = O����_������������ + 2;
select O����_������������ from ������������;
