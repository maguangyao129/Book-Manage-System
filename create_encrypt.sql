USE Book_Manage
GO
IF NOT EXISTS (SELECT * 
				FROM sys.symmetric_keys 
				WHERE name LIKE '%MS_DatabaseMasterKey%')
BEGIN		
	CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Book_ManageMasterKey@3*';
END
GO

CREATE ASYMMETRIC KEY asym_key_client
WITH ALGORITHM = RSA_2048
ENCRYPTION BY PASSWORD = 'abcd1234@';

USE Book_Manage
Go
ALTER TABLE Press
ADD PEtel varbinary(MAX) NULL
Go

Update Press
SET PEtel = ENCRYPTBYASYMKEY(ASYMKEY_ID('asym_key_client'),Ptel)
Go

ALTER TABLE Press
DROP COLUMN Ptel;


