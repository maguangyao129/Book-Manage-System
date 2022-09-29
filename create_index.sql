CREATE INDEX index_book ON Book(Bname)


CREATE INDEX index_employee ON Employment(Ename,Did);

CREATE UNIQUE INDEX index_brrow ON Brrow(Bid,Eid);

CREATE NONCLUSTERED INDEX index_press ON press (Pname)
WITH FILLFACTOR = 40; 

CREATE INDEX index_Book_press ON Book(Bid,Pid);





