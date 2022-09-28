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




