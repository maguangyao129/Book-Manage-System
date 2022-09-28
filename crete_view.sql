--��ѯ������������ȫ����ͼ����Ϣ
CREATE VIEW query_tianjin_allBook 
AS
	SELECT Bname,Bauthor,Bprice,Bamount
	from Book
	where Pid = (
		SELECT Pid
		FROM Press
		where Pname = '������������')
WITH CHECK OPTION;
GO

--��ѯ���м۸����20Ԫ��ͼ��
CREATE VIEW query_price_more20
AS
	SELECT Bname,Bauthor,Bprice,Bamount
	from Book
	where Bprice > 20
WITH CHECK OPTION;
GO

--��ѯ��������ŮԱ�����ĵ�ͼ��
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
			where Esex = 'Ů'
		)
	)
WITH CHECK OPTION;
GO

--��ѯ����ͼ�鳬��������Ա��
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
--��ѯδ�����ĵ�ͼ��
CREATE VIEW query_unbrrow_book
AS 
SELECT Bname,Bauthor,Bprice,Bamount
FROM Book
WHERE Bid NOT IN(
	SELECT DISTINCT Bid 
	From Brrow
)
WITH CHECK OPTION;


