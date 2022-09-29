use Book_Manage;
create login client with password='abcd1234@', default_database=Book_Manage;
create user client for login client with default_schema=dbo;
GRANT SELECT  ON dbo.Brrow TO client;
GRANT UPDATE  ON dbo.Brrow TO client;
GRANT INSERT  ON dbo.Brrow TO client;
GRANT DELETE  ON dbo.Brrow TO client;

GRANT SELECT  ON dbo.Book TO client;
GRANT SELECT  ON dbo.Employment TO client;
GRANT SELECT  ON dbo.Department TO client;
GRANT SELECT  ON dbo.Press TO client;

create login out_client with password='abcd1234@', default_database=Book_Manage;
create user out_client for login out_client with default_schema=dbo;
exec sp_addrolemember 'db_datareader ', 'out_client';

create login manager with password='abcd1234@', default_database=Book_Manage;
create user manager for login manager with default_schema=dbo;
exec sp_addrolemember 'db_owner', 'manager';

