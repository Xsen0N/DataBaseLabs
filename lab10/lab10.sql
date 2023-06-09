--lab10

--task1-------------------------------------------
use UNIVER
exec sp_helpindex'Auditorium_type'
create table #University
(id int,
name varchar(100)
);
set nocount on;
declare @i int =0;
while @i < 1000
begin 
insert #University(id, name) 
values (floor(3000*rand()),'string');
set @i = @i+1;
end;
go;
select * from #University where id between 500 and 1500 order by id

checkpoint;

dbcc dropcleanbuffers;
create clustered index #University_Cl on #University(id asc)

--task2-----------------------------------------------------------------
create table #STRINGS
(id int,
cc int identity(1,1),
name varchar(100)
);
go
set nocount on;
declare @i int =0;
while @i < 10000
begin 
insert #STRINGS(id, name) 
values (floor(3000*rand()),'string');
set @i = @i+1;
end;
go;
select count(*)[ ол-во строк] from #STRINGS;
select * from #STRINGS;

create index #STR_NONCLU on #STRINGS(id, cc)

select * from #STRINGS where id >1500 and cc<2000
select * from #STRINGS order by id, cc

select * from #STRINGS where id = 623 and cc>3
--task3
CREATE index #STR_TKEY_X on #STRINGS(id) include (cc)

select cc from #STRINGS where id >1500


--task4
select id from #STRINGS where id between 1500 and 2100
select id from #STRINGS where id >1600 and id<2000
select id from #STRINGS where id =1774

create index #STRINGS_WH on #STRINGS(id) where (id >=1500 and id<=2100)

--task5
create table #Task5
(id int,
cc int identity(1,1),
name varchar(100)
);
set nocount on;
declare @i int =0;
while @i < 1000
begin 
insert #Task5(id, name) 
values (floor(3000*rand()),'string');
set @i = @i+1;
end;

create index #TASK_TKEY ON #Task5(id)
go;
insert top(250000) #Task5(id, name) select id, name from #Task5


select name[»ндекс], avg_fragmentation_in_percent[‘рагментаци€(%)]
from sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'),
OBJECT_ID(N'#Task5'), NULL, NULL, NULL) ss JOIN sys.indexes ii on ss.object_id = 
ii.object_id and ss.index_id = ii.index_id where name is not null

alter index #TASK_TKEY on #Task5 reorganize;

alter index #TASK_TKEY on #Task5 rebuild with (online = off);

--task6

drop index #TASK_TKEY on #Task5
create index #TASK5_TKEY ON #Task5(id) with (fillfactor = 65)

insert top(50) percent into #Task5(id, name)
select id, name from #Task5
select name[»ндекс], avg_fragmentation_in_percent[‘рагментаци€(%)]
from sys.dm_db_index_physical_stats(DB_ID(N'tempdb'),
OBJECT_ID(N'#STRINGS'), NULL, NULL, NULL) ss JOIN sys.indexes ii on ss.object_id = 
ii.object_id and ss.index_id = ii.index_id where name is not null
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
--task7

--7,1
use Zhuk_Base
exec sp_helpindex'—туденты'

select * from ”спеваемость where —редн€€_оценка between 6 and 10 order by —редн€€_оценка
checkpoint;

dbcc dropcleanbuffers;

--create clustered index #”спеваемость on ”спеваемость(—редн€€_оценка asc)
 --7.2	
 select count(*)[ ол-во строк] from ”спеваемость;
select * from ”спеваемость;

create index ”спеваемость on ”спеваемость(ID, Ќомер_студенческого)

select * from ”спеваемость where —редн€€_оценка > 4 and „исло_пропусков < 5
select * from ”спеваемость order by —редн€€_оценка, „исло_пропусков

select * from ”спеваемость where —редн€€_оценка = 6

--7,3
create index ”спеваемость2 on ”спеваемость(ID) include (Ќомер_студенческого)

select Ќомер_студенческого from ”спеваемость where ID >5

--7.4
select —редн€€_оценка from ”спеваемость where —редн€€_оценка between 4 and 7
select —редн€€_оценка from ”спеваемость where —редн€€_оценка >3 and id<6
select —редн€€_оценка from ”спеваемость where —редн€€_оценка =7

create index —редн€€”спеваемость on ”спеваемость(—редн€€_оценка) where —редн€€_оценка > 3 and —редн€€_оценка < 8

--7.5
insert ”спеваемость values (8, 88888, 1, 2) select id from ”спеваемость
select name[»ндекс], avg_fragmentation_in_percent[‘рагментаци€(%)]
from sys.dm_db_index_physical_stats(DB_ID(N'Zhuk_Base'),
OBJECT_ID(N'”спеваемость'), NULL, NULL, NULL) ss JOIN sys.indexes ii on ss.object_id = 
ii.object_id and ss.index_id = ii.index_id where name is not null

alter index —редн€€”спеваемость on ”спеваемость reorganize;

alter index —редн€€”спеваемость on ”спеваемость rebuild with (online = off);

--7.6
drop index —редн€€”спеваемость on ”спеваемость
create index —редн€€”спеваемость2 ON ”спеваемость(id) with (fillfactor = 65)

--insert top(50) percent into ”спеваемость(id, name)
--select id, name from ”спеваемость
--select name[»ндекс], avg_fragmentation_in_percent[‘рагментаци€(%)]
--from sys.dm_db_index_physical_stats(DB_ID(N'tempdb'),
--OBJECT_ID(N'#STRINGS'), NULL, NULL, NULL) ss JOIN sys.indexes ii on ss.object_id = 
--ii.object_id and ss.index_id = ii.index_id where name is not null