CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL
);
CREATE TABLE Loan (
    loan_id INT PRIMARY KEY,
    customer_id INT,
    loan_amount DECIMAL(10, 2) NOT NULL,
    loan_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
INSERT INTO Customers (customer_id, customer_name)
VALUES
    (1, 'Alice Johnson'),
    (2, 'Bob Smith'),
    (3, 'Charlie Davis');
SELECT * FROM Customers;
INSERT INTO Loan (loan_id, customer_id, loan_amount, loan_date)
VALUES
    (101, 1, 5000.00, TO_DATE('15-01-2024', 'DD-MM-YYYY')),
    (102, 1, 3000.00, TO_DATE('01-03-2024', 'DD-MM-YYYY')),
    (103, 2, 7000.00, TO_DATE('10-02-2024', 'DD-MM-YYYY')),
    (104, 3, 4500.00, TO_DATE('05-04-2024', 'DD-MM-YYYY')),
    (105, 2, 8000.00, TO_DATE('20-05-2024', 'DD-MM-YYYY'));
  
SELECT * FROM Loan;


CREATE OR REPLACE PROCEDURE GetLoansAfterDate(acc INT, p_loan_date DATE) AS
    CURSOR cur IS 
        SELECT loan_id, customer_id, loan_amount, loan_date 
        FROM Loan 
        WHERE loan_date > p_loan_date AND customer_id = acc; -- Use p_loan_date and filter by customer_id
    cur1 cur%ROWTYPE;
BEGIN
    OPEN cur;
    LOOP
        FETCH cur INTO cur1;
        EXIT WHEN cur%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('LOANID: ' || cur1.loan_id || 
                             ' | CUSTOMER ID: ' || cur1.customer_id || 
                             ' | LOAN AMOUNT: ' || cur1.loan_amount || 
                             ' | DATE: ' || cur1.loan_date);
    END LOOP;
    CLOSE cur;
END GetLoansAfterDate;
/


SET SERVEROUTPUT ON;
ACCEPT acc NUMBER PROMPT 'ENTER CUSTOMER NUMBER: ';
ACCEPT cdate CHAR PROMPT 'ENTER LOAN DATE (DD-MM-YYYY): ';

DECLARE
    acc_num INT := &acc; -- Accept the customer number
    p_loan_date DATE := TO_DATE('&cdate', 'DD-MM-YYYY');
BEGIN
    GetLoansAfterDate(acc_num, p_loan_date);
END;
/



   
