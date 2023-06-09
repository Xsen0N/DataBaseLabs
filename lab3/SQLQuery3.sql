use master 
create database Zhuk_Base2
on primary
(name= N'Z_Base_mdf', filename= N'D:\db\labs\Z_Base_mdf.mdf', 
size = 10240Kb, maxsize=UNLIMITED, filegrowth= 1024KB),
(name = N'Z_Base_ndf', filename= N'D:\db\Z_Base_ndf.ndf', 
size = 10240Kb, maxsize=1Gb, filegrowth= 25%),
filegroup FG1
(name = N'Z_Base_fgl_1', filename= N'D:\db\labs\Z_Base_fgl_1.ndf', 
size = 10240Kb, maxsize=1Gb, filegrowth= 25%),
(name = N'Z_Base_fgl_2', filename= N'D:\db\labs\Z_Base_fgl_2.ndf', 
size = 10240Kb, maxsize=1Gb, filegrowth= 25%)
log on(
name = N'Z_Base_log', filename= N'D:\db\labs\Z_Base_log.idf', 
size = 10240Kb, maxsize=2048Gb, filegrowth= 10%)
go
