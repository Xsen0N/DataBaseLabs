create or alter trigger New_tr on �������� after insert
as declare @sn nchar(5), @f nvarchar(30), @i nvarchar(30), @fa nvarchar(50), @k int;
print '�������� �������'
set @sn = (select [�����_�������������] from inserted)
set @f = (select [�������] from inserted)
set @i = (select [���] from inserted)
set @fa = (select [�����������] from inserted)
set @k = (select [����] from inserted)
print @sn + ' ' +  @f+ ' ' + @i + ' ' + @fa + ' ' + cast(@k as varchar(3))
return;

insert �������� values('1457', 'Petr', 'Petrov','������',2)
go
create or alter trigger INs_tr on ������������ instead of delete
as raiserror('Error', 10, 1)
return;

delete from ������������ where ������������.�����_��������� = 0

