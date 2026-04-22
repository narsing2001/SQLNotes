create database notes;
use notes;

-- MySQL DATE Data Type
-- -------------------------
-- MySQL DATE Data Type stores date values in the format ‘YYYY-MM-DD‘ and has a valid range of values from ‘1000-01-01‘ to ‘9999-12-31‘.
-- DATE Data Type in MySQL
-- The Data data type in MySQL is used to store date values in a column. During later data analysis, it is necessary to perform date-time operations on the data.
-- Dates are displayed in the format ‘YYYY-MM-DD’, but can be inserted using either strings or numbers. If any invalid date is inserted, MySQL will store ‘0000-00-00’ by default.

-- Syntax
-- DATE Data Type Syntax is:
-- Variable_Name DATE
-- Creating a table with DATE Data Type Column Example

CREATE TABLE StudentDetails (
   Student_Id INT AUTO_INCREMENT,       
   First_name VARCHAR (100) NOT NULL,       
   Last_name VARCHAR (100) NOT NULL,      
   Date_Of_Birth DATE NOT NULL,       
   Class VARCHAR (10) NOT NULL,       
   Contact_Details BIGINT NOT NULL,      
   PRIMARY KEY(Student_Id )       
);


INSERT INTO     
StudentDetails(First_name , Last_name , Date_Of_Birth , Class, Contact_Details)    
VALUES 
('Amit', 'Jana', '2004-12-22', 'XI', 1234567890),    
('Manik', 'Aggarwal', '2006-07-04', 'IX', 1245678998),    
('Nitin', 'Das', '2005-03-14', 'X', 2245664909),    
('Priya', 'Pal', '2007-07-24', 'VIII', 3245642199),    
('Biswanath', 'Sharma', '2005-11-11', 'X', 2456789761),    
('Mani', 'Punia', '2006-01-20', 'IX', 3245675421),    
('Pritam', 'Patel', '2008-01-04', 'VII', 3453415421),    
('Sayak', 'Sharma', '2007-05-10', 'VIII' , 1214657890);

SELECT * FROM StudentDetails ;



-- Similary we can create another table ‘ProductDetails’

CREATE TABLE ProductDetails(
ProductId INT NOT NULL,
ProductName VARCHAR(20) NOT NULL,
Manufactured_On DATE NOT NULL,
PRIMARY KEY(ProductId)
);

INSERT INTO  
ProductDetails(ProductId, ProductName, Manufactured_On)
VALUES
(11001, 'ASUS X554L', CURRENT_DATE()) ;

SELECT  * FROM ProductDetails;

CREATE TABLE ProductDetails1 AS
SELECT *
FROM ProductDetails;

select * from ProductDetails1;




CREATE TABLE Employee (
   EmpId INTEGER PRIMARY KEY, 
   EmpName VARCHAR(225) NOT NULL,  
   Email VARCHAR(225) NOT NULL,   
   Address VARCHAR(225) NOT NULL,
   Age INT NOT NULL,
   Salary INT NOT NULL
);

INSERT INTO Employee (EmpId, EmpName, Email, Address, Age, Salary)
VALUES (1, 'Shubham', 'shubham@example.com', 'India', 23, 50000.00),
       (2, 'Aman', 'aman@example.com', 'Australia', 21, 45000.00),
       (3, 'Naveen', 'naveen@example.com', 'Sri Lanka', 24, 55000.00),
       (4, 'Aditya', 'aditya@example.com', 'Austria', 21, 42000.00),
       (5, 'Nishant Saluja', 'nishant@example.com', 'Spain', 22, 48000.00);
    
SELECT * FROM Employee ;

SELECT * FROM Employee  LIMIT 2;

SELECT * FROM Employee LIMIT 2 OFFSET 3;

CREATE TABLE Student_Information1 (
    ID INT PRIMARY KEY,
    Age INT,
    Student_Name VARCHAR(50),
    Sex VARCHAR(10)
);

-- Inserting sample records
INSERT INTO Student_Information1 (ID, Age, Student_Name, Sex)
VALUES (1, 22, 'Harry', 'Male');

INSERT INTO Student_Information1 (ID, Age, Student_Name, Sex)
VALUES (2, 23, 'Vishal', 'Male');

INSERT INTO Student_Information1 (ID, Age, Student_Name, Sex)
VALUES (3, 20, 'Snehal', 'Female');

INSERT INTO Student_Information1 (ID, Age, Student_Name, Sex)
VALUES (4, 25, 'Ram', 'Male');

INSERT INTO Student_Information1 (ID, Age, Student_Name, Sex)
VALUES (5, 24, 'Hina', 'Female');

select * from  Student_Information1;

SELECT id FROM Student_Information1
ORDER BY age DESC
LIMIT 3;

SELECT * FROM Student_Information1
WHERE age= (
        SELECT MAX(age)
        FROM Student_Information1
);


SELECT age FROM Student_Information1 as t1
WHERE NOT EXISTS(
    SELECT * FROM Student_Information1 as t2
    WHERE t2.age > t1.age
);


