select * from Преподаватели;
select ID,Номер_студенческого from Успеваемость;
select COUNT(*) from Успеваемость;
select Oбъем_лабораторных from Факультативы;
update Факультативы set Oбъем_лабораторных = Oбъем_лабораторных + 2;
select Oбъем_лабораторных from Факультативы;
delete from Студенты where Имя = 'Петр';