--查询某一部门借阅图书的数量
CREATE FUNCTION FUC_find_department_book(@dname varchar(20))
RETURNS int
AS
BEGIN
	DECLARE @result int
	SELECT @result = COUNT(*)
		FROM Brrow
		WHERE Eid in(
			SELECT Eid
			FROM Employment
			WHERE Did = (
				SELECT Did
				FROM Department
				WHERE Dname  = @Dname
			)
		)
		return @result
END
GO

--查询某一出版社全部图书的平均价格
CREATE FUNCTION FUC_find_press_avgprice(@pname varchar(20))
RETURNS decimal(6,2)
AS
BEGIN
	DECLARE @result decimal(6,2)
	SELECT @result = AVG(Bprice)
					FROM Book
					WHERE Pid = (
						SELECT Pid
						FROM Press
						WHERE Pname = @pname
					)
	return @result
END
GO

--查询某一图书的所有借阅员工信息
CREATE FUNCTION FUC_find_book_employee(@bname varchar)
RETURNS @rtable TABLE(employee_name varchar(20),employee_sex varchar(5),department varchar(20))
AS
BEGIN
	Insert INTO @rtable SELECT Ename, Esex,Did FROM Employment where Eid = (
		SELECT Eid
		FROM Brrow
		WHERE Bid = (
			SELECT Bid
			FROM Book
			WHERE Bname = @bname
		)
	)
	return 
END
GO

--查询某一用户的未归还借阅图书
CREATE FUNCTION FUC_find_overide(@enmae varchar(20))
RETURNS TABLE
AS
RETURN SELECT Bname,Bauthor,Bprice
	   FROM Book
	   WHERE Bid in(
			SELECT Bid
			FROM Brrow
			WHERE FRtime IS NULL
			OR FRtime > Btime
	   );
GO

--查询某一用户借阅的所有图书
CREATE FUNCTION FUC_find_allbooks(@enmae varchar(20))
RETURNS TABLE
AS
RETURN SELECT Bname,Bauthor,Bprice
	   FROM Book
	   WHERE Bid in(
			SELECT Bid
			FROM Brrow
	   );