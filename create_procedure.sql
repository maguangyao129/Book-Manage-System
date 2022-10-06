--查询某一员工借阅的所有图书及归还时间
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

--查询某一图书被借阅的所有员工
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

--查询某一部门借阅的所有图书
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

--查询所有已过期未收回的图书
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

--查询某一出版社的所有图书
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
--查看加密后的出版社数据
CREATE PROC Pcheck_Press
AS
	SELECT Pname,Padress,Pcontact,
	DEtel = CONVERT(CHAR(11),DECRYPTBYASYMKEY(ASYMKEY_ID('asym_key_client'),PEtel,N'abcd1234@'))
	FROM Press;
GO

--为加密后的出版社添加数据
CREATE PROC Pinsert_Press
	@name varchar(20),
	@adress varchar(50),
	@tel varchar(15),
	@contact varchar(10)
AS
	INSERT INTO Press (Pname,Padress,PEtel,Pcontact)
	VALUES(@name,@adress,ENCRYPTBYASYMKEY( ASYMKEY_ID('asym_key_client'),@tel),@contact)
GO

--为加密后的出版社修改电话号码
CREATE PROC Pupdate_Press
	@name varchar(20),
	@newtel varchar(15)
AS
	UPDATE Press
	SET PEtel = ENCRYPTBYASYMKEY( ASYMKEY_ID('AsymKey_TestDb'), @newtel)
GO
	
	

