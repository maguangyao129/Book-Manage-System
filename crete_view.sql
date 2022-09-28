--查询天津人民出版社全部的图书信息
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

--查询所有价格大于20元的图书
CREATE VIEW query_price_more20
AS
	SELECT Bname,Bauthor,Bprice,Bamount
	from Book
	where Bprice > 20
WITH CHECK OPTION;
GO

--查询包含所有女员工借阅的图书
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

--查询借阅图书超过三本的员工
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
--查询未被借阅的图书
CREATE VIEW query_unbrrow_book
AS 
SELECT Bname,Bauthor,Bprice,Bamount
FROM Book
WHERE Bid NOT IN(
	SELECT DISTINCT Bid 
	From Brrow
)
WITH CHECK OPTION;


