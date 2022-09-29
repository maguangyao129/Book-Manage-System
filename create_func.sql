--��ѯĳһ���Ž���ͼ�������
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

--��ѯĳһ������ȫ��ͼ���ƽ���۸�
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

--��ѯĳһͼ������н���Ա����Ϣ
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

--��ѯĳһ�û���δ�黹����ͼ��
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

--��ѯĳһ�û����ĵ�����ͼ��
CREATE FUNCTION FUC_find_allbooks(@enmae varchar(20))
RETURNS TABLE
AS
RETURN SELECT Bname,Bauthor,Bprice
	   FROM Book
	   WHERE Bid in(
			SELECT Bid
			FROM Brrow
	   );