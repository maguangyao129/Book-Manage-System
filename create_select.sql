SELECT Bname,Bamount,Bprice
FROM Book
WHERE BRamount= 0;


SELECT Bname,Bamount,Bprice
FROM Book 
WHERE Bid in(
 SELECT Bid
 FROM Brrow
 WHERE Eid in(
	SELECT Eid
	FROM Employment
	WHERE Esex = 'ÄÐ'
 )
)

SELECT Bname,Bamount,Bprice
FROM Book
WHERE Bprice >= 20.0;

SELECT MAX(Count(Bid))
FROM Brrow
GROUP BY Bid;

SELECT Bname,Bamount - BRamount as remain
FROM Book;

SELECT MAX(Count(Eid))
FROM Brrow
GROUP BY Eid;

SELECT SUM(Bprice)
FROM BOOK;

SELECT Bname,Bamount,Bprice
FROM Book B,Press P
WHERE P.Pid = B.Pid
GROUP BY B.Pid;

SELECT Bname,Bamount,Bprice
FROM Book
WHERE Bid in (
	SELECT Bid
	FROM BRROW
	WHERE FRtime is NULL OR FRTIME > Btime
);



