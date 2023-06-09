use master;
create database Zhuk_Base;

use Zhuk_Base
create table Успеваемость(
ID int primary key,
Номер_студенческого nchar(5) foreign key references Студенты(Номер_студенческого),
Число_пропусков int,
Средняя_оценка float
);
create table Студенты(
Номер_студенческого nchar(5) primary key,
Фамилия nvarchar(30) not null,
Имя nvarchar(30),
Отчество nvarchar(30),
Факультатив nvarchar(50) foreign key references Факультативы(Название_факультатива)
);
create table Факультативы(
Название_факультатива nvarchar(50) primary key,
ID_лектора int foreign key references Преподаватели(ID_лектора),
Oбъем_лекций int,
Oбъем_лабораторных int,
Курс int
);
create table Преподаватели(
ID_лектора int primary key,
Кафедра nvarchar(30) not null,
Телефон nchar(10)
);
alter table Студенты add Курс int default 1 ;
alter table Студенты Drop Column Отчество ;
alter table Факультативы add check(Курс > 0);
insert into Преподаватели(ID_лектора,Кафедра,Телефон)
	Values(15, 'Рисования', 1111111),(27, 'Математики', 2222222),(6, 'Иностранных_языков', 3333333) ;

insert into Успеваемость(ID,Номер_студенческого,Число_пропусков,Средняя_оценка)
	Values(1, 11111, 2, 9),
	(2, 22222, 0, 8),
	(3, 33333, 13, 4);
insert into Факультативы(Название_факультатива,ID_лектора,Oбъем_лекций,Oбъем_лабораторных,Курс)
	Values('Живопись', 15, 15, 0,3),
	('Математика', 27, 8, 16,1),
	('Английский', 6, 20, 12,2);

insert into Студенты(Номер_студенческого,Фамилия,Имя, Факультатив)
	Values(11111, 'Иванов', 'Иван', 'Математика'),
	(22222, 'Петров', 'Петр', 'Английский'),
	(33333, 'Алексеев', 'Алексей', 'Живопись');
select * from Преподаватели;
select ID,Номер_студенческого from Успеваемость;
select COUNT(*) from Успеваемость;
select Oбъем_лабораторных from Факультативы;
update Факультативы set Oбъем_лабораторных = Oбъем_лабораторных + 2;
select Oбъем_лабораторных from Факультативы;
