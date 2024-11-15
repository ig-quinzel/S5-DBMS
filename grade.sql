CREATE TABLE std_honors (
rollno int PRIMARY KEY,
name VARCHAR(30),
s1 NUMBER,
s2 NUMBER
);
INSERT INTO std_honors VALUES (52, 'Bob', 8.5,8.6);
INSERT INTO std_honors VALUES (53, 'Charlie', 7, 4);
INSERT INTO std_honors VALUES (51, 'Alice', 5.9, 2.9);
INSERT INTO std_honors VALUES (57, 'Grace', 7, 8);
select * from std_honors;

SET SERVEROUTPUT ON;
DECLARE
 CURSOR CUR is
  SELECT * FROM std_honors WHERE (S1+S2)>12 order BY rollno;
 CUR1 CUR%ROWTYPE;
 HIGH NUMBER;
BEGIN
 DBMS_OUTPUT.PUT_LINE('no   NAME      S1      S2   HIGHEST');
 OPEN CUR;
  LOOP
   FETCH CUR INTO CUR1;
   EXIT WHEN CUR%NOTFOUND;
   HIGH:=GREATEST(CUR1.S1,CUR1.S2);
   DBMS_OUTPUT.PUT_LINE(CUR1.rollno||'    '||CUR1.NAME||'     '||CUR1.S1||'     '||CUR1.S2||'    '||HIGH);
  END LOOP;
 CLOSE CUR;
END;
/
  
