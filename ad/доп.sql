create or alter trigger New_tr on Студенты after insert
as declare @sn nchar(5), @f nvarchar(30), @i nvarchar(30), @fa nvarchar(50), @k int;
print 'Операция вставки'
set @sn = (select [Номер_студенческого] from inserted)
set @f = (select [Фамилия] from inserted)
set @i = (select [Имя] from inserted)
set @fa = (select [Факультатив] from inserted)
set @k = (select [Курс] from inserted)
print @sn + ' ' +  @f+ ' ' + @i + ' ' + @fa + ' ' + cast(@k as varchar(3))
return;

insert Студенты values('1457', 'Petr', 'Petrov','Логика',2)
go
create or alter trigger INs_tr on Успеваемость instead of delete
as raiserror('Error', 10, 1)
return;

delete from Успеваемость where Успеваемость.Число_пропусков = 0

