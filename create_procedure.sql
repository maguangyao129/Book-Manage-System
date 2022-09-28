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
	SELECT Bname,Bauthor,Bprice,Bamount,COUNT(Bid) AS brrow_book_amount
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
		WHERE Dname = @name
	)



