--lab13--
use UNIVER

--task1

go
Create or alter procedure PSUBJECT
as
begin 
declare @k int = (select count(*) from SUBJECT);
select * from SUBJECT;
return @k;
end;

go;
declare @k int = 0;
Exec @k = PSUBJECT;
print '���-�� ���������= '+ cast(@k as varchar(3));
go;

--task 2

alter procedure PSUBJECT @p varchar(20), @c int output
as begin 
declare @k int = (select count(*) from SUBJECT);
print 'parametrs: @p= '+ @p + ', @c= '+ cast(@c as varchar(3));
select * from SUBJECT where SUBJECT.PULPIT = @p;
set @c = @@ROWCOUNT;
return @k;
end;

go;
declare @k int = 0, @r int = 0, @p varchar(20);
exec @k = PSUBJECT @p='����', @c = @r output;
print '���-�� ���������= '+ cast(@k as varchar(3));
print '���-�� ��������� c  '+ @p + '= '+ cast(@r as varchar(3));

--task3--------------------------------------------
create table #SUBJECT(
SUBJECT char(10) primary key,
SUBJECT_NAME varchar(100),
PULPIT char(20)
)
go;
alter procedure PSUBJECT @p varchar(20)
as begin 
declare @k int = (select count(*) from SUBJECT);
select * from SUBJECT where SUBJECT.PULPIT = @p;
return @k;
end;

insert #SUBJECT exec PSUBJECT @p ='����';
select * from #SUBJECT

--task4--
go;
create procedure PAUDITORIUM_INSERT @a CHAR(20), @n CHAR(10), @c int = 0, @t varchar(50)
as declare @rc int = 1
begin try
insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY,AUDITORIUM_NAME)
values (@a, @n, @c, @t)
return @rc;
end try
begin catch
print '����� ������ :' + cast(error_number() as varchar(6));
print '��������� :' + error_message();
print '������� :' + cast(error_severity() as varchar(6));
print '����� :' + cast(error_state() as varchar(8));
print '����� ������ :' + cast(error_line() as varchar(8));
if ERROR_PROCEDURE() is not null
print '��� ��������� :' + error_procedure();
return -1;
end catch

go

declare @rc int;  
exec @rc = PAUDITORIUM_INSERT @a = '318-1', @n = '��', @c = 30, @t = '318-1'
print '��� ������ : ' + cast(@rc as varchar(3)); 
go
declare @rc int;  
exec @rc = PAUDITORIUM_INSERT @a = '408-2', @n = '��', @c = 30, @t = '408-2'
print '��� ������ : ' + cast(@rc as varchar(3)); 

--task5

go
create procedure SUBJECT_REPORT @p CHAR(10)
as declare @rc int = 0;
begin try
declare @tv char(20), @t char(300) = ' ';  
declare CSUBJECT cursor for 
select SUBJECT from SUBJECT where SUBJECT.PULPIT = @p
if not exists (select SUBJECT from SUBJECT where SUBJECT.PULPIT = @p)
raiserror('error', 11, 1);
else
open CSUBJECT;
fetch CSUBJECT into @tv;
print 'Subjects '
    while @@fetch_status = 0                                     
    begin 
	     set @t = rtrim(@tv) + ', ' + @t;  
         set @rc = @rc + 1;       
         fetch  CSUBJECT into @tv; 
    end;   
	print @t;
	close CSUBJECT
	return @rc;
end try
begin catch
print '������ � ����������' 
        if error_procedure() is not null   
  print '��� ��������� : ' + error_procedure();
        return @rc;

end catch
go;
declare @rc int;  
exec @rc = SUBJECT_REPORT @p  = '����';  
print '���������� ��������� = ' + cast(@rc as varchar(3));

--task6
go
create procedure PAUDITORIUM_INSERTX @a CHAR(20), @t CHAR(10), @c int = 0, @n varchar(50),@tn VARCHAR(50)
as declare @rc int = 1;
begin try
set transaction isolation level SERIALIZABLE;          
    begin tran
	insert into AUDITORIUM_TYPE ( AUDITORIUM_TYPE,AUDITORIUM_TYPENAME)
values ( @t,@tn )
exec @rc = PAUDITORIUM_INSERT @a, @n, @c, @t ;
commit tran;
return @rc;
end try
begin catch 
    print '����� ������  : ' + cast(error_number() as varchar(6));
    print '���������     : ' + error_message();
    print '�������       : ' + cast(error_severity()  as varchar(6));
    print '�����         : ' + cast(error_state()   as varchar(8));
    print '����� ������  : ' + cast(error_line()  as varchar(8));
    if error_procedure() is not  null   
	print '��� ��������� : ' + error_procedure();
     if @@trancount > 0 rollback tran ; 
     return -1;	  
end catch;
go
declare @rc int;  
exec @rc = PAUDITORIUM_INSERTX @a = '317-1', @n = '��', @c = 30, @t = '317-1',@tn ='����������' ;
print '��� ������=' + cast(@rc as varchar(3));  
go
declare @rc int;  
exec @rc = PAUDITORIUM_INSERTX @a = '408-2', @n = '��', @c = 30, @t = '408-2',@tn ='����������'
print '��� ������ : ' + cast(@rc as varchar(3)); 


--task7
use Zhuk_Base
--7.1
go;
create procedure PFACULT
as
begin 
declare @k int = (select count(*) from ������������);
select * from ������������;
return @k;
end;

go;
declare @k int = 0;
Exec @k = PFACULT;
print '���-�� ������������� = '+ cast(@k as varchar(3));
go;

--7.2

alter procedure PFACULT @p int, @c int output
as begin 
declare @k int = (select count(*) from ������������);
print 'parametrs: @p= '+ cast(@p as varchar(3)) + ', @c= '+ cast(@c as varchar(3));
select * from ������������ where ������������.����= @p;
set @c = @@ROWCOUNT;
return @k;
end;

go;
declare @k int = 0, @r int = 0, @p int;
exec @k = PFACULT @p=3, @c = @r output;
print '���-�� �������������= '+ cast(@k as varchar(3));
print '���-�� ������������� y  '+ cast(@p as varchar(3))+ '����� = '+ cast(@r as varchar(3));

--7,3

create table #FACULT(
��������_������������ nvarchar(50) primary key,
ID_������� int,
O����_������ int,
O����_������������ int,
���� int,
)
go;
alter procedure PFACULT @p varchar(20)
as begin 
declare @k int = (select count(*) from ������������);
select * from ������������ where ������������.���� = @p;
return @k;
end;

insert #FACULT exec PFACULT @p =2;
select * from #FACULT

--7,4
go;
create procedure PPREPOD @i int, @c nvarchar(30), @pn nchar(10)
as declare @rc int = 1
begin try
insert into �������������(ID_�������, �������,�������)
values (@i, @c, @pn)
return @rc;
end try
begin catch
print '����� ������ :' + cast(error_number() as varchar(6));
print '��������� :' + error_message();
print '������� :' + cast(error_severity() as varchar(6));
print '����� :' + cast(error_state() as varchar(8));
print '����� ������ :' + cast(error_line() as varchar(8));
if ERROR_PROCEDURE() is not null
print '��� ��������� :' + error_procedure();
return -1;
end catch

go

declare @rc int;  
exec @rc = PPREPOD @i = 1 , @c = '�����', @pn = '1234561'
print '��� ������ : ' + cast(@rc as varchar(3)); 
go

declare @rc int;  
exec @rc = PPREPOD @i = 6 , @c = '�����', @pn = '1234561'
print '��� ������ : ' + cast(@rc as varchar(3)); 
go

--7.5

go
create procedure LECTORS_REPORT @p CHAR(10)
as declare @rc int = 0;
begin try
declare @tv char(20), @t char(300) = ' ';  
declare CLECTORS cursor for 
select ������������.��������_������������ from ������������ where ������������.����= @p
if not exists (select ������������.��������_������������ from ������������ where ������������.����= @p)
raiserror('error', 11, 1);
else
open CLECTORS;
fetch CLECTORS into @tv;
print '������������ '
    while @@fetch_status = 0                                     
    begin 
	     set @t = rtrim(@tv) + ', ' + @t;  
         set @rc = @rc + 1;       
         fetch  CLECTORS into @tv; 
    end;   
	print @t;
	close CLECTORS
	return @rc;
end try
begin catch
print '������ � ����������' 
        if error_procedure() is not null   
  print '��� ��������� : ' + error_procedure();
        return @rc;

end catch
go;
declare @rc int;  
exec @rc = LECTORS_REPORT @p  = 2;  
print '���������� ��������� = ' + cast(@rc as varchar(3));

--7,6
go
create procedure PFACULT_INSERTX @i int, @c nvarchar(30), @pn nchar(10), @lec int, @lab int, @gr int
as declare @rc int = 1;
begin try
set transaction isolation level SERIALIZABLE;          
    begin tran
	exec @rc = PPREPOD @i, @c, @pn ;
	insert into ������������(��������_������������, ID_�������,O����_������, O����_������������, ����)
values ( @c, @i, @lec,@lab,@gr )

commit tran;
return @rc;
end try
begin catch 
    print '����� ������  : ' + cast(error_number() as varchar(6));
    print '���������     : ' + error_message();
    print '�������       : ' + cast(error_severity()  as varchar(6));
    print '�����         : ' + cast(error_state()   as varchar(8));
    print '����� ������  : ' + cast(error_line()  as varchar(8));
    if error_procedure() is not  null   
	print '��� ��������� : ' + error_procedure();
     if @@trancount > 0 rollback tran ; 
     return -1;	  
end catch;
go

declare @rc int;  
exec @rc = PFACULT_INSERTX @i = 99, @c = '������������ �����', @pn = '1452367', @lec = 15, @lab = 0, @gr = 2
print '��� ������=' + cast(@rc as varchar(3));  
go
