use master;
go
--ɾ�����ݿ�
if exists(select * from sysdatabases where name='Book_Manage')
drop database Book_Manage
go
--�������ݿ�
create database Book_Manage
on primary
(
name='Book_Manage_data',
filename='D:\SQLServer\project\Book_Manage_data.mdf', --�����ݿ��ļ�
size=10MB,
filegrowth=2MB
),
(
name='Book_Manage_dataSec',
filename='D:\SQLServer\project\Book_Manage_data.ndf', --�����ݿ��ļ�
size=3MB,
filegrowth=1MB
)
log on
(
name='Book_Manage_log',
filename='D:\SQLServer\project\Book_Manage_log.ldf', --����־�ļ�
size=3MB,
filegrowth=1MB
),
(
name='Book_Manage_logSec',
filename='D:\SQLServer\project\Book_Manage_logSec.ldf', --����־�ļ�
size=3MB,
filegrowth=1MB
)
go