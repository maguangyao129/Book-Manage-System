--��ѯĳһԱ�����ĵ�����ͼ�鼰�黹ʱ��
CREATE PROC Pfind_employee_book
	@name varchar(20)
AS
	SELECT Bname,Bauthor,Bamount,Rtime
	FROM Book B,Brrow Br
	WHERE B.Bid in (
		SELECT Bid
		FROM Brrow 
		WHERE Eid =(
		SELECT Eid 
		FROM Employment 
		WHERE Ename = @name
		)AND B.Bid = Br.Bid
	)
GO

--��ѯĳһͼ�鱻���ĵ�����Ա��
CREATE PROC Pfind_book_employee
	@name varchar(20)
AS
	SELECT Ename,Esex,Ebirthday
	FROM Employment
	WHERE Eid in (
		SELECT Eid
		FROM Brrow 
		WHERE Bid =(
		SELECT Bid 
		FROM Book 
		WHERE Bname = @name
		)
	)
GO

--��ѯĳһ���Ž��ĵ�����ͼ��
CREATE PROC Pfind_department_employee
	@name varchar(20)
AS
	SELECT Ename,Esex,Ebirthday
	FROM Employment
	WHERE Did = (
		SELECT Did 
		FROM department
		WHERE Dname = @name
		)
	
GO

--��ѯ�����ѹ���δ�ջص�ͼ��
CREATE PROC Pfind_overdue_book
AS
	SELECT Bname,Bauthor,Bprice
	FROM Book
	WHERE Bid in(
		SELECT Bid 
		FROM Brrow
		WHERE FRtime > Rtime
	)
GO

--��ѯĳһ�����������ͼ��
CREATE PROC Pfind_press_book
	@name varchar(20)
AS
	SELECT Bname,Bauthor,Bprice,Bamount
	FROM Book
	WHERE Pid =(
		SELECT Pid
		FROM Press
		WHERE Pname = @name
	)
GO
--�鿴���ܺ�ĳ���������
CREATE PROC Pcheck_Press
AS
	SELECT Pname,Padress,Pcontact,
	DEtel = CONVERT(CHAR(11),DECRYPTBYASYMKEY(ASYMKEY_ID('asym_key_client'),PEtel,N'abcd1234@'))
	FROM Press;
GO

--Ϊ���ܺ�ĳ������������
CREATE PROC Pinsert_Press
	@name varchar(20),
	@adress varchar(50),
	@tel varchar(15),
	@contact varchar(10)
AS
	INSERT INTO Press (Pname,Padress,PEtel,Pcontact)
	VALUES(@name,@adress,ENCRYPTBYASYMKEY( ASYMKEY_ID('asym_key_client'),@tel),@contact)
GO

--Ϊ���ܺ�ĳ������޸ĵ绰����
CREATE PROC Pupdate_Press
	@name varchar(20),
	@newtel varchar(15)
AS
	UPDATE Press
	SET PEtel = ENCRYPTBYASYMKEY( ASYMKEY_ID('AsymKey_TestDb'), @newtel)
GO
	
	

