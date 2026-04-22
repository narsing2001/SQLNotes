create database trigger_db;
use trigger_db;

drop database trigger_db;

CREATE TABLE emp1 (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2)
);


INSERT INTO emp1 VALUES (103, 'Michael Scott', 70000);
INSERT INTO emp1 VALUES (104, 'Pam Beesly', 45000);
INSERT INTO emp1 VALUES (105, 'Jim Halpert', 65000);
INSERT INTO emp1 VALUES (106, 'Dwight Schrute', 68000);
INSERT INTO emp1 VALUES (107, 'Stanley Hudson', 62000);
INSERT INTO emp1 VALUES (108, 'Angela Martin', 50000);
INSERT INTO emp1 VALUES (109, 'Kevin Malone', 47000);
INSERT INTO emp1 VALUES (110, 'Oscar Martinez', 52000);
COMMIT;

CREATE TABLE salary_change_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT,
    old_salary DECIMAL(10,2),
    new_salary DECIMAL(10,2),
    change_date DATETIME
);


DELIMITER $$
CREATE TRIGGER trg_salary_column_update
BEFORE UPDATE ON emp1
FOR EACH ROW
BEGIN
    IF OLD.salary != NEW.salary THEN
        INSERT INTO salary_change_log (emp_id, old_salary, new_salary, change_date)
        VALUES (OLD.emp_id, OLD.salary, NEW.salary, NOW());
    END IF;
END;
$$ DELIMITER ;



select * from emp1;

select * from salary_change_log;

UPDATE emp1 SET salary = 72000 WHERE emp_id = 104;

COMMIT;
-- ======================================================================================================================================================================
-- example-1=insert triggers
-- Create Geeks table
CREATE TABLE Geeks (
    Id INT,
    Name VARCHAR(20),
    Score INT
);

-- Insert into Geeks Table 
INSERT INTO Geeks (Id, Name, Score) VALUES (1, 'Sam', 800);
INSERT INTO Geeks (Id, Name, Score) VALUES (2, 'Ram', 699);
INSERT INTO Geeks (Id, Name, Score) VALUES (3, 'Tom', 250);
INSERT INTO Geeks (Id, Name, Score) VALUES (4, 'Om', 350);
INSERT INTO Geeks (Id, Name, Score) VALUES (5, 'Jay', 750);
-- insert statement should be written for each entry in Oracle Sql Developer

 select * from Geeks;
 
CREATE TABLE Affect (
    Id INT,
    Name VARCHAR(20),
    Score INT
);

delimiter @@
-- BEFORE INSERT trigger
CREATE  TRIGGER BEFORE_INSERT
BEFORE INSERT ON Geeks
FOR EACH ROW
BEGIN
    INSERT INTO Affect (Id, Name, Score)
    VALUES (NEW.Id, NEW.Name, NEW.Score);
END;
@@ delimiter ;

INSERT INTO Geeks (Id, Name, Score) VALUES (6, 'Arjun', 500);

select * from Affect;


-- BEFORE DELETE Trigger----------------------------------------------------------------------------------------------------
delimiter $$
CREATE  TRIGGER BEFORE_DELETE
BEFORE DELETE ON Geeks
FOR EACH ROW
BEGIN
    INSERT INTO Affect (Id, Name, Score)
    VALUES (OLD.Id, OLD.Name, OLD.Score);
END;
 $$ delimiter ;

DELETE FROM Geeks WHERE Id = 3;


-- BEFORE UPDATE trigger-------------------------------------------------------------------------------------------------------
delimiter $$
CREATE  TRIGGER BEFORE_UPDATE
BEFORE UPDATE ON Geeks
FOR EACH ROW
BEGIN
    INSERT INTO Affect (Id, Name, Score)
    VALUES (OLD.Id, OLD.Name, OLD.Score);
END;
$$ delimiter ;

UPDATE Geeks SET Score = 900 WHERE Id = 5;
SELECT * FROM Affect; 
SELECT * FROM Geeks; 

-- BEFORE_INSERT Trigger is fired before adding a row in Geeks Table,and row is inserted in the Affect table.
-- BEFORE_DELETE Trigger is activated before the row is delete from the Geeks table and row which satisfy the condition is added to Affect table.
-- BEFORE_UPDATE TRIGGER is activated before the row with Id=5 is updated and row with old values is added to Affect table

