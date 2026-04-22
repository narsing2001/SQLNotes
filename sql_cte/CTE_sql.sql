create database view1;
use view1;

-- Creating the departments table
CREATE TABLE departments (
    department_id int PRIMARY KEY,
    department_name VARCHAR(50)
);

-- Creating the employees table
CREATE TABLE employees (
    employee_id int PRIMARY KEY,
    name VARCHAR(50),
    department_id int,
	FOREIGN KEY (department_id) REFERENCES departments(department_id)
	ON DELETE CASCADE 
    ON UPDATE CASCADE

);

-- Inserting 10 records into departments table
INSERT INTO departments (department_id, department_name) VALUES (1, 'Human Resources');
INSERT INTO departments (department_id, department_name) VALUES (2, 'Finance');
INSERT INTO departments (department_id, department_name) VALUES (3, 'IT');
INSERT INTO departments (department_id, department_name) VALUES (4, 'Marketing');
INSERT INTO departments (department_id, department_name) VALUES (5, 'Sales');
INSERT INTO departments (department_id, department_name) VALUES (6, 'Customer Support');
INSERT INTO departments (department_id, department_name) VALUES (7, 'Research and Development');
INSERT INTO departments (department_id, department_name) VALUES (8, 'Operations');
INSERT INTO departments (department_id, department_name) VALUES (9, 'Logistics');
INSERT INTO departments (department_id, department_name) VALUES (10, 'Legal');

select * from departments;

-- Inserting 10 records into employees table
INSERT INTO employees (employee_id, name, department_id) VALUES (101, 'Alice Johnson', 1);
INSERT INTO employees (employee_id, name, department_id) VALUES (102, 'Bob Smith', 2);
INSERT INTO employees (employee_id, name, department_id) VALUES (103, 'Charlie Brown', 3);
INSERT INTO employees (employee_id, name, department_id) VALUES (104, 'David Wilson', 4);
INSERT INTO employees (employee_id, name, department_id) VALUES (105, 'Eva Adams', 5);
INSERT INTO employees (employee_id, name, department_id) VALUES (106, 'Frank Miller', 6);
INSERT INTO employees (employee_id, name, department_id) VALUES (107, 'Grace Lee', 7);
INSERT INTO employees (employee_id, name, department_id) VALUES (108, 'Hannah Davis', 8);
INSERT INTO employees (employee_id, name, department_id) VALUES (109, 'Ian Moore', 9);
INSERT INTO employees (employee_id, name, department_id) VALUES (110, 'Julia Thompson', 10);


select * from employees;

CREATE VIEW employee_details AS
SELECT e.employee_id, e.name, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

select * from employee_details  ;

-- Delete a department
DELETE FROM departments WHERE department_id = 1;
-- Now 'Alice Johnson' (employee_id 101) will be automatically removed from the employees table

-- Update department_id
UPDATE departments SET department_id = 99 WHERE department_id = 2;
-- Now 'Bob Smith' (previously department_id 2) will have department_id updated to 99 in the employees table


-- CASCADE	Automatically apply the change to child table
-- SET NULL	Set the foreign key in child table to NULL
-- SET DEFAULT	(Not supported in MySQL) — sets foreign key to a default value
-- RESTRICT	Reject the operation if there’s a related record in the child table
-- NO ACTION	Like RESTRICT, but evaluated at the end of the statement (same as RESTRICT in MySQL) 



WITH RECURSIVE Numbers AS (
  SELECT 1 AS N
  UNION ALL
  SELECT N + 1 FROM Numbers WHERE N < 100
)
SELECT n FROM Numbers;

-- common table expression example:
--  Part 1: Common Table Expression (CTE) — Non-Recursive (6 Real-World Use Cases)
-- 1. Sales Analytics – Top N Products by Revenue

CREATE TABLE sales (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    sale_amount DECIMAL(10,2) NOT NULL,
    sale_date DATE
);

INSERT INTO sales (product_id, sale_amount, sale_date) VALUES
(101, 500.00, '2024-12-01'),
(101, 700.00, '2024-12-02'),
(102, 1200.00, '2024-12-01'),
(103, 300.00, '2024-12-02'),
(104, 1500.00, '2024-12-01'),
(105, 800.00, '2024-12-03'),
(101, 900.00, '2024-12-05'),
(102, 1100.00, '2024-12-06'),
(103, 500.00, '2024-12-07'),
(104, 1600.00, '2024-12-08'),
(105, 1000.00, '2024-12-09'),
(106, 700.00, '2024-12-10'),
(106, 600.00, '2024-12-11'),
(107, 300.00, '2024-12-12'),
(107, 400.00, '2024-12-13'),
(108, 1200.00, '2024-12-14'),
(108, 1000.00, '2024-12-15'),
(109, 900.00, '2024-12-16'),
(110, 850.00, '2024-12-17'),
(110, 950.00, '2024-12-18');

WITH product_sales AS (
  SELECT product_id, SUM(sale_amount) AS total_revenue
  FROM sales
  GROUP BY product_id
)
SELECT * FROM product_sales
ORDER BY total_revenue DESC
LIMIT 5;

select * from sales;

-- Step 1: Create employees Table-------------------------------------------------------------------------------------------------------------

CREATE TABLE employees1 (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    monthly_sales DECIMAL(12, 2)
);

-- 🔹 Step 2: Insert Sample Records
-- Here are 10 sample employees with varying sales figures:


INSERT INTO employees1 (employee_id, name, monthly_sales) VALUES
(1, 'Alice Johnson', 125000.00),
(2, 'Bob Smith', 98000.00),
(3, 'Charlie Brown', 134000.00),
(4, 'David Wilson', 88000.00),
(5, 'Eva Adams', 145000.00),
(6, 'Frank Miller', 75000.00),
(7, 'Grace Lee', 101000.00),
(8, 'Hannah Davis', 68000.00),
(9, 'Ian Moore', 109000.00),
(10, 'Julia Thompson', 99000.00);

-- Step 3: CTE Query – Filter Achievers

WITH achievers AS (
  SELECT employee_id, name, monthly_sales
  FROM employees1
  WHERE monthly_sales >= 100000
)
SELECT * FROM achievers;



-- 3. Customer Segmentation – High Value Customers--------------------------------------------------------------------------------------------

--  Step 1: Create orders Table

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_total DECIMAL(10, 2) NOT NULL,
    order_date DATE
);

INSERT INTO orders (customer_id, order_total, order_date) 
VALUES
(1, 10000.00, '2024-12-01'),
(1, 20000.00, '2024-12-02'),
(1, 25000.00, '2024-12-05'),
(2, 8000.00, '2024-12-01'),
(2, 7000.00, '2024-12-04'),
(3, 60000.00, '2024-12-01'),
(4, 10000.00, '2024-12-03'),
(4, 12000.00, '2024-12-06'),
(5, 30000.00, '2024-12-05'),
(5, 22000.00, '2024-12-07'),
(6, 15000.00, '2024-12-02'),
(6, 18000.00, '2024-12-05'),
(7, 40000.00, '2024-12-03'),
(8, 55000.00, '2024-12-08'),
(9, 19000.00, '2024-12-04'),
(10, 49000.00, '2024-12-10');

select * from orders;

WITH high_value_customers AS (
  SELECT customer_id, SUM(order_total) AS lifetime_value
  FROM orders
  GROUP BY customer_id
  HAVING SUM(order_total) > 50000
)
SELECT * FROM high_value_customers;


-- 4.Financial Reporting – Quarterly Sales Summary--------------------------------------------------------------------------------------------------------


CREATE TABLE sales1 (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    sale_date DATE NOT NULL,
    sale_amount DECIMAL(10,2) NOT NULL
);

INSERT INTO sales1 (sale_date, sale_amount) VALUES
-- Q1 2024
('2024-01-15', 10000.00),
('2024-02-10', 12000.00),
('2024-03-20', 15000.00),

-- Q2 2024
('2024-04-05', 18000.00),
('2024-05-14', 20000.00),
('2024-06-25', 22000.00),

-- Q3 2024
('2024-07-11', 25000.00),
('2024-08-19', 23000.00),
('2024-09-07', 21000.00),

-- Q4 2024
('2024-10-03', 26000.00),
('2024-11-28', 28000.00),
('2024-12-15', 30000.00),

-- Q1 2025
('2025-01-09', 27000.00),
('2025-02-17', 29000.00),
('2025-03-30', 31000.00);


WITH quarterly_summary AS (
  SELECT
    EXTRACT(YEAR FROM sale_date) AS year,
    QUARTER(sale_date) AS quarter,
    SUM(sale_amount) AS total_sales
  FROM sales1
  GROUP BY year, quarter
)
SELECT * FROM quarterly_summary;



-- 5. Data Cleaning – Remove Duplicates by RANK------------------------------------------------------------------------------------------------------------------------
-- Step 1: Create orders Table

CREATE TABLE orders1 (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    order_total DECIMAL(10,2)
);

-- Step 2: Insert Sample Data (with Duplicates)

INSERT INTO orders1 (customer_id, order_date, order_total) VALUES
(1, '2024-12-01', 1000.00),
(1, '2024-12-01', 1000.00),  -- duplicate
(2, '2024-12-02', 2000.00),
(2, '2024-12-02', 2000.00),  -- duplicate
(3, '2024-12-03', 1500.00),
(4, '2024-12-04', 1700.00),
(1, '2024-12-05', 1100.00),
(3, '2024-12-03', 1500.00),  -- duplicate
(5, '2024-12-05', 1800.00);


WITH ranked_orders AS (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY customer_id, order_date ORDER BY order_id) AS rn
  FROM orders1
)
DELETE FROM orders1 WHERE order_id IN (
  SELECT order_id FROM ranked_orders WHERE rn > 1
);
SELECT * FROM orders1;


-- Removes duplicate orders.
-- ROW_NUMBER() assigns a ranking within each customer_id + order_date group.
-- Any rn > 1 is a duplicate, and gets deleted.



-- Pagination6 – Fetch 10 Records at a Time-----------------------------------------------------------------------------------

-- Step 1: Create customers Table

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    email VARCHAR(100),
    city VARCHAR(50)
);

 -- Step 2: Insert Sample Customer Records (20+)

INSERT INTO customers (name, email, city) VALUES
('Alice Johnson', 'alice@gmail.com', 'New York'),
('Bob Smith', 'bob@gmail.com', 'Los Angeles'),
('Charlie Brown', 'charlie@gmail.com', 'Chicago'),
('David Wilson', 'david@gmail.com', 'Houston'),
('Eva Adams', 'eva@gmail.com', 'Phoenix'),
('Frank Miller', 'frank@gmail.com', 'Philadelphia'),
('Grace Lee', 'grace@gmail.com', 'San Antonio'),
('Hannah Davis', 'hannah@gmail.com', 'San Diego'),
('Ian Moore', 'ian@gmail.com', 'Dallas'),
('Julia Thompson', 'julia@gmail.com', 'San Jose'),
('Kevin Baker', 'kevin@gmail.com', 'Austin'),
('Laura King', 'laura@gmail.com', 'Jacksonville'),
('Michael Reed', 'michael@gmail.com', 'Fort Worth'),
('Nina Patel', 'nina@gmail.com', 'Columbus'),
('Oscar Stone', 'oscar@gmail.com', 'Charlotte'),
('Priya Kapoor', 'priya@gmail.com', 'San Francisco'),
('Quinn Howard', 'quinn@gmail.com', 'Indianapolis'),
('Rachel Green', 'rachel@gmail.com', 'Seattle'),
('Steve Nash', 'steve@gmail.com', 'Denver'),
('Tina Brooks', 'tina@gmail.com', 'Boston'),
('Umar Ali', 'umar@gmail.com', 'El Paso'),
('Vera Cruz', 'vera@gmail.com', 'Detroit');

WITH numbered_customers AS (
  SELECT *, ROW_NUMBER() OVER (ORDER BY name) AS rn
  FROM customers
)
SELECT * FROM numbered_customers
WHERE rn BETWEEN 11 AND 20;

-- Part 2: Recursive CTE — Hierarchical Queries (4 Real-World Use Cases)------------------------------------------------------------
-- 7. Organizational Hierarchy – Employee Manager Tree-----------------------------------------------------------------------------------------------

-- Step 1: Create the employees Table

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    manager_id INT,
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);

-- Step 2: Insert Sample Hierarchical Data
-- This structure includes a CEO (no manager), a few department heads, and team members:

INSERT INTO employees (employee_id, name, manager_id) VALUES
(1, 'Alice (CEO)', NULL),        -- Level 1

-- Direct reports to CEO
(2, 'Bob (CTO)', 1),             -- Level 2
(3, 'Charlie (CFO)', 1),
(4, 'Diana (COO)', 1),

-- Reports to CTO
(5, 'Evan (Dev Lead)', 2),       -- Level 3
(6, 'Fiona (QA Lead)', 2),

-- Reports to Dev Lead
(7, 'George (Developer)', 5),    -- Level 4
(8, 'Hannah (Developer)', 5),

-- Reports to QA Lead
(9, 'Ivy (QA Engineer)', 6),

-- Reports to COO
(10, 'Jack (Operations)', 4);



WITH RECURSIVE employee_hierarchy AS (
  SELECT employee_id, name, manager_id, 1 AS level
  FROM employees
  WHERE manager_id IS NULL

  UNION ALL

  SELECT e.employee_id, e.name, e.manager_id, eh.level + 1
  FROM employees e
  JOIN employee_hierarchy eh ON e.manager_id = eh.employee_id
)
SELECT * FROM employee_hierarchy;



-- 8. Bill of Materials (BOM) – Component Explosion-------------------------------------------------------------------------------------------------------

-- Step 1: Create the components Table

CREATE TABLE components (
    component_id INT PRIMARY KEY,
    part_name VARCHAR(100),
    parent_component_id INT,
    FOREIGN KEY (parent_component_id) REFERENCES components(component_id)
);

-- Step 2: Insert Sample Data (Product Breakdown)
-- Here’s an example of a product made up of assemblies and sub-components:

-- Root product
INSERT INTO components (component_id, part_name, parent_component_id) VALUES
(1, 'Bicycle', NULL),

-- Assemblies under Bicycle
(2, 'Frame', 1),
(3, 'Wheel Assembly', 1),
(4, 'Handlebar Assembly', 1),

-- Subcomponents of Frame
(5, 'Metal Tubes', 2),
(6, 'Welding Rods', 2),

-- Subcomponents of Wheel Assembly
(7, 'Wheel Rim', 3),
(8, 'Spokes', 3),
(9, 'Tube', 3),
(10, 'Tire', 3),

-- Subcomponents of Handlebar Assembly
(11, 'Handle Grip', 4),
(12, 'Brake Lever', 4);


WITH RECURSIVE bom AS (
  SELECT component_id, part_name, parent_component_id, 1 AS level
  FROM components
  WHERE parent_component_id IS NULL

  UNION ALL

  SELECT c.component_id, c.part_name, c.parent_component_id, b.level + 1
  FROM components c
  JOIN bom b ON c.parent_component_id = b.component_id
)
SELECT * FROM bom;



-- Step 1: Create folders Table

-- 9. Folder/File Structure – Nested Folders---------------------------------------------------------------------------------------------------------------------------

CREATE TABLE folders (
    folder_id INT PRIMARY KEY,
    folder_name VARCHAR(100),
    parent_id INT,
    FOREIGN KEY (parent_id) REFERENCES folders(folder_id)
);

-- Step 2: Insert Sample Folder Structure

INSERT INTO folders (folder_id, folder_name, parent_id) VALUES
(1, 'Root', NULL),

-- Level 2
(2, 'Documents', 1),
(3, 'Pictures', 1),
(4, 'Videos', 1),

-- Level 3 under Documents
(5, 'Work', 2),
(6, 'Personal', 2),

-- Level 3 under Pictures
(7, 'Vacations', 3),
(8, 'Events', 3),

-- Level 4 under Work
(9, 'Reports', 5),
(10, 'Presentations', 5),

-- Level 4 under Vacations
(11, '2023', 7),
(12, '2024', 7);

WITH RECURSIVE folder_structure AS (
  SELECT folder_id, folder_name, parent_id, 1 AS depth
  FROM folders
  WHERE parent_id IS NULL

  UNION ALL

  SELECT f.folder_id, f.folder_name, f.parent_id, fs.depth + 1
  FROM folders f
  JOIN folder_structure fs ON f.parent_id = fs.folder_id
)
SELECT * FROM folder_structure;


-- 10. Menu Navigation System – Multi-Level Menus-----------------------------------------------------------------------------------------------------------------------
 -- Step 1: Create menus Table

CREATE TABLE menus (
    menu_id INT PRIMARY KEY,
    menu_name VARCHAR(100),
    parent_menu_id INT,
    FOREIGN KEY (parent_menu_id) REFERENCES menus(menu_id)
);

 -- Step 2: Insert Sample Multi-Level Menu Data

INSERT INTO menus (menu_id, menu_name, parent_menu_id) VALUES
(1, 'Home', NULL),
(2, 'About Us', NULL),
(3, 'Services', NULL),
(4, 'Products', NULL),
(5, 'Contact', NULL),

-- Submenus under About Us
(6, 'Our Team', 2),
(7, 'Our History', 2),

-- Submenus under Services
(8, 'Consulting', 3),
(9, 'Development', 3),
(10, 'Support', 3),

-- Submenus under Products
(11, 'Software', 4),
(12, 'Hardware', 4),

-- Sub-submenus under Software
(13, 'CRM Tools', 11),
(14, 'ERP Solutions', 11);


WITH RECURSIVE menu_tree AS (
  SELECT menu_id, menu_name, parent_menu_id, 1 AS depth
  FROM menus
  WHERE parent_menu_id IS NULL

  UNION ALL

  SELECT m.menu_id, m.menu_name, m.parent_menu_id, mt.depth + 1
  FROM menus m
  JOIN menu_tree mt ON m.parent_menu_id = mt.menu_id
)
SELECT * FROM menu_tree;




