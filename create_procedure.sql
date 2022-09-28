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
	SELECT Bname,Bauthor,Bprice,Bamount,COUNT(Bid) AS brrow_book_amount
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
		WHERE Dname = @name
	)



