--1.��ѯ���п��Ϊ0��ͼ��
SELECT Bname,Bamount,Bprice
FROM Book
WHERE BRamount= 0;

--2.��ѯ������Ա�����ĵ�ͼ��
SELECT Bname,Bamount,Bprice
FROM Book 
WHERE Bid in(
 SELECT Bid
 FROM Brrow
 WHERE Eid in(
	SELECT Eid
	FROM Employment
	WHERE Esex = '��'
 )
)

--3.��ѯ���г��������Ĵ���20Ԫ��ͼ��
SELECT Bname,Bamount,Bprice
FROM Book
WHERE Bprice >= 20.0;

--4.��ѯ����ͼ�鱻���ĵ�����
SELECT Bname,Bamount - BRamount as remain
FROM Book;

--5.��ѯ����������ͼ��
SELECT MAX(Count(Bid))
FROM Brrow
GROUP BY Bid;

--6.��ѯ����ͼ��������
SELECT MAX(Count(Eid))
FROM Brrow
GROUP BY Eid;

--7. ��ѯ�����鼮���ܼ�
SELECT SUM(Bprice)
FROM BOOK;

--8. ��ѯ��������������ͼ��
SELECT Bname,Bamount,Bprice
FROM Book B,Press P
WHERE P.Pid = B.Pid
GROUP BY B.Pid;

--9.��ѯ����δ�黹��ٹ��ͼ��
SELECT Bname,Bamount,Bprice
FROM Book
WHERE Bid in (
	SELECT Bid
	FROM BRROW
	WHERE FRtime is NULL OR FRTIME > Btime
);

--10.��ѯ���Ա�������ͼ�������
WITH Employ_count(Eid,counts) AS
	(SELECT Eid, sum(Eid)
	FROM Brrow
	Group By Eid)
SELECT Esex,SUM(E2.counts)
FROM Employment E1,Employ_count E2
GROUP BY Esex
HAVING E1.Eid = E2.Eid;





