create table Преподаватели(
ID_лектора int primary key,
Кафедра nvarchar(30) not null,
Телефон nchar(10)
)on FG1;
create table Факультативы(
Название_факультатива nvarchar(50) primary key,
ID_лектора int foreign key references Преподаватели(ID_лектора),
Oбъем_лекций int,
Oбъем_лабораторных int,
Курс int
)on FG1;
create table Студенты(
Номер_студенческого nchar(5) primary key,
Фамилия nvarchar(30) not null,
Имя nvarchar(30),
Отчество nvarchar(30),
Факультатив nvarchar(50) foreign key references Факультативы(Название_факультатива)
)on FG1;
create table Успеваемость(
ID int primary key,
Номер_студенческого nchar(5) foreign key references Студенты(Номер_студенческого),
Число_пропусков int,
Средняя_оценка float
)on FG1;