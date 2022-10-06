--1.查询所有库存为0的图书
SELECT Bname,Bamount,Bprice
FROM Book
WHERE BRamount= 0;

--2.查询所有男员工借阅的图书
SELECT Bname,Bamount,Bprice
FROM Book 
WHERE Bid in(
 SELECT Bid
 FROM Brrow
 WHERE Eid in(
	SELECT Eid
	FROM Employment
	WHERE Esex = '男'
 )
)

--3.查询所有出版社出版的大于20元的图书
SELECT Bname,Bamount,Bprice
FROM Book
WHERE Bprice >= 20.0;

--4.查询各个图书被借阅的数量
SELECT Bname,Bamount - BRamount as remain
FROM Book;

--5.查询被借阅最多的图书
SELECT MAX(Count(Bid))
FROM Brrow
GROUP BY Bid;

--6.查询借阅图书最多的人
SELECT MAX(Count(Eid))
FROM Brrow
GROUP BY Eid;

--7. 查询所有书籍的总价
SELECT SUM(Bprice)
FROM BOOK;

--8. 查询各个出版社出版的图书
SELECT Bname,Bamount,Bprice
FROM Book B,Press P
WHERE P.Pid = B.Pid
GROUP BY B.Pid;

--9.查询所有未归还或迟归的图书
SELECT Bname,Bamount,Bprice
FROM Book
WHERE Bid in (
	SELECT Bid
	FROM BRROW
	WHERE FRtime is NULL OR FRTIME > Btime
);

--10.查询按性别分组借阅图书的数量
WITH Employ_count(Eid,counts) AS
	(SELECT Eid, sum(Eid)
	FROM Brrow
	Group By Eid)
SELECT Esex,SUM(E2.counts)
FROM Employment E1,Employ_count E2
GROUP BY Esex
HAVING E1.Eid = E2.Eid;





