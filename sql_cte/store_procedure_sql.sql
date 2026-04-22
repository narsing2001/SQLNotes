create database store_procedure;

use store_procedure;

CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    final_grade CHAR(2)
);

INSERT INTO students (id, name, final_grade) VALUES
(101, 'Alice Johnson', 'A'),
(102, 'Bob Smith', 'B'),
(103, 'Charlie Davis', 'A+'),
(104, 'Diana Miller', 'C'),
(105, 'Ethan Clark', 'B+');

DELIMITER $$
CREATE PROCEDURE GetStudentGrade(IN studentId INT, OUT grade CHAR(2))
BEGIN
    SELECT final_grade INTO grade FROM students WHERE id = studentId;
END
$$ DELIMITER ;


-- Declare variable to receive the grade
SET @grade = '';
-- Call the procedure for a specific student ID
CALL GetStudentGrade(103, @grade);
-- Display the grade
SELECT @grade;



--  1. IN Parameter – Get employee details by ID----------------------------------------------------------------------------------------------------------------------------

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

INSERT INTO employees VALUES
(1, 'Alice Johnson', 'alice@example.com'),
(2, 'Bob Smith', 'bob@example.com'),
(3, 'Charlie Lee', 'charlie@example.com'),
(4, 'Diana Prince', 'diana@example.com'),
(5, 'Ethan Brown', 'ethan@example.com');

DELIMITER $$
CREATE PROCEDURE GetEmployeeDetails(IN empId INT)
BEGIN
    SELECT * FROM employees WHERE id = empId;
END;
$$ DELIMITER ;

CALL GetEmployeeDetails(1);



-- 2. OUT Parameter – Get total employee count------------------------------------------------------------------------------------------------------------------------

DELIMITER $$
CREATE PROCEDURE GetEmployeeCount(OUT total INT)
BEGIN
    SELECT COUNT(*) INTO total FROM employees; 
END;
$$ DELIMITER ;

-- Step 1: Declare a variable to hold the result
SET @emp_total = 0;
-- Step 2: Call the procedure
CALL GetEmployeeCount(@emp_total);
-- Step 3: View the result
SELECT @emp_total;




-- 3. IN Parameter – Get products within a price range----------------------------------------------------------------------------------------------------------------------

CREATE TABLE products (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

INSERT INTO products VALUES
(1, 'Apple', 'Fruits', 1.50),
(2, 'Banana', 'Fruits', 0.75),
(3, 'Shampoo', 'Toiletries', 5.25),
(4, 'Toothpaste', 'Toiletries', 2.30),
(5, 'Orange', 'Fruits', 1.20);

DELIMITER $$
CREATE PROCEDURE GetProductsByPrice(IN minPrice DECIMAL(10,2), IN maxPrice DECIMAL(10,2))
BEGIN
    SELECT * FROM products WHERE price BETWEEN minPrice AND maxPrice;
END;
$$ DELIMITER ;

CALL GetProductsByPrice(100.00, 500.00);




-- 4. OUT Parameter – Get highest salary-------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10,2)
);

INSERT INTO employees VALUES
(1, 'Jane Doe', 55000.00),
(2, 'John Smith', 65000.00),
(3, 'Emily Jones', 62000.00),
(4, 'Mark White', 58000.00),
(5, 'Lucy Ray', 60000.00);

DELIMITER $$
CREATE PROCEDURE GetMaxSalary(OUT maxSalary DECIMAL(10,2))
BEGIN
    SELECT MAX(salary) INTO maxSalary FROM employees;
END;
$$ DELIMITER ;

-- Step 1: Declare a variable to hold the output
SET @max_salary = 0;
-- Step 2: Call the procedure and pass the variable
CALL GetMaxSalary(@max_salary);
-- Step 3: Retrieve the result
SELECT @max_salary;



-- 5. INOUT Parameter – Apply bonus to salary----------------------------------------------------------------------------------------------------------------
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10,2)
);

INSERT INTO employees VALUES
(1, 'Jane Doe', 55000.00),
(2, 'John Smith', 65000.00),
(3, 'Emily Jones', 62000.00),
(4, 'Mark White', 58000.00),
(5, 'Lucy Ray', 60000.00);
DELIMITER $$
CREATE PROCEDURE ApplyBonus(INOUT salary DECIMAL(10,2))
BEGIN
    SET salary = salary + (salary * 0.10); -- add 10% bonus
END;
$$ DELIMITER ;

-- Step 1: Declare and set the salary variable
SET @emp_salary = 50000.00;
-- Step 2: Call the procedure with the INOUT variable
CALL ApplyBonus(@emp_salary);
-- Step 3: Check the updated salary after applying the bonus
SELECT @emp_salary;


-- 6. INOUT Parameter – Increase price by percentage---------------------------------------------------------------------------------------------------------------------------
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10,2)
);

INSERT INTO products (name, price) VALUES
('Laptop', 800.00),
('Smartphone', 500.00),
('Headphones', 150.00),
('Tablet', 300.00);

DELIMITER $$
CREATE PROCEDURE AdjustPrice(INOUT price DECIMAL(10,2), IN percent DECIMAL(5,2))
BEGIN
    SET price = price + (price * percent / 100);
END 
$$ DELIMITER ;

-- Step 1: Declare and initialize the price variable
SET @product_price = 200.00;
-- Step 2: Call the procedure with the price variable and percentage value
-- For example, increasing price by 15%:
CALL AdjustPrice(@product_price, 15.00);
-- Step 3: Check the updated price
SELECT @product_price;


-- 7. IN and OUT – Get student grade by ID-------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    final_grade CHAR(2)
);
INSERT INTO students VALUES
(1, 'Rahul Mehta', 'A'),
(2, 'Sneha Kapoor', 'B'),
(3, 'Amit Shah', 'A'),
(4, 'Kiran Nair', 'C'),
(5, 'Pooja Rani', 'B');

DELIMITER $$
CREATE PROCEDURE GetStudentGrade(IN studentId INT, OUT grade CHAR(2))
BEGIN
    SELECT final_grade INTO grade FROM students WHERE id = studentId;
END;
$$ DELIMITER ;

-- Step 1: Declare an output variable
SET @grade = '+A';
-- Step 2: Call the procedure
CALL GetStudentGrade(101, @grade);
-- Replace 101 with the actual studentId.
-- Step 3: Retrieve the grade
SELECT @grade;



-- 8. INOUT Parameter – Reset login attempts if too high----------------------------------------------------------------------------------------------------------------------
-- Step 1: Create a users Table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50),
    login_attempts INT
);

INSERT INTO users (username, login_attempts) VALUES
('alice', 3),
('bob', 6),
('charlie', 5),
('david', 8);

DELIMITER $$
CREATE PROCEDURE CheckLoginAttempts(INOUT attempts INT)
BEGIN
    IF attempts > 5 THEN
        SET attempts = 0;
    END IF;
END;
$$ DELIMITER ;

-- Step 1: Declare and set the attempts variable
SET @login_attempts = 6;
-- Step 2: Call the procedure
CALL CheckLoginAttempts(@login_attempts);
-- Step 3: View the updated value
SELECT @login_attempts;


-- 9. IN Parameter – Delete customer by ID------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);
INSERT INTO customers (name, email) VALUES
('John Doe', 'john@example.com'),
('Jane Smith', 'jane@example.com'),
('Alice Johnson', 'alice@example.com');

DELIMITER $$
CREATE PROCEDURE DeleteCustomer(IN customerId INT)
BEGIN
    DELETE FROM customers WHERE id = customerId;
END;
$$ DELIMITER ;

CALL DeleteCustomer(101);



-- 10. OUT Parameter – Return current server time-------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE server_time_log (
    id INT AUTO_INCREMENT PRIMARY KEY,
    recorded_time DATETIME
);

DELIMITER $$
CREATE PROCEDURE LogServerTime()
BEGIN
    INSERT INTO server_time_log (recorded_time)
    VALUES (NOW());
END
$$ DELIMITER ;

CALL LogServerTime();
SELECT * FROM server_time_log;


