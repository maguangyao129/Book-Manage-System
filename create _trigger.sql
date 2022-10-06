--��ӽ�����Ϣǰ�ļ�鴥����
IF EXISTS(
  SELECT * from sysobjects 
	WHERE xtype = 'TR' 
	AND NAME =  'trigger_broow_check')
	DROP TRIGGER trigger_broow_check
GO
CREATE TRIGGER trigger_broow_check
ON Brrow
INSTEAD OF INSERT
AS
Begin 
	DECLARE @remain int
	DECLARE @newBid int
	DECLARE @newEid int
	SELECT @newBid = Bid from inserted
	SELECT @newEid = Eid from inserted
	IF NOT exists(SELECT * FROM Employment WHERE Eid = @newEid)
		BEGIN
			print('���û�������!!!')
			ROLLBACK TRANSACTION
		END
	ELSE
	BEGIN
		SELECT @remain = BRamount FROM Book B
			WHERE B.Bid = @newBid
		IF(@remain <= 0)
			BEGIN
				print('��Ҫ���ĵ��鼮�ڴ�Ϊ��')
				ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			update Book
			set BRamount = BRamount - 1
			where Bid = @newBid
			END
	END	
END
GO

--ɾ��������Ϣ���ͷŴ�����
IF EXISTS(
  SELECT * from sysobjects 
	WHERE xtype = 'TR' 
	AND NAME =  'trigger_brrow_delecte')
	DROP TRIGGER trigger_brrow_delecte
GO
CREATE TRIGGER trigger_brrow_delecte
ON Brrow
AFTER DELETE
AS
BEGIN
	DECLARE @id int
	SELECT @id = Bid from deleted
	update Book 
	SET BRamount = BRamount + 1
	WHERE Bid = @id
	
END
GO

--Ա��ɾ��ǰ������Ϣ��鴥����
IF EXISTS(
  SELECT * from sysobjects 
	WHERE xtype = 'TR' 
	AND NAME =  'trigger_employment_check')
	DROP TRIGGER trigger_employment_check
GO
CREATE TRIGGER trigger_employment_check
ON Employment
INSTEAD OF DELETE
AS
	DECLARE @Eid int
	select @Eid = Eid from deleted
	IF NOT EXISTS(SELECT * FROM Brrow WHERE Eid = @Eid)
BEGIN
	DELETE Employment
	WHERE Eid = @Eid
END
GO

--�鼮ɾ��ǰ������Ϣ��鴥����
IF EXISTS(
  SELECT * from sysobjects 
	WHERE xtype = 'TR' 
	AND NAME =  'trigger_book_delete')
	DROP TRIGGER trigger_book_delete
GO
CREATE TRIGGER trigger_book_delete
ON Book
INSTEAD OF DELETE
AS
	DECLARE @Bid int
	SELECT @Bid = Bid FROM deleted
	IF NOT EXISTS(SELECT * FROM Brrow WHERE Bid = @Bid)
BEGIN
	Delete Book
	WHERE Bid = @Bid
END
GO

--�鼮�����¼�鴥����
IF EXISTS(
  SELECT * from sysobjects 
	WHERE xtype = 'TR' 
	AND NAME =  'trigger_book_update')
	DROP TRIGGER trigger_book_update
GO
CREATE TRIGGER trigger_book_update
On Book
INSTEAD OF UPDATE
AS
DECLARE @Bid int
BEGIN
	
	DECLARE @amount  int
	DECLARE @new_amount int
	DECLARE @remain_amount int
	select @new_amount = Bamount from inserted
	select @remain_amount = BRamount from deleted
	select @amount = COUNT(*) FROM
						Brrow WHERE Bid = @Bid
	if(@amount + @remain_amount > @new_amount)
		BEGIN
			print('�����޸Ĳ��Ϸ���С��ԭʼ���')
			ROLLBACK TRANSACTION
		END
	ELSE
		BEGIN
			update Book
			set Bamount = @new_amount
			WHERE Bid = @Bid
		END

END



