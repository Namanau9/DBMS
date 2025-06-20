CREATE TABLE CUSTOMER
(
CUSTOMER_ID NUMBER(10) PRIMARY KEY,
NAME VARCHAR(20)
);

CREATE TABLE ACCOUNT
(
ACCOUNT_NO NUMBER(10) PRIMARY KEY,
TYPE VARCHAR(20),
BALANCE NUMBER(10),
TRANSACTION_DATE DATE
);

CREATE TABLE ADDRESS
(
STREET VARCHAR(20),
CITY VARCHAR(20),
STATE VARCHAR(20),
CUSTOMER_ID REFERENCES CUSTOMER(CUSTOMER_ID) ON DELETE CASCADE,
PRIMARY KEY(CUSTOMER_ID,STREET)
);

CREATE TABLE CUSTOMER_ACCOUNT
(
CUSTOMER_ID REFERENCES CUSTOMER(CUSTOMER_ID) ON DELETE CASCADE,
ACCOUNT_NO REFERENCES ACCOUNT(ACCOUNT_NO) ON DELETE CASCADE,
PRIMARY KEY(CUSTOMER_ID,ACCOUNT_NO)
);



INSERT INTO CUSTOMER VALUES(1001,'RAJ');
INSERT INTO CUSTOMER VALUES(1002,'MUKESH');
INSERT INTO CUSTOMER VALUES(1003,'RAMESH');
INSERT INTO CUSTOMER VALUES(1004,'SURESH');
INSERT INTO CUSTOMER VALUES(1005,'BINOD');


INSERT INTO ACCOUNT VALUES(11,'SAVING',50000,NULL);
INSERT INTO ACCOUNT VALUES(12,'SAVING',500,'01-JAN-1947');
INSERT INTO ACCOUNT VALUES(13,'SAVING',52200,'10-JAN-1787');
INSERT INTO ACCOUNT VALUES(14,'SAVING',100,'31-MAY-2947');
INSERT INTO ACCOUNT VALUES(15,'SAVING',800000,'01-JUN-1947');

INSERT INTO ADDRESS VALUES('3RD CROSS','BANGALORE','KARNATAKA',1001);
INSERT INTO ADDRESS VALUES('4RD CROSS','BANGALORE','KARNATAKA',1002);
INSERT INTO ADDRESS VALUES('5RD CROSS','BANGALORE','KARNATAKA',1003);
INSERT INTO ADDRESS VALUES('6RD CROSS','BANGALORE','KARNATAKA',1004);
INSERT INTO ADDRESS VALUES('7RD CROSS','BANGALORE','KARNATAKA',1005);

INSERT INTO CUSTOMER_ACCOUNT VALUES(1001,11);
INSERT INTO CUSTOMER_ACCOUNT VALUES(1002,11);
INSERT INTO CUSTOMER_ACCOUNT VALUES(1003,11);
INSERT INTO CUSTOMER_ACCOUNT VALUES(1002,12);
INSERT INTO CUSTOMER_ACCOUNT VALUES(1003,13);
INSERT INTO CUSTOMER_ACCOUNT VALUES(1004,14);
INSERT INTO CUSTOMER_ACCOUNT VALUES(1005,15);
INSERT INTO CUSTOMER_ACCOUNT VALUES(1004,15);


--B)   
     UPDATE ACCOUNT SET BALANCE =BALANCE*1.05
     WHERE BALANCE <10000;

--C) 
     SELECT CA.ACCOUNT_NO, COUNT(CA.CUSTOMER_ID) AS NUM_CUSTOMERS
   FROM CUSTOMER_ACCOUNT CA
   GROUP BY CA.ACCOUNT_NO
   HAVING COUNT(CA.CUSTOMER_ID) > 3;

--D) 
     SELECT C.CUSTOMER_ID, SUM(0.5*BALANCE) AS TOTAL_INTEREST
   FROM CUSTOMER C, ACCOUNT A, CUSTOMER_ACCOUNT CA
   WHERE CA.ACCOUNT_NO = A.ACCOUNT_NO AND CA.CUSTOMER_ID = C.CUSTOMER_ID
   GROUP BY C.CUSTOMER_ID

--E)  
     SELECT C.CUSTOMER_ID, C.NAME
    FROM CUSTOMER C, ACCOUNT A, CUSTOMER_ACCOUNT CA
    WHERE CA.ACCOUNT_NO = A.ACCOUNT_NO AND
    CA.CUSTOMER_ID = C.CUSTOMER_ID AND
    A.TRANSACTION_DATE IS NULL
