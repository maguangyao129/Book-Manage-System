CREATE TABLE Book(
	Bid int PRIMARY KEY NOT NULL IDENTITY,
	Bname varchar(30),
	Bauthor varchar(30),
	Bprice decimal(6,2),
	Bamount int,
	Pid int
);

CREATE  TABLE Press(
	Pid int PRIMARY KEY NOT NULL IDENTITY,
	Pname varchar(30),
	Padress varchar(50),
	Ptel varchar(20),
	Pcontact varchar(20),
	Bid int,
);

ALTER TABLE Book ADD FOREIGN KEY(Pid) REFERENCES Press(Pid);


CREATE TABLE Department(
	Did int PRIMARY KEY NOT NULL IDENTITY,
	Dname varchar(30),
	Dtel varchar(20),
);

CREATE TABLE Employment(
	Eid int PRIMARY KEY NOT NULL IDENTITY,
	Ename varchar(30),
	Esex varchar(2) null DEFAULT 'ÄÐ' check(Esex = 'ÄÐ' or Esex = 'Å®'),
	Ebirthday date,
	Did int
);
ALTER TABLE Employment ADD FOREIGN KEY (Did) REFERENCES Department(Did); 


CREATE TABLE Brrow(
	Bid int,
	Eid int,
	Btime date,
	Rtime date,
	FRtime date
);
ALTER TABLE Brrow ADD FOREIGN KEY (Bid) REFERENCES Book(Bid);
ALTER TABLE Brrow ADD FOREIGN KEY (Eid) REFERENCES Employment(Eid);

