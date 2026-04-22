-- FIRST_VALUE() and LAST_VALUE() Window Functions in SQL
-- The FIRST_VALUE() and LAST_VALUE() window functions help you retrieve the first or last value from a result set within a partition of data.

-- 🔹 FIRST_VALUE() Function
-- The FIRST_VALUE() function returns the first value in an ordered partition of a result set.

-- Syntax

-- FIRST_VALUE(column_name) OVER (PARTITION BY column1 ORDER BY column2)

use pivot;

CREATE TABLE Sales (
    SalesID INT PRIMARY KEY,
    Employee VARCHAR(50),
    Region VARCHAR(20),
    SalesAmount INT
);

INSERT INTO Sales (SalesID, Employee, Region, SalesAmount) VALUES
(1, 'Alice', 'North', 5000),
(2, 'Bob', 'North', 3000),
(3, 'Charlie', 'North', 7000),
(4, 'David', 'South', 8000),
(5, 'Eve', 'South', 2000),
(6, 'Frank', 'South', 4000),
(7, 'Grace', 'North', 6500),
(8, 'Henry', 'North', 7200),
(9, 'Ivy', 'South', 9000),
(10, 'Jack', 'South', 5200),
(11, 'Kate', 'West', 7800),
(12, 'Leo', 'West', 6200),
(13, 'Mia', 'West', 8500),
(14, 'Nathan', 'East', 4800),
(15, 'Olivia', 'East', 5300),
(16, 'Paul', 'East', 6900),
(17, 'Quinn', 'East', 7500),
(18, 'Ryan', 'West', 9100),
(19, 'Sophia', 'North', 5800),
(20, 'Tom', 'South', 7700);

select * from sales;

SELECT Employee, Region, SalesAmount,
       FIRST_VALUE(SalesAmount) OVER (PARTITION BY Region ORDER BY SalesAmount desc) AS FirstSale
FROM Sales;

-- LAST_VALUE() Function the LAST_VALUE() function returns the last value in an ordered partition of a result set.

--  Syntax
-- LAST_VALUE(column_name) OVER (
--     PARTITION BY column1 
--     ORDER BY column2 
--     ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
-- )


-- Applying LAST_VALUE()
-- Get the last SalesAmount for each Region, ordered by SalesAmount:

SELECT Employee, Region, SalesAmount,
       LAST_VALUE(SalesAmount) OVER (
           PARTITION BY Region ORDER BY SalesAmount
           ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
       ) AS LastSale
FROM Sales;



-- For North: The highest SalesAmount is 7000, so it's repeated in the LastSale column.
-- For South: The highest SalesAmount is 8000, so it's repeated.

-- 🔹 Key Differences
-- Function	Returns	Ordering
-- FIRST_VALUE()	First value in the partition	Ascending Order (ORDER BY column ASC)
-- LAST_VALUE()	Last value in the partition	Descending Order (ORDER BY column DESC) (unless ROWS BETWEEN is used)

-- 🔹 When to Use?
-- Use FIRST_VALUE() when you need the minimum or first record within a partition.
-- Use LAST_VALUE() when you need the maximum or last record.

