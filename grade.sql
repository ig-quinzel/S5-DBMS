CREATE TABLE STUD(NO INT PRIMARY KEY,NAME varchar(20),S1 number,S2 number);
INSERT INTO STUD VALUES(1,'NAN',8,7);
INSERT INTO STUD VALUES(2,'SRA',6.7,8.9);
INSERT INTO STUD VALUES(3,'ASWA',7.5,8.9);
SELECT * FROM STUD;

SET SERVEROUTPUT ON;

DECLARE 
  CURSOR cur IS
    SELECT NO,NAME,S1,S2
    FROM STUD
    WHERE (S1+S2)>12
    ORDER BY NO;
    
  cur1 cur%ROWTYPE;
  high number;
    
BEGIN
    OPEN cur;
    
    LOOP
     FETCH cur INTO cur1;
     EXIT WHEN cur%NOTFOUND;
     
     high:=GREATEST(cur1.S1,cur1.S2);
     DBMS_OUTPUT.PUT_LINE(
     'ROLL:'||cur1.NO||
     'NAME:'||cur1.NAME||
     'high:'||high);
    END LOOP;

    CLOSE cur;
END;
/
