create database pivot;
use pivot

CREATE TABLE geeksforgeeks (
    CourseName VARCHAR(100),
    CourseCategory VARCHAR(50),
    Price INT
);


INSERT INTO geeksforgeeks (CourseName, CourseCategory, Price) VALUES
('Python Basics', 'PROGRAMMING', 5000),
('Java Masterclass', 'PROGRAMMING', 7000),
('DSA Course', 'INTERVIEWPREPARATION', 6000),
('SQL Bootcamp', 'PROGRAMMING', 4000),
('Aptitude Prep', 'INTERVIEWPREPARATION', 3000),
('System Design', 'INTERVIEWPREPARATION', 8000);

select * from geeksforgeeks ;

-- SELECT CourseName, PROGRAMMING, INTERVIEWPREPARATION
-- FROM geeksforgeeks 
-- PIVOT ( 
-- SUM(Price) 
-- FOR CourseCategory IN (PROGRAMMING, INTERVIEWPREPARATION ) 
-- ) AS PivotTable 

SELECT 
    CourseName,
    SUM(CASE WHEN CourseCategory = 'PROGRAMMING' THEN Price ELSE NULL END) AS PROGRAMMING,
    SUM(CASE WHEN CourseCategory = 'INTERVIEWPREPARATION' THEN Price ELSE NULL END) AS INTERVIEWPREPARATION
FROM geeksforgeeks
GROUP BY CourseName;



SELECT 
    CourseName,    
    -- Total price using SUM
 AVG(CASE WHEN CourseCategory = 'PROGRAMMING' THEN Price ELSE NULL END) AS Avg_Programming_Price,
 AVG(CASE WHEN CourseCategory = 'INTERVIEWPREPARATION' THEN Price ELSE NULL END) AS Avg_Interview_Prep_Price
FROM  geeksforgeeks
GROUP BY CourseName;




SELECT  CourseName,    
    -- Maximum price using MAX
    MAX(CASE WHEN CourseCategory = 'PROGRAMMING' THEN Price ELSE NULL END) AS Max_Programming_Price,
    MAX(CASE WHEN CourseCategory = 'INTERVIEWPREPARATION' THEN Price ELSE NULL END) AS Max_Interview_Prep_Price
FROM  geeksforgeeks
GROUP BY CourseName;



SELECT  CourseName,    
-- Minimum price using MIN
    MIN(CASE WHEN CourseCategory = 'PROGRAMMING' THEN Price ELSE NULL END) AS Min_Programming_Price,
    MIN(CASE WHEN CourseCategory = 'INTERVIEWPREPARATION' THEN Price ELSE NULL END) AS Min_Interview_Prep_Price
FROM  geeksforgeeks
GROUP BY CourseName;


SELECT  CourseName,    
-- Count of courses using COUNT
    COUNT(CASE WHEN CourseCategory = 'PROGRAMMING' THEN 1 ELSE NULL END) AS Count_Programming_Courses,
    COUNT(CASE WHEN CourseCategory = 'INTERVIEWPREPARATION' THEN 1 ELSE NULL END) AS Count_Interview_Prep_Courses
FROM  geeksforgeeks
GROUP BY CourseName;





SELECT 
    CourseName,    
    -- Total price using SUM
    SUM(CASE WHEN CourseCategory = 'PROGRAMMING' THEN Price ELSE 0 END) AS Total_Programming_Price,
    SUM(CASE WHEN CourseCategory = 'INTERVIEWPREPARATION' THEN Price ELSE 0 END) AS Total_Interview_Prep_Price,

    -- Average price using AVG
    
    AVG(CASE WHEN CourseCategory = 'PROGRAMMING' THEN Price ELSE NULL END) AS Avg_Programming_Price,
    AVG(CASE WHEN CourseCategory = 'INTERVIEWPREPARATION' THEN Price ELSE NULL END) AS Avg_Interview_Prep_Price,

    -- Maximum price using MAX
    MAX(CASE WHEN CourseCategory = 'PROGRAMMING' THEN Price ELSE NULL END) AS Max_Programming_Price,
    MAX(CASE WHEN CourseCategory = 'INTERVIEWPREPARATION' THEN Price ELSE NULL END) AS Max_Interview_Prep_Price,

    -- Minimum price using MIN
    MIN(CASE WHEN CourseCategory = 'PROGRAMMING' THEN Price ELSE NULL END) AS Min_Programming_Price,
    MIN(CASE WHEN CourseCategory = 'INTERVIEWPREPARATION' THEN Price ELSE NULL END) AS Min_Interview_Prep_Price,

    -- Count of courses using COUNT
    COUNT(CASE WHEN CourseCategory = 'PROGRAMMING' THEN 1 ELSE NULL END) AS Count_Programming_Courses,
    COUNT(CASE WHEN CourseCategory = 'INTERVIEWPREPARATION' THEN 1 ELSE NULL END) AS Count_Interview_Prep_Courses

FROM geeksforgeeks
GROUP BY CourseName;



INSERT INTO geeksforgeeks (CourseName, CourseCategory, Price) VALUES
('React JS Course', 'PROGRAMMING', 6500),
('Django Full Stack', 'PROGRAMMING', 7200),
('C++ for Beginners', 'PROGRAMMING', 3500),
('Node.js Backend', 'PROGRAMMING', 7800),

-- New Interview Preparation Courses
('Behavioral Interview Tips', 'INTERVIEWPREPARATION', 4500),
('Resume Writing Workshop', 'INTERVIEWPREPARATION', 3200),
('Mock Coding Interviews', 'INTERVIEWPREPARATION', 7000),
('Advanced DSA Problems', 'INTERVIEWPREPARATION', 9000),

-- New Data Science & Machine Learning Courses
('Data Science with Python', 'DATASCIENCE', 8500),
('Machine Learning A-Z', 'DATASCIENCE', 9200),
('Deep Learning with TensorFlow', 'DATASCIENCE', 10500),
('Big Data with Hadoop', 'DATASCIENCE', 8700),

-- New DevOps Courses
('Docker and Kubernetes', 'DEVOPS', 7800),
('AWS Cloud Practitioner', 'DEVOPS', 8200),
('CI/CD with Jenkins', 'DEVOPS', 7500),
('Terraform for Infrastructure', 'DEVOPS', 7900);

-- Unpivot Example--------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE StudentMarks_Pivot (
    Student VARCHAR(50),
    Math INT,
    Science INT,
    English INT
);
select * from StudentMarks_Pivot;

INSERT INTO StudentMarks_Pivot (Student, Math, Science, English) 
VALUES
('Alice', 85, 90, 88),
('Bob', 78, 88, 80),
('Charlie', 92, 95, 89),
('David', 75, 85, 82),
('Eve', 88, 91, 87),
('Frank', 79, 83, 81),
('Grace', 94, 97, 90),
('Hannah', 80, 89, 85),
('Isaac', 82, 84, 78),
('Jack', 90, 92, 88);


-- SELECT Student, Subject, Marks
-- FROM 
--     (SELECT Student, Math, Science, English FROM StudentMarks_Pivot) AS SourceTable
-- UNPIVOT 
--     (Marks FOR Subject IN (Math, Science, English)) 
-- AS UnpivotTable;



-- MySQL does not support UNPIVOT, but you can achieve the same result using UNION ALL:

SELECT Student, 'Math' AS Subject, Math AS Marks FROM StudentMarks_Pivot
UNION ALL
SELECT Student, 'Science' AS Subject, Science AS Marks FROM StudentMarks_Pivot
UNION ALL
SELECT Student, 'English' AS Subject, English AS Marks FROM StudentMarks_Pivot;



-- Variable	Type	Description
-- Student	Column	                    The student's name (taken directly from StudentMarks_Pivot)
-- Math	Column	                        Math marks for each student (from StudentMarks_Pivot)
-- Science	Column	                    Science marks for each student (from StudentMarks_Pivot)
-- English	Column	                    English marks for each student (from StudentMarks_Pivot)
-- 'Math'	Constant (String)	        A fixed value assigned as the Subject in the first SELECT
-- 'Science'	Constant (String)	    A fixed value assigned as the Subject in the second SELECT
-- 'English'	Constant (String)	    A fixed value assigned as the Subject in the third SELECT


-- 1)First SELECT Block:

-- SELECT Student, 'Math' AS Subject, Math AS Marks FROM StudentMarks_Pivot

-- Selects Student name
-- Assigns 'Math' as the Subject (a constant value)
-- Retrieves Math marks from StudentMarks_Pivot

-- ==================================================================================================================================

-- 2)Second SELECT Block (Using UNION ALL):

-- UNION ALL
-- SELECT Student, 'Science' AS Subject, Science AS Marks FROM StudentMarks_Pivot

-- Selects the same Student column
-- Assigns 'Science' as the Subject (a constant value)
-- Retrieves Science marks
-- =======================================================================================================================================
-- 3)Third SELECT Block (Using UNION ALL):

-- UNION ALL
-- SELECT Student, 'English' AS Subject, English AS Marks FROM StudentMarks_Pivot;

-- Again selects Student
-- Assigns 'English' as the Subject
-- Retrieves English marks

-- =============================================================================================================================================================
-- Fixed values ('Math', 'Science', 'English') are used to convert columns into rows.
-- Columns (Student, Math, Science, English) are used to fetch data from the table.
-- UNION ALL is used to combine the results into a single output.

-- ==========================================================================================================================================
-- unpivoted supported query in sql
-- ------------------------------------------------------------------------------------------------------------
-- SELECT Student, Subject, Marks
-- FROM 
--     (SELECT Student, Math, Science, English FROM StudentMarks_Pivot) AS SourceTable
--  UNPIVOT 
--     (Marks FOR Subject IN (Math, Science, English)) AS UnpivotTable;


CREATE TABLE CourseEarnings (
    Course VARCHAR(50),
    Year_2022 INT,
    Year_2023 INT,
    Year_2024 INT
);

INSERT INTO CourseEarnings (Course, Year_2022, Year_2023, Year_2024) VALUES
('Python Basics', 5000, 7000, 8500),
('Java Masterclass', 7000, 9500, 12000),
('Data Science', 8000, 11000, 13000),
('SQL Bootcamp', 4500, 6000, 7500),
('Web Development', 9000, 10500, 12500),
('AI & ML', 10000, 13000, 15000),
('Cyber Security', 7500, 9200, 11000),
('Cloud Computing', 8800, 10200, 11800),
('Blockchain Basics', 7200, 8500, 9800),
('Digital Marketing', 6800, 8200, 9400);


-- Step 3: Apply UNPIVOT (SQL Server)
-- To convert years from columns into rows, we apply UNPIVOT:
-- ========================================================

-- SELECT Course, Year, Earnings
-- FROM 
--     (SELECT Course, Year_2022, Year_2023, Year_2024 FROM CourseEarnings) AS SourceTable
-- UNPIVOT 
--     (Earnings FOR Year IN (Year_2022, Year_2023, Year_2024)) 
-- AS UnpivotTable;


SELECT * from CourseEarnings;

-- Step 3: Apply UNPIVOT (SQL Server)
-- To convert years from columns into rows, we apply UNPIVOT:
-- ==============================================================================================================================
-- To convert years from columns into rows, we apply UNPIVOT:

-- SELECT Course, Year, Earnings
-- FROM 
--     (SELECT Course, Year_2022, Year_2023, Year_2024 FROM CourseEarnings) AS SourceTable
-- UNPIVOT 
--     (Earnings FOR Year IN (Year_2022, Year_2023, Year_2024)) 
-- AS UnpivotTable;


-- =========================================================================================================

-- Alternative for MySQL (Since UNPIVOT is Not Supported)
-- If you're using MySQL, use UNION ALL:


SELECT course,'Year_2022' as Year,Year_2022 as Earning from CourseEarnings
UNION ALL
SELECT course,'Year_2023' as Year,Year_2023 as Earning from CourseEarnings
UNION All
SELECT course,'Year_2024' as Year,Year_2024 as Earning from CourseEarnings





