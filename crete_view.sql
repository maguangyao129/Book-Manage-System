CREATE VIEW query_tianjin_allBook 
AS
	SELECT Bname,Bauthor,Bprice,Bamount
	from Book
	where Pid = (
		SELECT Pid
		FROM Press
		where Pname = '天津人民出版社')
WITH CHECK OPTION;
GO

CREATE VIEW query_price_more20
AS
	SELECT Bname,Bauthor,Bprice,Bamount
	from Book
	where Bprice > 20
WITH CHECK OPTION;
GO

CREATE VIEW query_girl_book
AS
	SELECT Bname,Bauthor,Bprice,Bamount
	FROM Book
	where Bid IN (
		SELECT Bid 
		FROM   Brrow
		where Eid = (
			SELECT Eid 
			FROM Employment
			where Esex = '女'
		)
	)
WITH CHECK OPTION;
GO

CREATE VIEW query_brrow_more3 
AS
SELECT Ename,Esex,Ebirthday
From Employment
WHERE Eid IN(
	SELECT Eid
	FROM Brrow
	GROUP BY Eid
	HAVING COUNT(*) > 3
)
WITH CHECK OPTION;
GO

CREATE VIEW query_brrow_amount
AS 
SELECT D.Dname ,count(Brrow.Bid)
FROM Department D,Brrow
WHERE Did in(
	SELECT Did
	FROM Employment
	WHERE Eid = Brrow.Eid
	GROUP BY Did
)
WITH CHECK OPTION;


