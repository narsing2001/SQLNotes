use notes;
CREATE TABLE COURSE(
    course_id INT,
    course_name VARCHAR(20),
    duration_of_course INT,
    PRIMARY KEY(course_id)
); 

INSERT INTO COURSE(course_id, course_name, duration_of_course) 
VALUES
    (1, 'BCA', 3),
    (2, 'MCA', 3),
    (3, 'B.E.', 4),
    (4, 'M.E.', 2),
    (5, 'Integrated BE and ME', 5);
    

select * from COURSE;

CREATE TABLE STUDENT(
    roll_no INT,
    student_name VARCHAR(20),
    course_id INT,
    PRIMARY KEY(roll_no)
); 

INSERT INTO STUDENT(roll_no, student_name, course_id) 
VALUES
    (1, 'ANDREW', 1),
    (2, 'BOB', 1),
    (3, 'CHARLES', 1),
    (4, 'DAIZY', 3),
    (5, 'EMMANUEL', 2),
    (6, 'FAIZAL', 2),
    (7, 'GEORGE', 4),
    (8, 'HARSH', 5),
    (9, 'ISHA', 2),
    (10, 'JULIAN', 2),
    (11, 'KAILASH', 3),
    (12, 'LAIBA', 5),
    (13, 'MICHAEL', 3);

SELECT * FROM STUDENT;

-- Example of SQL SELECT DATE
-- Let’s create an Employee table with a column hire_date of type DATE, which stores the hiring date of employees.

CREATE TABLE Employee1 (
    EmpID INT,
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    HireDate DATE
);
INSERT INTO Employee1 (EmpID, FirstName, LastName, HireDate)
VALUES
(1, 'John', 'Doe', '2022-01-15'),
(2, 'Jane', 'Smith', '2021-06-30'),
(3, 'Alice', 'Johnson', '2020-08-25');

select * from employee1;

-- Example: Select Employees Hired on a Specific Date

SELECT FirstName, LastName, HireDate
FROM Employee1 WHERE HireDate = '2022-01-15';

-- This SQL query retrieves the FirstName, LastName, and HireDate of the employee who was hired on 2022-01-15.

-- Using SQL SELECT Date Functions for Filtering
-- These SQL functions allow you to extract specific components (like year, month, or day) from a DATE or DATETIME column.

-- YEAR(): Extracts the year from a date.
-- MONTH(): Extracts the month from a date.
-- DAY(): Extracts the day from a date.

-- Example 1: Select Employees Hired in a Specific Year
-- SELECT FirstName, LastName, HireDate
-- FROM Employee1
-- WHERE YEAR(HireDate) = 2021;

-- Example 2: Select Employees Hired in a Specific Month
SELECT FirstName, LastName, HireDate
FROM Employee1 WHERE MONTH(HireDate) = 6;

-- Advanced Date Functions

-- CURDATE() and NOW()
-- CURDATE(): Returns the current date (without the time component).
-- NOW(): Returns the current date and time.
-- Example 1: Select Employees Hired Before Today

SELECT FirstName, LastName, HireDate
FROM Employee1 WHERE HireDate < CURDATE();

-- Using SQL BETWEEN for Date Ranges
-- The BETWEEN operator allows you to filter records within a specified date range. 
-- This can be useful when you need to retrieve data between two specific dates, 
-- such as all transactions made within a certain period or all employees hired during a specific quarter.

-- Example 1: Select Employees Hired Between Two Dates

SELECT FirstName, LastName, HireDate
FROM Employee1 WHERE HireDate BETWEEN '2021-01-01' AND '2022-01-01';

select * from employee1;





