create database lesson_17_hw_17
use lesson_17_hw_17

--1. You must provide a report of all distributors and their sales by region. 
--If a distributor did not have any sales for a region, rovide a zero-dollar value for that day. 
--Assume there is at least one sale for each region
DROP TABLE IF EXISTS #RegionSales;
GO
CREATE TABLE #RegionSales (
  Region      VARCHAR(100),
  Distributor VARCHAR(100),
  Sales       INTEGER NOT NULL,
  PRIMARY KEY (Region, Distributor)
);
GO
INSERT INTO #RegionSales (Region, Distributor, Sales) VALUES
('North','ACE',10), ('South','ACE',67), ('East','ACE',54),
('North','ACME',65), ('South','ACME',9), ('East','ACME',1), ('West','ACME',7),
('North','Direct Parts',8), ('South','Direct Parts',7), ('West','Direct Parts',12);
select * from #RegionSales

WITH AllRegions AS (
    SELECT DISTINCT Region FROM #RegionSales
),
AllDistributors AS (
    SELECT DISTINCT Distributor FROM #RegionSales
),
AllCombinations AS (
    SELECT 
        r.Region, 
        d.Distributor
    FROM AllRegions r
    CROSS JOIN AllDistributors d
)
SELECT 
    c.Region,
    c.Distributor,
    ISNULL(rs.Sales, 0) AS Sales
FROM AllCombinations c
LEFT JOIN #RegionSales rs
    ON rs.Region = c.Region AND rs.Distributor = c.Distributor
ORDER BY 
    c.Distributor, c.Region;


--2. Find managers with at least five direct reports
CREATE TABLE Employee (id INT, name VARCHAR(255), department VARCHAR(255), managerId INT);
TRUNCATE TABLE Employee;
INSERT INTO Employee VALUES
(101, 'John', 'A', NULL), (102, 'Dan', 'A', 101), (103, 'James', 'A', 101),
(104, 'Amy', 'A', 101), (105, 'Anne', 'A', 101), (106, 'Ron', 'B', 101);

select * from Employee
SELECT 
    e.managerId AS ManagerID,
    m.name AS ManagerName,
    COUNT(*) AS DirectReports
FROM Employee e
JOIN Employee m ON e.managerId = m.id
GROUP BY e.managerId, m.name
HAVING COUNT(*) >= 5;

--3. Write a solution to get the names of products that have at least 100 units ordered in February 2020 and their amount.
CREATE TABLE Products (product_id INT, product_name VARCHAR(40), product_category VARCHAR(40));
CREATE TABLE Orders (product_id INT, order_date DATE, unit INT);
TRUNCATE TABLE Products;
INSERT INTO Products VALUES
(1, 'Leetcode Solutions', 'Book'),
(2, 'Jewels of Stringology', 'Book'),
(3, 'HP', 'Laptop'), (4, 'Lenovo', 'Laptop'), (5, 'Leetcode Kit', 'T-shirt');
TRUNCATE TABLE Orders;
INSERT INTO Orders VALUES
(1,'2020-02-05',60),(1,'2020-02-10',70),
(2,'2020-01-18',30),(2,'2020-02-11',80),
(3,'2020-02-17',2),(3,'2020-02-24',3),
(4,'2020-03-01',20),(4,'2020-03-04',30),(4,'2020-03-04',60),
(5,'2020-02-25',50),(5,'2020-02-27',50),(5,'2020-03-01',50);
select * from Products
SELECT 
    p.product_name,
    SUM(o.unit) AS total_units
FROM Products p
JOIN Orders o ON p.product_id = o.product_id
WHERE o.order_date >= '2020-02-01' AND o.order_date < '2020-03-01'
GROUP BY p.product_name
HAVING SUM(o.unit) >= 100;

--4. Write an SQL statement that returns the vendor from which each customer has placed the most orders
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
  OrderID    INTEGER PRIMARY KEY,
  CustomerID INTEGER NOT NULL,
  [Count]    MONEY NOT NULL,
  Vendor     VARCHAR(100) NOT NULL
);
INSERT INTO Orders VALUES
(1,1001,12,'Direct Parts'), (2,1001,54,'Direct Parts'), (3,1001,32,'ACME'),
(4,2002,7,'ACME'), (5,2002,16,'ACME'), (6,2002,5,'Direct Parts');
select * from Orders
WITH VendorOrderCounts AS (
    SELECT 
        CustomerID,
        Vendor,
        COUNT(*) AS OrderCount,
        ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY COUNT(*) DESC, Vendor) AS rn
    FROM Orders
    GROUP BY CustomerID, Vendor
)
SELECT 
    CustomerID,
    Vendor,
    OrderCount
FROM VendorOrderCounts
WHERE rn = 1;

--5. You will be given a number as a variable called @Check_Prime check if this number is prime then return 
--- 'This number is prime' else eturn 'This number is not prime'
DECLARE @Check_Prime INT = 91;
-- Your WHILE-based SQL logic here
DECLARE @Check_Prime INT = 91;
DECLARE @i INT = 2;
DECLARE @IsPrime BIT = 1;

-- Handle numbers less than 2
IF @Check_Prime < 2
    SET @IsPrime = 0;
ELSE
BEGIN
    WHILE @i <= SQRT(@Check_Prime)
    BEGIN
        IF @Check_Prime % @i = 0
        BEGIN
            SET @IsPrime = 0;
            BREAK;
        END
        SET @i = @i + 1;
    END
END

-- Final result
IF @IsPrime = 1
    PRINT 'This number is prime';
ELSE
    PRINT 'This number is not prime';

---6. Write an SQL query to return the number of locations,
---in which location most signals sent, and total number of signal for each device from the given table.
CREATE TABLE Device(
  Device_id INT,
  Locations VARCHAR(25)
);
INSERT INTO Device VALUES
(12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'),
(12,'Hosur'), (12,'Hosur'),
(13,'Hyderabad'), (13,'Hyderabad'), (13,'Secunderabad'),
(13,'Secunderabad'), (13,'Secunderabad');
select * from Device
WITH DeviceCounts AS (
    SELECT 
        Device_id,
        Locations,
        COUNT(*) AS SignalCount,
        ROW_NUMBER() OVER (PARTITION BY Device_id ORDER BY COUNT(*) DESC, Locations) AS rn
    FROM Device
    GROUP BY Device_id, Locations
),
Summary AS (
    SELECT 
        Device_id,
        (SELECT COUNT(DISTINCT Locations) FROM Device d2 WHERE d2.Device_id = dc.Device_id) AS NumLocations,
        Locations AS TopLocation,
        (SELECT COUNT(*) FROM Device d3 WHERE d3.Device_id = dc.Device_id) AS TotalSignals
    FROM DeviceCounts dc
    WHERE rn = 1
)
SELECT * FROM Summary;

----7. Write a SQL to find all Employees who earn more than the average salary in their corresponding department. 
--Return EmpID, EmpName,Salary in your output
drop table if exists Employee
CREATE TABLE Employee (
  EmpID INT,
  EmpName VARCHAR(30),
  Salary FLOAT,
  DeptID INT
);
INSERT INTO Employee VALUES
(1001,'Mark',60000,2), (1002,'Antony',40000,2), (1003,'Andrew',15000,1),
(1004,'Peter',35000,1), (1005,'John',55000,1), (1006,'Albert',25000,3), (1007,'Donald',35000,3);
select * from Employee
SELECT 
    EmpID,
    EmpName,
    Salary
FROM Employee e
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employee
    WHERE DeptID = e.DeptID
);

--8. You are part of an office lottery pool where you keep a table of the winning lottery numbers 
--- along with a table of each ticket’s chosen numbers. 
--- If a ticket has some but not all the winning numbers, you win $10. 
--- If a ticket has all the winning numbers, you win $100. Calculate the total winnings for today’s drawing.
|Number|
--------
|  25  |
|  45  |
|  78  |

| Ticket ID | Number |
|-----------|--------|
| A23423    | 25     |
| A23423    | 45     |
| A23423    | 78     |
| B35643    | 25     |
| B35643    | 45     |
| B35643    | 98     |
| C98787    | 67     |
| C98787    | 86     |
| C98787    | 91     |

WITH MatchedNumbers AS (
    SELECT 
        t.TicketID,
        COUNT(*) AS MatchingCount
    FROM Tickets t
    JOIN WinningNumbers w ON t.Number = w.Number
    GROUP BY t.TicketID
),
Winnings AS (
    SELECT 
        TicketID,
        CASE 
            WHEN MatchingCount = 3 THEN 100
            WHEN MatchingCount IN (1, 2) THEN 10
            ELSE 0
        END AS Prize
    FROM (
        SELECT DISTINCT t.TicketID, 
            ISNULL(m.MatchingCount, 0) AS MatchingCount
        FROM Tickets t
        LEFT JOIN MatchedNumbers m ON t.TicketID = m.TicketID
    ) x
)
SELECT SUM(Prize) AS TotalWinnings
FROM Winnings;

---9. The Spending table keeps the logs of the spendings history of users that make purchases from an online shopping website which has a desktop and a mobile devices.
--Write an SQL query to find the total number of users and the total amount spent using mobile only, desktop only and both mobile and desktop together for each date.

CREATE TABLE Spending (
  User_id INT,
  Spend_date DATE,
  Platform VARCHAR(10),
  Amount INT
);
INSERT INTO Spending VALUES
(1,'2019-07-01','Mobile',100),
(1,'2019-07-01','Desktop',100),
(2,'2019-07-01','Mobile',100),
(2,'2019-07-02','Mobile',100),
(3,'2019-07-01','Desktop',100),
(3,'2019-07-02','Desktop',100);
select * from spending
WITH PlatformsPerUser AS (
  SELECT 
    Spend_date,
    User_id,
    MAX(CASE WHEN Platform = 'Mobile' THEN 1 ELSE 0 END) AS UsedMobile,
    MAX(CASE WHEN Platform = 'Desktop' THEN 1 ELSE 0 END) AS UsedDesktop
  FROM Spending
  GROUP BY Spend_date, User_id
),
UserGroups AS (
  SELECT 
    Spend_date,
    User_id,
    CASE 
      WHEN UsedMobile = 1 AND UsedDesktop = 1 THEN 'Both'
      WHEN UsedMobile = 1 THEN 'Mobile Only'
      WHEN UsedDesktop = 1 THEN 'Desktop Only'
    END AS UserGroup
  FROM PlatformsPerUser
),
SpendingPerUser AS (
  SELECT 
    Spend_date,
    User_id,
    SUM(Amount) AS TotalAmount
  FROM Spending
  GROUP BY Spend_date, User_id
)
SELECT 
  ug.Spend_date,
  ug.UserGroup,
  COUNT(*) AS TotalUsers,
  SUM(s.TotalAmount) AS TotalAmount
FROM UserGroups ug
JOIN SpendingPerUser s 
  ON ug.Spend_date = s.Spend_date AND ug.User_id = s.User_id
GROUP BY ug.Spend_date, ug.UserGroup
ORDER BY ug.Spend_date, ug.UserGroup;

--10. Write an SQL Statement to de-group the following data.

|Product  |Quantity|
--------------------
|Pencil   |   3    |
|Eraser   |   4    |
|Notebook |   2    |

|Product  |Quantity|
--------------------
|Pencil   |   1    |
|Pencil   |   1    |
|Pencil   |   1    |
|Eraser   |   1    |
|Eraser   |   1    |
|Eraser   |   1    |
|Eraser   |   1    |
|Notebook |   1    |
|Notebook |   1    |

DROP TABLE IF EXISTS Grouped;
CREATE TABLE Grouped
(
  Product  VARCHAR(100) PRIMARY KEY,
  Quantity INTEGER NOT NULL
);
INSERT INTO Grouped (Product, Quantity) VALUES
('Pencil', 3), ('Eraser', 4), ('Notebook', 2);

-- Numbers (Tally) table from 1 to 100 (adjust if needed)
WITH Numbers AS (
  SELECT TOP 100 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
  FROM sys.all_objects -- a large catalog view to quickly get numbers
),
Expanded AS (
  SELECT 
    g.Product,
    1 AS Quantity
  FROM Grouped g
  JOIN Numbers n ON n.n <= g.Quantity
)
SELECT * FROM Expanded
ORDER BY Product;
