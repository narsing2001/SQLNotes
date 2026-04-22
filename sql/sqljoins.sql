create database self_;
use self_;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(255) NOT NULL
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Customers (CustomerID, CustomerName) VALUES
(1, 'Alice Johnson'),
(2, 'Bob Smith'),
(3, 'Charlie Brown'),
(4, 'Diana Prince');


INSERT INTO Orders (OrderID, CustomerID, OrderDate) VALUES
(101, 1, '2025-01-01'),
(102, 2, '2025-01-02'),
(103, 3, '2025-01-03'),
(104, 1, '2025-01-04'),
(105, 4, '2025-01-05'),
(106, 2, '2025-01-06');


SELECT Orders.OrderID, Customers.CustomerName, Orders.OrderDate
FROM Orders INNER JOIN Customers
ON Orders.CustomerID = Customers.CustomerID;

CREATE TABLE Customers1 (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(255) NOT NULL,
    City VARCHAR(255) NOT NULL
);

INSERT INTO Customers1 (CustomerID, CustomerName, City) VALUES
(1, 'Alice Johnson', 'New York'),
(2, 'Bob Smith', 'New York'),
(3, 'Charlie Brown', 'Los Angeles'),
(4, 'Diana Prince', 'Los Angeles'),
(5, 'Eve Adams', 'Chicago'),
(6, 'Frank Miller', 'Chicago'),
(7, 'Grace Lee', 'San Francisco'),
(8, 'Henry King', 'San Francisco'),
(9, 'Ivy Turner', 'Boston'),
(10, 'Jack White', 'Boston'),
(11, 'Karen Davis', 'New York'),
(12, 'Larry Clark', 'Los Angeles'),
(13, 'Mona Gray', 'Chicago'),
(14, 'Nancy Green', 'San Francisco'),
(15, 'Oscar Black', 'San Francisco'),
(16, 'Peter Grey', 'Boston'),
(17, 'Quincy Blue', 'New York'),
(18, 'Rita Hill', 'Los Angeles'),
(19, 'Steve White', 'Chicago'),
(20, 'Tina Gold', 'San Francisco');

select * from Customers1;

SELECT A.CustomerName AS CustomerName1, B.CustomerName AS CustomerName2, A.City,A.CustomerID
FROM Customers1 A
INNER JOIN Customers1 B
ON A.City = B.City
WHERE A.CustomerID <> B.CustomerID
ORDER BY CustomerID;









