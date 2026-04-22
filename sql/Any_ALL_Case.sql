create database any_all;
use any_all;


-- use of the ANY operator-----------------------------------------------------------------------------------------------

CREATE TABLE CUSTOMERS (
    ID INT PRIMARY KEY,
    NAME VARCHAR(50),
    AGE INT,
    CITY VARCHAR(50)
);

INSERT INTO CUSTOMERS (ID, NAME, AGE, CITY) VALUES
(1, 'Kevin', 25, 'New York'),
(2, 'Alice', 30, 'Chicago'),
(3, 'Karl', 28, 'Miami'),
(4, 'Bob', 25, 'Dallas'),
(5, 'Katie', 30, 'Austin'),
(6, 'John', 35, 'Seattle'),
(7, 'Kim', 22, 'Boston');


SELECT AGE FROM CUSTOMERS WHERE NAME LIKE 'K%';

SELECT * FROM CUSTOMERS 
WHERE AGE = ANY (SELECT AGE FROM CUSTOMERS WHERE NAME LIKE 'K%');

SELECT * FROM CUSTOMERS 
WHERE SALARY <> 
ALL (SELECT SALARY FROM CUSTOMERS WHERE AGE = 25);


-- use of the ALL operator-----------------------------------------------------------------------------------------------------------------

CREATE TABLE CUSTOMERS1(
    ID INT PRIMARY KEY,
    NAME VARCHAR(50),
    AGE INT,
    SALARY DECIMAL(10, 2),
    CITY VARCHAR(50)
);

INSERT INTO CUSTOMERS1 (ID, NAME, AGE, SALARY, CITY) VALUES
(1, 'Kevin', 25, 50000.00, 'New York'),
(2, 'Alice', 30, 60000.00, 'Chicago'),
(3, 'Karl', 28, 70000.00, 'Miami'),
(4, 'Bob', 25, 55000.00, 'Dallas'),
(5, 'Katie', 30, 50000.00, 'Austin'),
(6, 'John', 35, 80000.00, 'Seattle'),
(7, 'Kim', 22, 45000.00, 'Boston');


SELECT SALARY FROM CUSTOMERS1 WHERE AGE = 25;


SELECT * FROM CUSTOMERS1 
WHERE SALARY <> ALL (SELECT SALARY FROM CUSTOMERS1 WHERE AGE = 25);

-- Fetch customers whose salary is not equal to any of the salaries from the subquery.
-- In other words, salary ≠ 50000.00 AND salary ≠ 55000.00

-- <>  not equal to operator
-- SALARY <> ALL (...) ensures the customer's salary is different from every salary returned by the subquery.





-- ALL with HAVING Clause----------------------------------------------------------------------------------------------------------------
-- In SQL, the ALL operator can also be used with the HAVING clause to filter the results of a GROUP BY query based on a condition 
-- that applies to all the aggregated values in the group.

SELECT AGE, SALARY 
FROM CUSTOMERS1 
GROUP BY AGE, SALARY 
HAVING SALARY < ALL (SELECT AVG(SALARY) FROM CUSTOMERS1);


SELECT ID, NAME, AGE, SALARY, CITY
FROM CUSTOMERS1 
GROUP BY  ID, NAME, AGE, SALARY, CITY
HAVING SALARY < ALL (SELECT AVG(SALARY) FROM CUSTOMERS1);


-- Use of the Exist operator--------------------------------------------------------

CREATE TABLE CUSTOMERS2 (
   ID INT NOT NULL,
   NAME VARCHAR (20) NOT NULL,
   AGE INT NOT NULL,
   ADDRESS CHAR (25),
   SALARY DECIMAL (18, 2),       
   PRIMARY KEY (ID)
); 


INSERT INTO CUSTOMERS2 VALUES 
(1, 'Ramesh', 32, 'Ahmedabad', 2000.00 ),
(2, 'Khilan', 25, 'Delhi', 1500.00 ),
(3, 'Kaushik', 23, 'Kota', 2000.00 ),
(4, 'Chaitali', 25, 'Mumbai', 6500.00 ),
(5, 'Hardik', 27, 'Bhopal', 8500.00 ),
(6, 'Komal', 22, 'Hyderabad', 4500.00 ),
(7, 'Muffy', 24, 'Indore', 10000.00 );




select * from CUSTOMERS2;

create table CARS(
   ID INT NOT NULL, 
   NAME VARCHAR(20) NOT NULL, 
   PRICE INT NOT NULL, 
   PRIMARY KEY(ID)
);

Insert INTO CARS VALUES
(2, 'Maruti Swift', 450000),
(4, 'VOLVO', 2250000),
(7, 'Toyota', 2400000);

select * from CARS;

SELECT * FROM CUSTOMERS2 WHERE 
EXISTS (
   SELECT PRICE FROM CARS 
   WHERE CARS.ID = CUSTOMERS2.ID AND PRICE > 2000000
);
rollback;

UPDATE CUSTOMERS2 SET NAME = 'Kushal' 
WHERE EXISTS (
   SELECT NAME FROM CARS WHERE CUSTOMERS2.ID = CARS.ID
);

SELECT * FROM CUSTOMERS2;



truncate table CUSTOMERS2;

DELETE FROM CUSTOMERS2 WHERE 
EXISTS (
   SELECT * FROM CARS 
   WHERE CARS.ID = CUSTOMERS2.ID AND CARS.PRICE = 2250000
);


SELECT * FROM CUSTOMERS2;

SELECT * FROM CUSTOMERS WHERE 
NOT  EXISTS (
   SELECT * FROM CARS WHERE CUSTOMERS.ID = CARS.ID
);

-- Yes! ✅ Absolutely — EXISTS can and often does work across different tables in the same database. That's actually one of its most common uses.


--  What is EXISTS?
-- The EXISTS keyword in SQL is used to test for the existence of rows returned by a subquery.

-- 🔍 It returns TRUE if the subquery returns any row — even just one row.

-- ❌ It returns FALSE if the subquery returns no rows.

-- Question | Answer
-- Can EXISTS be used with different tables?    | ✅ YES
-- Condition                                    | Must be in the same database and fields must be logically related
-- Common Use                                   | Filtering based on presence in another table
-- Use Case Example                             | Customers who own cars, Employees who have projects, etc.


-- What is NOT EXISTS?---------------------------------------------------------------------------------------------
-- NOT EXISTS is the opposite of EXISTS.
-- EXISTS → returns TRUE if the subquery returns at least one row
-- NOT EXISTS → returns TRUE if the subquery returns zero rows
-- Syntex:

SELECT * FROM table1
WHERE NOT EXISTS (
   SELECT 1 FROM table2 WHERE table2.column = table1.column
);

SELECT * FROM CUSTOMERS2
WHERE NOT EXISTS (
   SELECT 1 FROM CARS WHERE CARS.ID = CUSTOMERS2.ID
);


DELETE FROM CUSTOMERS2
WHERE NOT EXISTS (
   SELECT 1 FROM CARS WHERE CARS.ID = CUSTOMERS2.ID
);

select * from CUSTOMERS2;

select * from CARS;

-- CASE Statement in the sql---------------------------------------------------------------------------------

CREATE TABLE CUSTOMERS3 (
   ID INT PRIMARY KEY,
   NAME VARCHAR(50),
   AGE INT,
   ADDRESS VARCHAR(100),
   SALARY DECIMAL(10, 2)
);

INSERT INTO CUSTOMERS3 VALUES 
(1, 'Ramesh', 32, 'Ahmedabad', 2000.00),
(2, 'Khilan', 25, 'Delhi', 1500.00),
(3, 'Kaushik', 23, 'Kota', 4000.00),
(4, 'Chaitali', 25, 'Mumbai', 6500.00),
(5, 'Hardik', 27, 'Bhopal', 8500.00),
(6, 'Komal', 22, 'Hyderabad', 4500.00),
(7, 'Muffy', 24, 'Indore', 10000.00);

-- Step 3: Understand the Goal
-- We want to:

-- Categorize each customer based on salary into:

-- 'Lowest paid' → ≤ 4000
-- 'Average paid' → > 4000 and ≤ 6500
-- 'Highest paid' → > 6500
-- Then group by these categories

-- And sum the salaries in each category

SELECT 
   CASE 
      WHEN SALARY <= 4000 THEN 'Lowest paid'
      WHEN SALARY > 4000 AND SALARY <= 6500 THEN 'Average paid'
      ELSE 'Highest paid' 
   END AS SALARY_STATUS,
   SUM(SALARY) AS Total
FROM CUSTOMERS3
GROUP BY 
   CASE 
      WHEN SALARY <= 4000 THEN 'Lowest paid'
      WHEN SALARY > 4000 AND SALARY <= 6500 THEN 'Average paid'
      ELSE 'Highest paid'
   END;


SELECT 
   NAME,
   SALARY,
   CASE 
      WHEN SALARY <= 4000 THEN 'Lowest paid'
      WHEN SALARY > 4000 AND SALARY <= 6500 THEN 'Average paid'
      ELSE 'Highest paid' 
   END AS SALARY_STATUS
FROM CUSTOMERS3;



-- 1). Simple CASE Expression-----------------------------------------------------------------------------------------------------------------------------------
-- This compares a column directly to specific values.

-- 🔧 Syntax:---------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CASE column_name
--    WHEN value1 THEN result1
--    WHEN value2 THEN result2
--    ELSE default_result
-- END

-- Example--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SELECT NAME, AGE,
--   CASE AGE
--      WHEN 22 THEN 'Fresh Graduate'
--      WHEN 25 THEN 'Mid-level'
--      ELSE 'Experienced'
--   END AS AGE_GROUP
-- FROM CUSTOMERS;
-- 🔍 How it works: It checks if AGE = 22, or AGE = 25, etc.


-- 2). Searched CASE Expression---------------------------------------------------------------------------------------------------------------------
-- This version lets you write full conditions, not just direct comparisons.

-- 🔧 Syntax------------------------------------------------------------------:
-- CASE 
--    WHEN condition1 THEN result1
--    WHEN condition2 THEN result2
--    ELSE default_result
-- END

-- Example:

SELECT NAME, SALARY,
  CASE 
     WHEN SALARY <= 4000 THEN 'Low'
     WHEN SALARY > 4000 AND SALARY <= 7000 THEN 'Medium'
     ELSE 'High'
  END AS SALARY_LEVEL
FROM CUSTOMERS;


-- 🔍 How it works: It allows complex logic, like ranges or comparisons between columns.

-- 🧠 Summary Table
-- Type of CASE	                                    Simple CASE	Searched CASE
-- Compares	                                        A column to values	Any condition (flexible logic)
-- Use when You have fixed values	                You need conditions/ranges
-- More readable for	                            Discrete values (e.g., status)	Salary bands, custom logic




