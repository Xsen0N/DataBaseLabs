create table �������������(
ID_������� int primary key,
������� nvarchar(30) not null,
������� nchar(10)
)on FG1;
create table ������������(
��������_������������ nvarchar(50) primary key,
ID_������� int foreign key references �������������(ID_�������),
O����_������ int,
O����_������������ int,
���� int
)on FG1;
create table ��������(
�����_������������� nchar(5) primary key,
������� nvarchar(30) not null,
��� nvarchar(30),
�������� nvarchar(30),
����������� nvarchar(50) foreign key references ������������(��������_������������)
)on FG1;
create table ������������(
ID int primary key,
�����_������������� nchar(5) foreign key references ��������(�����_�������������),
�����_��������� int,
�������_������ float
)on FG1;