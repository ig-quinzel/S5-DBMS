CREATE TABLE bill (
consumer_no NUMBER PRIMARY KEY,
consumer_name VARCHAR2(50),
past_reading NUMBER,
present_reading NUMBER
);
insert into bill values(101, 'Jacob',146,350);
insert into bill values(102, 'Henry', 565,200);
insert into bill values(103, 'John', 145,650);
insert into bill values(104, 'Evan', 77,160);
insert into bill values (105, 'Eric', 57,380);
insert into bill values (106, 'Jim', 132,100);
insert into bill values (107, 'Susan', 801,99);
insert into bill values (108, 'Ivan', 99,840);
insert into bill values (303, 'Jill', 222,574);
insert into bill values (305, 'Kevin', 399,520);
insert into bill values (310, 'James', 499,132);
SET LINESIZE 200;
SELECT * FROM bill;
SET SERVEROUTPUT ON;
ACCEPT ACC NUMBER PROMPT'ENTER ACC NUMBER';
DECLARE
 CURSOR CUR is
  SELECT * FROM bill;
 CUR1 CUR%ROWTYPE;
 CONSU NUMBER;
 CHARGE NUMBER;
BEGIN
 OPEN CUR;
  LOOP
   FETCH CUR INTO CUR1;
   EXIT WHEN CUR%NOTFOUND;
   CONSU:=CUR1.present_reading-CUR1.past_reading;
   IF CONSU<=100 then
    CHARGE:=100*0.5;
   ELSIF CONSU<=300 AND CONSU>=101 then
    CHARGE:=(100*0.5)+(CONSU-100)*7.5;
   ELSIF CONSU>=301 AND CONSU<=500 then
    CHARGE:=(100*0.5)+(200*7.5)+(CONSU-300)*15;
   else 
    CHARGE:=(100*0.5)+(200*7.5)+(200*15)+(CONSU-500)*27.5;
   END IF;
   IF CUR1.consumer_no=&ACC then
    DBMS_OUTPUT.PUT_LINE('CONS NUMBER : '||CUR1.consumer_no||'  CONSUMED :'||CONSU||'  CHARGE IS  : '||CHARGE);
   END IF;
  END LOOP;
 CLOSE CUR;
END;
/
 
