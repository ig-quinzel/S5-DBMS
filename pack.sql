-- Create the Employee table
CREATE TABLE Employee (
    eid INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(255),
    salary DECIMAL(10, 2) NOT NULL
);

-- Create the EMPLOYEEPACK package specification
CREATE OR REPLACE PACKAGE EMPLOYEEPACK AS
    PROCEDURE ADDPACK(EMPID IN INT, ENAME IN VARCHAR2, EADDRESS IN VARCHAR2, ESALARY IN DECIMAL);
    PROCEDURE DELETEPACK(EMPID IN INT);
    PROCEDURE LISTEMP;
    FUNCTION SAL(EMPID IN INT) RETURN DECIMAL;
END EMPLOYEEPACK;
/

-- Create the body of the EMPLOYEEPACK package
CREATE OR REPLACE PACKAGE BODY EMPLOYEEPACK AS
    PROCEDURE ADDPACK(EMPID IN INT, ENAME IN VARCHAR2, EADDRESS IN VARCHAR2, ESALARY IN DECIMAL) AS
    BEGIN
        INSERT INTO Employee(eid, name, address, salary) VALUES (EMPID, ENAME, EADDRESS, ESALARY);
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Added Employee - ID: ' || EMPID || ', Name: ' || ENAME || ', Address: ' || EADDRESS || ', Salary: ' || ESALARY);
    END ADDPACK;

    PROCEDURE LISTEMP AS
        CURSOR cur IS 
            SELECT eid, name, address, salary FROM Employee;
        cur1 cur%ROWTYPE;
    BEGIN
        OPEN cur;
        LOOP
            FETCH cur INTO cur1;
            EXIT WHEN cur%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('Employee - ID: ' || cur1.eid || ', Name: ' || cur1.name || ', Address: ' || cur1.address || ', Salary: ' || cur1.salary);
        END LOOP;
        CLOSE cur;
    END LISTEMP;

    PROCEDURE DELETEPACK(EMPID IN INT) AS
    BEGIN
        DELETE FROM Employee WHERE eid = EMPID; -- Ensure that you're using the correct column name
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Deleted Employee - ID: ' || EMPID);
    END DELETEPACK;

    FUNCTION SAL(EMPID IN INT) RETURN DECIMAL AS
        vsal DECIMAL(10, 2);
      BEGIN
        SELECT salary INTO vsal FROM Employee WHERE eid = EMPID;
        RETURN vsal;
    END SAL;
END EMPLOYEEPACK;
/

-- PL/SQL Block to execute the procedures
SET SERVEROUTPUT ON;
DECLARE
    todelete INT := &value_for_deletion;  -- Prompt for employee ID to delete
    vsal DECIMAL(10, 2);
    empid INT := &empid;  -- Prompt for employee ID to get salary
BEGIN
    -- Adding employees
    EMPLOYEEPACK.ADDPACK(1, 'John Doe', '123 Main St, Springfield', 50000.00);
    EMPLOYEEPACK.ADDPACK(2, 'Jane Smith', '456 Oak Ave, Springfield', 60000.00);
    EMPLOYEEPACK.ADDPACK(3, 'Emily Johnson', '789 Pine Rd, Springfield', 55000.00);

    -- List all employees
    EMPLOYEEPACK.LISTEMP;

    -- Get salary of a specific employee
    vsal := EMPLOYEEPACK.SAL(empid);
    DBMS_OUTPUT.PUT_LINE('Salary of Employee ID ' || empid || ': ' || vsal);

    -- Delete a specific employee
    EMPLOYEEPACK.DELETEPACK(todelete);
    
    -- List all employees after deletion
    EMPLOYEEPACK.LISTEMP;
END;
/
SHOW ERRORS PACKAGE BODY EMPLOYEEPACK;

