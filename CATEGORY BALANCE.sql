CREATE TABLE customer_balance (
CID NUMBER(5) NOT NULL PRIMARY KEY,
bal NUMBER(10),CAT VARCHAR(20)
);
INSERT INTO customer_balance (CID, bal) VALUES (101, 10500);
INSERT INTO customer_balance (CID, bal) VALUES (102, 7830);
INSERT INTO customer_balance (CID, bal) VALUES (103, 45000);
INSERT INTO customer_balance (CID, bal) VALUES (104, 70000);
INSERT INTO customer_balance (CID, bal) VALUES (105, 500);
INSERT INTO customer_balance (CID, bal) VALUES (106, 12003);
INSERT INTO customer_balance (CID, bal) VALUES (107, 78030);
select * from customer_balance;

SET SERVEROUTPUT ON;

DECLARE
  MSG VARCHAR(20);
  CURSOR CUR IS 
    SELECT * FROM customer_balance;
  CUR1 CUR%ROWTYPE;
  
 PROCEDURE CATEGORY(CID NUMBER,BAL NUMBER) IS
 BEGIN
     IF bal>50000 then 
      MSG:='PLATINUM';
     ELSIF BAL<=50000 AND BAL>10000 then
      MSG:='GOLD';
     ELSE 
      MSG:='SILVER';
     end IF;
     DBMS_OUTPUT.PUT_LINE(CID  ||'      '|| BAL   ||'      ' || MSG);
  END CATEGORY;
BEGIN
   DBMS_OUTPUT.PUT_LINE('CID       BALANCE   CATEGORY');
   OPEN CUR;
    LOOP
     FETCH CUR INTO CUR1;
     EXIT when CUR%NOTFOUND;
     CATEGORY(CUR1.CID,CUR1.BAL);
    END LOOP;
   CLOSE CUR;
END;
/
