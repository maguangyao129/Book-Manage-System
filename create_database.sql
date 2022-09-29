use master;
go
--删除数据库
if exists(select * from sysdatabases where name='Book_Manage')
drop database Book_Manage
go
--创建数据库
create database Book_Manage
on primary
(
name='Book_Manage_data',
filename='D:\SQLServer\project\Book_Manage_data.mdf', --主数据库文件
size=10MB,
filegrowth=2MB
),
(
name='Book_Manage_dataSec',
filename='D:\SQLServer\project\Book_Manage_data.ndf', --次数据库文件
size=3MB,
filegrowth=1MB
)
log on
(
name='Book_Manage_log',
filename='D:\SQLServer\project\Book_Manage_log.ldf', --主日志文件
size=3MB,
filegrowth=1MB
),
(
name='Book_Manage_logSec',
filename='D:\SQLServer\project\Book_Manage_logSec.ldf', --次日志文件
size=3MB,
filegrowth=1MB
)
go