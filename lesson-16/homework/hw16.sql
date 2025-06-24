--create database lesson_16_hw_16
--use lesson_16_hw_16

CREATE TABLE Numbers1(Number INT)

INSERT INTO Numbers1 VALUES (5),(9),(8),(6),(7)

CREATE TABLE FindSameCharacters
(
     Id INT
    ,Vals VARCHAR(10)
)
 
INSERT INTO FindSameCharacters VALUES
(1,'aa'),
(2,'cccc'),
(3,'abc'),
(4,'aabc'),
(5,NULL),
(6,'a'),
(7,'zzz'),
(8,'abc')



CREATE TABLE RemoveDuplicateIntsFromNames
(
      PawanName INT
    , Pawan_slug_name VARCHAR(1000)
)
 
 
INSERT INTO RemoveDuplicateIntsFromNames VALUES
(1,  'PawanA-111'  ),
(2, 'PawanB-123'   ),
(3, 'PawanB-32'    ),
(4, 'PawanC-4444' ),
(5, 'PawanD-3'  )





CREATE TABLE Example
(
Id       INTEGER IDENTITY(1,1) PRIMARY KEY,
String VARCHAR(30) NOT NULL
);


INSERT INTO Example VALUES('123456789'),('abcdefghi');


CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    DepartmentID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Salary DECIMAL(10, 2)
);

INSERT INTO Employees (EmployeeID, DepartmentID, FirstName, LastName, Salary) VALUES
(1, 1, 'John', 'Doe', 60000.00),
(2, 1, 'Jane', 'Smith', 65000.00),
(3, 2, 'James', 'Brown', 70000.00),
(4, 3, 'Mary', 'Johnson', 75000.00),
(5, 4, 'Linda', 'Williams', 80000.00),
(6, 2, 'Michael', 'Jones', 85000.00),
(7, 1, 'Robert', 'Miller', 55000.00),
(8, 3, 'Patricia', 'Davis', 72000.00),
(9, 4, 'Jennifer', 'García', 77000.00),
(10, 1, 'William', 'Martínez', 69000.00);

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'HR'),
(2, 'Sales'),
(3, 'Marketing'),
(4, 'Finance'),
(5, 'IT'),
(6, 'Operations'),
(7, 'Customer Service'),
(8, 'R&D'),
(9, 'Legal'),
(10, 'Logistics');

CREATE TABLE Sales (
    SalesID INT PRIMARY KEY,
    EmployeeID INT,
    ProductID INT,
    SalesAmount DECIMAL(10, 2),
    SaleDate DATE
);
INSERT INTO Sales (SalesID, EmployeeID, ProductID, SalesAmount, SaleDate) VALUES
-- January 2025
(1, 1, 1, 1550.00, '2025-01-02'),
(2, 2, 2, 2050.00, '2025-01-04'),
(3, 3, 3, 1250.00, '2025-01-06'),
(4, 4, 4, 1850.00, '2025-01-08'),
(5, 5, 5, 2250.00, '2025-01-10'),
(6, 6, 6, 1450.00, '2025-01-12'),
(7, 7, 1, 2550.00, '2025-01-14'),
(8, 8, 2, 1750.00, '2025-01-16'),
(9, 9, 3, 1650.00, '2025-01-18'),
(10, 10, 4, 1950.00, '2025-01-20'),
(11, 1, 5, 2150.00, '2025-02-01'),
(12, 2, 6, 1350.00, '2025-02-03'),
(13, 3, 1, 2050.00, '2025-02-05'),
(14, 4, 2, 1850.00, '2025-02-07'),
(15, 5, 3, 1550.00, '2025-02-09'),
(16, 6, 4, 2250.00, '2025-02-11'),
(17, 7, 5, 1750.00, '2025-02-13'),
(18, 8, 6, 1650.00, '2025-02-15'),
(19, 9, 1, 2550.00, '2025-02-17'),
(20, 10, 2, 1850.00, '2025-02-19'),
(21, 1, 3, 1450.00, '2025-03-02'),
(22, 2, 4, 1950.00, '2025-03-05'),
(23, 3, 5, 2150.00, '2025-03-08'),
(24, 4, 6, 1700.00, '2025-03-11'),
(25, 5, 1, 1600.00, '2025-03-14'),
(26, 6, 2, 2050.00, '2025-03-17'),
(27, 7, 3, 2250.00, '2025-03-20'),
(28, 8, 4, 1350.00, '2025-03-23'),
(29, 9, 5, 2550.00, '2025-03-26'),
(30, 10, 6, 1850.00, '2025-03-29'),
(31, 1, 1, 2150.00, '2025-04-02'),
(32, 2, 2, 1750.00, '2025-04-05'),
(33, 3, 3, 1650.00, '2025-04-08'),
(34, 4, 4, 1950.00, '2025-04-11'),
(35, 5, 5, 2050.00, '2025-04-14'),
(36, 6, 6, 2250.00, '2025-04-17'),
(37, 7, 1, 2350.00, '2025-04-20'),
(38, 8, 2, 1800.00, '2025-04-23'),
(39, 9, 3, 1700.00, '2025-04-26'),
(40, 10, 4, 2000.00, '2025-04-29'),
(41, 1, 5, 2200.00, '2025-05-03'),
(42, 2, 6, 1650.00, '2025-05-07'),
(43, 3, 1, 2250.00, '2025-05-11'),
(44, 4, 2, 1800.00, '2025-05-15'),
(45, 5, 3, 1900.00, '2025-05-19'),
(46, 6, 4, 2000.00, '2025-05-23'),
(47, 7, 5, 2400.00, '2025-05-27'),
(48, 8, 6, 2450.00, '2025-05-31'),
(49, 9, 1, 2600.00, '2025-06-04'),
(50, 10, 2, 2050.00, '2025-06-08'),
(51, 1, 3, 1550.00, '2025-06-12'),
(52, 2, 4, 1850.00, '2025-06-16'),
(53, 3, 5, 1950.00, '2025-06-20'),
(54, 4, 6, 1900.00, '2025-06-24'),
(55, 5, 1, 2000.00, '2025-07-01'),
(56, 6, 2, 2100.00, '2025-07-05'),
(57, 7, 3, 2200.00, '2025-07-09'),
(58, 8, 4, 2300.00, '2025-07-13'),
(59, 9, 5, 2350.00, '2025-07-17'),
(60, 10, 6, 2450.00, '2025-08-01');

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    CategoryID INT,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2)
);

INSERT INTO Products (ProductID, CategoryID, ProductName, Price) VALUES
(1, 1, 'Laptop', 1000.00),
(2, 1, 'Smartphone', 800.00),
(3, 2, 'Tablet', 500.00),
(4, 2, 'Monitor', 300.00),
(5, 3, 'Headphones', 150.00),
(6, 3, 'Mouse', 25.00),
(7, 4, 'Keyboard', 50.00),
(8, 4, 'Speaker', 200.00),
(9, 5, 'Smartwatch', 250.00),
(10, 5, 'Camera', 700.00);

--- 1. Create a numbers table using a recursive query from 1 to 1000.

WITH numbers AS (
    SELECT 1 AS num
    UNION ALL
    SELECT num + 1 FROM numbers WHERE num < 1000
)
SELECT * FROM numbers
OPTION (MAXRECURSION 1000);


--- 2. Write a query to find the total sales per employee using a derived table.(Sales, Employees)
select * from employees
select * from Sales
SELECT e.employeeid, e.FirstName, s.total_sales
FROM Employees e
JOIN (
    SELECT employeeid, SUM(SalesAmount) AS total_sales
    FROM Sales
    GROUP BY employeeid
) s ON e.employeeid = s.employeeid;


--- 3. Create a CTE to find the average salary of employees.(Employees)
WITH AvgSalaryCTE AS (
    SELECT AVG(salary) AS avg_salary
    FROM Employees
)
SELECT avg_salary
FROM AvgSalaryCTE;

--- 4. Write a query using a derived table to find the highest sales for each product.(Sales, Products)
select * from Sales
select * from Products

SELECT p.productid, p.productname, s.max_sale
FROM Products p
JOIN (
    SELECT productid, MAX(SalesAmount) AS max_sale
    FROM Sales
    GROUP BY productid
) s ON p.productid = s.productid;

---5. Beginning at 1, write a statement to double the number for each record, 
--- the max value you get should be less than 1000000.


WITH doubled_numbers AS (
    SELECT 1 AS num
    UNION ALL
    SELECT num * 2
    FROM doubled_numbers
    WHERE num * 2 < 1000000
)
SELECT * FROM doubled_numbers
OPTION (MAXRECURSION 20);


---6. Use a CTE to get the names of employees who have made more than 5 sales.(Sales, Employees)
WITH SalesCount AS (
    SELECT employeeid, COUNT(*) AS sale_count
    FROM Sales
    GROUP BY employeeid
    HAVING COUNT(*) > 5
)
SELECT e.FirstName, sc.sale_count
FROM SalesCount sc
JOIN Employees e ON sc.employeeid = e.employeeid;

--- 7. Write a query using a CTE to find all products with sales greater than $500.(Sales, Products)
select * from sales
select * from Products
WITH ProductSales AS (
    SELECT productid, SUM(SalesAmount) AS total_sales
    FROM Sales
    GROUP BY ProductID
    HAVING SUM(SalesAmount) > 500
)
SELECT p.productid, p.productname, ps.total_sales
FROM ProductSales ps
JOIN Products p ON ps.productid = p.productid;


---8. Create a CTE to find employees with salaries above the average salary.(Employees)
select * from Employees
WITH AvgSalaryCTE AS (
    SELECT AVG(salary) AS avg_salary
    FROM Employees
)
SELECT e.EmployeeID, e.FirstName, e.salary
FROM Employees e
JOIN AvgSalaryCTE a ON e.salary > a.avg_salary;

--Medium Tasks
---1.  Write a query using a derived table to find the top 5 employees by the number of orders made.(Employees, Sales)
--SOLUTION:
select * from employees
select * from Sales

select EmployeeID, COUNT(*) from Sales
GROUP BY EmployeeID
 
SELECT TOP 5 * FROM Employees AS E JOIN (select EmployeeID, COUNT(*) AS CNT from Sales
GROUP BY EmployeeID) AS S ON E.EMPLOYEEID = S.EMPLOYEEID








select * from employees
select * from Sales
SELECT e.employeeid, e.FirstName, s.order_count
FROM (
    SELECT employeeid, COUNT(*) AS order_count
    FROM Sales
    GROUP BY employeeid
) s
JOIN Employees e ON e.employeeid = s.employeeid
ORDER BY s.order_count DESC
LIMIT 1;
---2. Write a query using a derived table to find the sales per product category.(Sales, Products)
select * from sales
select * from Products

SELECT p.categoryid, SUM(s.salesamount) AS total_sales
FROM (
    SELECT productid, SalesAmount
    FROM Sales
) s
JOIN Products p ON s.productid = p.productid
GROUP BY p.categoryid;

--- 3. Write a script to return the factorial of each value next to it.(Numbers1)
SELECT * FROM Numbers1
--- SOLUTION:
----FACTORIAL 5! = 1*2*3*4*5 = 120

 drop table if exists numbers1
 CREATE TABLE Numbers1(Number INT)

INSERT INTO Numbers1 VALUES (5),(9),(8),(6),(7)

;WITH CTE AS(
SELECT Number, Number AS MULTI, NUMBER AS SUM FROM Numbers1
UNION ALL
SELECT NUMBER,MULTI-1,  SUM*(MULTI-1)
FROM CTE WHERE MULTI -1  > 0
)
SELECT * FROM CTE
ORDER BY NUMBER,MULTI DESC

SELECT NUMBER,MAX(SUM) FROM CTE
GROUP BY Number


--- 4. This script uses recursion to split a string into rows of substrings for each character in the string.(Example)
SELECT * FROM Example
--- SOLUTION:
;WITH CTE AS(
SELECT *, SUBSTRING(STRING,1,1)AS EACH, 2 AS START FROM Example
UNION ALL
SELECT ID, STRING,SUBSTRING(STRING,START, 1), START + 1 FROM CTE WHERE LEN(STRING) >= START)

SELECT * FROM CTE
ORDER BY ID









---5. Use a CTE to calculate the sales difference between the current month and the previous month.(Sales)
SELECT * FROM Sales
--- SOLUTION:
WITH MonthlySales AS (
    SELECT
        DATEFROMPARTS(YEAR(SaleDate), MONTH(SaleDate), 1) AS MonthStart,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY YEAR(SaleDate), MONTH(SaleDate)
),
SalesWithDiff AS (
    SELECT
        MonthStart,
        TotalSales,
        LAG(TotalSales) OVER (ORDER BY MonthStart) AS PreviousMonthSales
    FROM MonthlySales
)
SELECT
    MonthStart,
    TotalSales,
    PreviousMonthSales,
    TotalSales - COALESCE(PreviousMonthSales, 0) AS SalesDifference
FROM SalesWithDiff
ORDER BY MonthStart;


---6. Create a derived table to find employees with sales over $45000 in each quarter.(Sales, Employees)
SELECT * FROM SALES
SELECT * FROM Employees
--- SOLUTIONS:
--1 variant
SELECT e.EmployeeID, e.FirstName
FROM Employees e
JOIN (
    SELECT
        EmployeeID,
        DATEPART(QUARTER, SaleDate) AS Quarter,
        YEAR(SaleDate) AS SaleYear,
        SUM(SalesAmount) AS QuarterlySales
    FROM Sales
    GROUP BY EmployeeID, YEAR(SaleDate), DATEPART(QUARTER, SaleDate)
) AS QuarterlyData
    ON e.EmployeeID = QuarterlyData.EmployeeID
GROUP BY e.EmployeeID, e.FirstName
HAVING COUNT(CASE WHEN QuarterlySales > 45000 THEN 1 END) = 4;

--2 variant
SELECT 
    e.EmployeeID,
    e.FirstName,
    q.Year,
    q.Quarter,
    q.TotalSales
FROM Employees e
JOIN (
    SELECT 
        s.EmployeeID,
        DATEPART(YEAR, s.SaleDate) AS Year,
        DATEPART(QUARTER, s.SaleDate) AS Quarter,
        SUM(s.SalesAmount) AS TotalSales
    FROM Sales s
    GROUP BY 
        s.EmployeeID,
        DATEPART(YEAR, s.SaleDate),
        DATEPART(QUARTER, s.SaleDate)
    HAVING SUM(s.SalesAmount) > 45000
) q ON e.EmployeeID = q.EmployeeID
ORDER BY e.EmployeeID, q.Year, q.Quarter;

--- Difficult Tasks
---1. This script uses recursion to calculate Fibonacci numbers
--- SOLUTIONS:
-- Set the number of Fibonacci terms you want
DECLARE @N INT = 20;

-- Recursive CTE to generate Fibonacci sequence
WITH FibonacciCTE (n, fib1, fib2) AS (
    -- Anchor member: first Fibonacci numbers
    SELECT 1 AS n, 0 AS fib1, 1 AS fib2
    UNION ALL
    -- Recursive member
    SELECT n + 1,
           fib2,
           fib1 + fib2
    FROM FibonacciCTE
    WHERE n < @N
)
SELECT 
    n,
    fib1 AS FibonacciNumber
FROM FibonacciCTE
ORDER BY n;


---2. Find a string where all characters are the same and the length is greater than 1.(FindSameCharacters)
SELECT * FROM FindSameCharacters
SELECT Vals
FROM FindSameCharacters
WHERE LEN(VALS) > 1
  AND Vals = REPEAT(SUBSTRING(VALS, 1, 1), LEN(VALS));


---3. Create a numbers table that shows all numbers 1 through n and their order gradually increasing by the next number in the sequence.
--- (Example:n=5 | 1, 12, 123, 1234, 12345)
---	SOLUTION:
-- Set max number
DECLARE @n INT = 5;

-- Recursive CTE
WITH NumbersCTE AS (
    -- Start with 1
    SELECT 1 AS num, CAST('1' AS VARCHAR(MAX)) AS sequence
    UNION ALL
    -- Build the next sequence
    SELECT num + 1, sequence + CAST(num + 1 AS VARCHAR)
    FROM NumbersCTE
    WHERE num + 1 <= @n
)
SELECT sequence
FROM NumbersCTE;


---4. Write a query using a derived table to find the employees who have made the most sales in the last 6 months.
--- (Employees,Sales)
--- SOLUTION:
SELECT 
    e.EmployeeID,
    e.FirstName,
    s.TotalSales
FROM Employees e
JOIN (
    SELECT 
        EmployeeID,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    WHERE SaleDate >= DATEADD(MONTH, -6, GETDATE())
    GROUP BY EmployeeID
) s ON e.EmployeeID = s.EmployeeID
WHERE s.TotalSales = (
    SELECT MAX(TotalSales)
    FROM (
        SELECT 
            EmployeeID,
            SUM(SalesAmount) AS TotalSales
        FROM Sales
        WHERE SaleDate >= DATEADD(MONTH, -6, GETDATE())
        GROUP BY EmployeeID
    ) x
);

---5. Write a T-SQL query to remove the duplicate integer values present in the string column. 
--- Additionally, remove the single integer character that appears in the string.(RemoveDuplicateIntsFromNames)
SELECT * FROM RemoveDuplicateIntsFromNames
WITH SplitNumbers AS (
    SELECT 
        PawanName,
        value AS NumberStr
    FROM RemoveDuplicateIntsFromNames
    CROSS APPLY STRING_SPLIT(PawanName, ' ')
), FilteredNumbers AS (
    SELECT 
        Name,
        NumberStr
    FROM SplitNumbers
    WHERE 
        LEN(NumberStr) > 1  -- Remove single-digit numbers
), Deduplicated AS (
    SELECT 
        Name,
        NumberStr,
        ROW_NUMBER() OVER (PARTITION BY Name, NumberStr ORDER BY (SELECT NULL)) AS rn
    FROM FilteredNumbers
)
SELECT 
    Name,
    STRING_AGG(NumberStr, ' ') AS CleanedName
FROM Deduplicated
WHERE rn = 1
GROUP BY Name;
