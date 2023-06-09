use master 
go
create database NewBase
on primary
(name= N'Z_Base_mdf', filename= N'D:\db\Z_Base_mdf.mdf', 
size = 10240Kb, maxsize=UNLIMITED, filegrowth= 1024KB)
log on(
name = N'Z_Base_log', filename= N'D:\db\Z_Base_log.log', 
size = 10240Kb, maxsize=2048Gb, filegrowth= 10%)
go

