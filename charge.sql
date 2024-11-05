CREATE TABLE CONSUMER (
    consumerno NUMBER PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    past_reading NUMBER,
    present_reading NUMBER
);
INSERT INTO CONSUMER (consumerno, name, past_reading, present_reading) VALUES (1, 'Alice Smith', 150, 200);
INSERT INTO CONSUMER (consumerno, name, past_reading, present_reading) VALUES (2, 'Bob Johnson', 300, 350);
INSERT INTO CONSUMER (consumerno, name, past_reading, present_reading) VALUES (3, 'Charlie Brown', 450, 500);
INSERT INTO CONSUMER (consumerno, name, past_reading, present_reading) VALUES (4, 'Daisy White', 600, 650);
INSERT INTO CONSUMER (consumerno, name, past_reading, present_reading) VALUES (5, 'Ethan Green', 700, 800);
SELECT * FROM CONSUMER;

SET SERVEROUTPUT ON;

DECLARE
  CURSOR cur(CONS NUMBER) IS 
    SELECT past_reading, present_reading FROM CONSUMER WHERE consumerno = CONS;

  cur1 cur%ROWTYPE;
  no INT;
  consu INT; -- Variable for consumption
  CHARGE DECIMAL(10, 2); -- Variable for charge calculation

BEGIN
  no := &no; -- Accept consumer number from user input
  
  OPEN cur(no);
  
  LOOP
    FETCH cur INTO cur1;
    EXIT WHEN cur%NOTFOUND; -- Exit loop if no more rows

    -- Calculate consumption
    consu := cur1.present_reading - cur1.past_reading;

    -- Calculate charges based on consumption
    IF consu <= 100 THEN
      CHARGE := consu * 5;
    ELSIF consu <= 300 THEN
      CHARGE := (100 * 5) + (consu - 100) * 7.5;
    ELSIF consu <= 500 THEN
      CHARGE := (100 * 5) + (200 * 7.5) + (consu - 300) * 15;
    ELSE
      CHARGE := (100 * 5) + (200 * 7.5) + (200 * 15) + (consu - 500) * 22.5;
    END IF;

    -- Print the result
    DBMS_OUTPUT.PUT_LINE('CONSUMER ' || no || ' UNITS ' || consu || ' CHARGE ' || CHARGE);
  END LOOP;

  CLOSE cur;
END;
/

     
    
