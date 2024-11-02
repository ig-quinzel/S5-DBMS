-- Create the STUD table
CREATE TABLE STUD (
    NO INT PRIMARY KEY,
    NAME VARCHAR(20),
    S1 NUMBER,
    S2 NUMBER,
    S3 NUMBER,
    TOTAL NUMBER,
    AVER NUMBER
);

-- Enable output for DBMS
SET SERVEROUTPUT ON;

-- Create the trigger
CREATE OR REPLACE TRIGGER TRIG1
BEFORE INSERT ON STUD
FOR EACH ROW
BEGIN
    :NEW.TOTAL:= :NEW.S1 + :NEW.S2 + :NEW.S3;
    :NEW.AVER := :NEW.TOTAL/3;
END TRIG1;
/

-- Insert a record into STUD
INSERT INTO STUD(NO,NAME,S1,S2,S3) VALUES (9, 'HEH', 10, 10,10);
INSERT INTO STUD(NO,NAME,S1,S2,S3) VALUES (10, 'HEH', 10, 10,10);

SELECT * FROM STUD;


