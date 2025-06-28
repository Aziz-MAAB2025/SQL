--create database lesson_20_hw_20
--use lesson_20_hw_20

CREATE TABLE #Sales (
    SaleID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    Quantity INT,
    Price DECIMAL(10,2),
    SaleDate DATE
);


INSERT INTO #Sales (CustomerName, Product, Quantity, Price, SaleDate) VALUES
('Alice', 'Laptop', 1, 1200.00, '2024-01-15'),
('Bob', 'Smartphone', 2, 800.00, '2024-02-10'),
('Charlie', 'Tablet', 1, 500.00, '2024-02-20'),
('David', 'Laptop', 1, 1300.00, '2024-03-05'),
('Eve', 'Smartphone', 3, 750.00, '2024-03-12'),
('Frank', 'Headphones', 2, 100.00, '2024-04-08'),
('Grace', 'Smartwatch', 1, 300.00, '2024-04-25'),
('Hannah', 'Tablet', 2, 480.00, '2024-05-05'),
('Isaac', 'Laptop', 1, 1250.00, '2024-05-15'),
('Jack', 'Smartphone', 1, 820.00, '2024-06-01');

--1. Find customers who purchased at least one item in March 2024 using EXISTS
select * from #Sales

SELECT DISTINCT s.CustomerName
FROM #Sales s
WHERE EXISTS (
    SELECT 1
    FROM #Sales sub
    WHERE sub.CustomerName = s.CustomerName
      AND sub.SaleDate >= '2024-03-01'
      AND sub.SaleDate < '2024-04-01'
);

--2. Find the product with the highest total sales revenue using a subquery.
SELECT Product, TotalRevenue
FROM (
    SELECT 
        Product,
        SUM(Quantity * Price) AS TotalRevenue
    FROM #Sales
    GROUP BY Product
) AS ProductRevenue
WHERE TotalRevenue = (
    SELECT MAX(SUM(Quantity * Price))
    FROM #Sales
    GROUP BY Product
);

--3. Find the second highest sale amount using a subquery

SELECT MAX(SaleAmount) AS SecondHighestSaleAmount
FROM (
    SELECT Quantity * Price AS SaleAmount
    FROM #Sales
) AS SaleAmounts
WHERE SaleAmount < (
    SELECT MAX(Quantity * Price)
    FROM #Sales
);


--4. Find the total quantity of products sold per month using a subquery
SELECT 
    SaleMonth,
    SUM(TotalQuantity) AS TotalQuantitySold
FROM (
    SELECT 
        FORMAT(SaleDate, 'yyyy-MM') AS SaleMonth,
        Quantity AS TotalQuantity
    FROM #Sales
) AS MonthlySales
GROUP BY SaleMonth
ORDER BY SaleMonth;

--5. Find customers who bought same products as another customer using EXISTS
SELECT DISTINCT s1.CustomerName
FROM #Sales s1
WHERE EXISTS (
    SELECT 1
    FROM #Sales s2
    WHERE s1.Product = s2.Product
      AND s1.CustomerName <> s2.CustomerName
);

--6. Return how many fruits does each person have in individual fruit level
create table Fruits(Name varchar(50), Fruit varchar(50))
insert into Fruits values ('Francesko', 'Apple'), ('Francesko', 'Apple'), ('Francesko', 'Apple'), ('Francesko', 'Orange'),
							('Francesko', 'Banana'), ('Francesko', 'Orange'), ('Li', 'Apple'), 
							('Li', 'Orange'), ('Li', 'Apple'), ('Li', 'Banana'), ('Mario', 'Apple'), ('Mario', 'Apple'), 
							('Mario', 'Apple'), ('Mario', 'Banana'), ('Mario', 'Banana'), 
							('Mario', 'Orange')

SELECT 
    Name, 
    Fruit, 
    COUNT(*) AS Quantity
FROM Fruits
GROUP BY Name, Fruit
ORDER BY Name, Fruit;


--7. Return older people in the family with younger ones
create table Family(ParentId int, ChildID int)
insert into Family values (1, 2), (2, 3), (3, 4)
SELECT DISTINCT ParentId AS OlderPerson
FROM Family;

WITH FamilyTree AS (
    -- Base case: direct parent-child
    SELECT ParentId AS PID, ChildID AS CHID
    FROM Family

    UNION ALL

    -- Recursive step: find indirect descendants
    SELECT ft.PID, f.ChildID
    FROM FamilyTree ft
    JOIN Family f ON ft.CHID = f.ParentId
)
SELECT DISTINCT PID, CHID
FROM FamilyTree
ORDER BY PID, CHID;

--8. Write an SQL statement given the following requirements. 
--For every customer that had a delivery to California, 
--provide a result set of the customer orders that were delivered to Texas

CREATE TABLE #Orders
(
CustomerID     INTEGER,
OrderID        INTEGER,
DeliveryState  VARCHAR(100) NOT NULL,
Amount         MONEY NOT NULL,
PRIMARY KEY (CustomerID, OrderID)
);


INSERT INTO #Orders (CustomerID, OrderID, DeliveryState, Amount) VALUES
(1001,1,'CA',340),(1001,2,'TX',950),(1001,3,'TX',670),
(1001,4,'TX',860),(2002,5,'WA',320),(3003,6,'CA',650),
(3003,7,'CA',830),(4004,8,'TX',120);


SELECT *
FROM #Orders o
WHERE o.DeliveryState = 'TX'
  AND EXISTS (
      SELECT 1
      FROM #Orders o2
      WHERE o2.CustomerID = o.CustomerID
        AND o2.DeliveryState = 'CA'
  );

--9. Insert the names of residents if they are missing
create table #residents(resid int identity, fullname varchar(50), address varchar(100))

insert into #residents values 
('Dragan', 'city=Bratislava country=Slovakia name=Dragan age=45'),
('Diogo', 'city=Lisboa country=Portugal age=26'),
('Celine', 'city=Marseille country=France name=Celine age=21'),
('Theo', 'city=Milan country=Italy age=28'),
('Rajabboy', 'city=Tashkent country=Uzbekistan age=22')

UPDATE #residents
SET fullname = 
    LTRIM(RTRIM(
        SUBSTRING(address, 
            CHARINDEX('name=', address) + 5,
            CHARINDEX('age=', address) - CHARINDEX('name=', address) - 6
        )
    ))
WHERE fullname IS NULL OR fullname NOT IN (address);

--10. Write a query to return the route to reach from Tashkent to Khorezm. 
--The result should include the cheapest and the most expensive routes
CREATE TABLE #Routes
(
RouteID        INTEGER NOT NULL,
DepartureCity  VARCHAR(30) NOT NULL,
ArrivalCity    VARCHAR(30) NOT NULL,
Cost           MONEY NOT NULL,
PRIMARY KEY (DepartureCity, ArrivalCity)
);

INSERT INTO #Routes (RouteID, DepartureCity, ArrivalCity, Cost) VALUES
(1,'Tashkent','Samarkand',100),
(2,'Samarkand','Bukhoro',200),
(3,'Bukhoro','Khorezm',300),
(4,'Samarkand','Khorezm',400),
(5,'Tashkent','Jizzakh',100),
(6,'Jizzakh','Samarkand',50);
--Expected Output

--|             Route                                 |Cost |
--|Tashkent - Samarkand - Khorezm                     | 500 |
--|Tashkent - Jizzakh - Samarkand - Bukhoro - Khorezm | 650 |

WITH RoutePaths AS (
    -- Base case: start from Tashkent
    SELECT 
        CAST(DepartureCity + ' - ' + ArrivalCity AS VARCHAR(MAX)) AS Route,
        ArrivalCity,
        Cost
    FROM #Routes
    WHERE DepartureCity = 'Tashkent'

    UNION ALL

    -- Recursive case: continue chaining routes from the current ArrivalCity
    SELECT 
        CAST(rp.Route + ' - ' + r.ArrivalCity AS VARCHAR(MAX)),
        r.ArrivalCity,
        rp.Cost + r.Cost
    FROM RoutePaths rp
    JOIN #Routes r ON rp.ArrivalCity = r.DepartureCity
    WHERE rp.Route NOT LIKE '%' + r.ArrivalCity + '%' -- prevent cycles
)

-- Final selection: only complete routes ending in Khorezm
SELECT TOP 1 Route, Cost
FROM RoutePaths
WHERE ArrivalCity = 'Khorezm'
ORDER BY Cost ASC  -- Cheapest

UNION ALL

SELECT TOP 1 Route, Cost
FROM RoutePaths
WHERE ArrivalCity = 'Khorezm'
ORDER BY Cost DESC -- Most expensive;

--11. Rank products based on their order of insertion.
CREATE TABLE #RankingPuzzle
(
     ID INT
    ,Vals VARCHAR(10)
)

 
INSERT INTO #RankingPuzzle VALUES
(1,'Product'),
(2,'a'),
(3,'a'),
(4,'a'),
(5,'a'),
(6,'Product'),
(7,'b'),
(8,'b'),
(9,'Product'),
(10,'c')

WITH RankedProducts AS (
    SELECT *,
        SUM(CASE WHEN Vals = 'Product' THEN 1 ELSE 0 END) 
            OVER (ORDER BY ID ROWS UNBOUNDED PRECEDING) AS ProductRank
    FROM #RankingPuzzle
)
SELECT ID, Vals, ProductRank
FROM RankedProducts
ORDER BY ID;

--Question 12
--Find employees whose sales were higher than the average sales in their department

CREATE TABLE #EmployeeSales (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeName VARCHAR(100),
    Department VARCHAR(50),
    SalesAmount DECIMAL(10,2),
    SalesMonth INT,
    SalesYear INT
);

INSERT INTO #EmployeeSales (EmployeeName, Department, SalesAmount, SalesMonth, SalesYear) VALUES
('Alice', 'Electronics', 5000, 1, 2024),
('Bob', 'Electronics', 7000, 1, 2024),
('Charlie', 'Furniture', 3000, 1, 2024),
('David', 'Furniture', 4500, 1, 2024),
('Eve', 'Clothing', 6000, 1, 2024),
('Frank', 'Electronics', 8000, 2, 2024),
('Grace', 'Furniture', 3200, 2, 2024),
('Hannah', 'Clothing', 7200, 2, 2024),
('Isaac', 'Electronics', 9100, 3, 2024),
('Jack', 'Furniture', 5300, 3, 2024),
('Kevin', 'Clothing', 6800, 3, 2024),
('Laura', 'Electronics', 6500, 4, 2024),
('Mia', 'Furniture', 4000, 4, 2024),
('Nathan', 'Clothing', 7800, 4, 2024);

WITH DepartmentAvg AS (
    SELECT 
        Department,
        AVG(SalesAmount) AS AvgDeptSales
    FROM #EmployeeSales
    GROUP BY Department
)
SELECT 
    e.EmployeeID,
    e.EmployeeName,
    e.Department,
    e.SalesAmount,
    d.AvgDeptSales
FROM #EmployeeSales e
JOIN DepartmentAvg d ON e.Department = d.Department
WHERE e.SalesAmount > d.AvgDeptSales
ORDER BY e.Department, e.SalesAmount DESC;


--13. Find employees who had the highest sales in any given month using EXISTS
SELECT e.EmployeeID, e.EmployeeName, e.SalesMonth, e.SalesYear, e.SalesAmount
FROM #EmployeeSales e
WHERE EXISTS (
    SELECT 1
    FROM #EmployeeSales e2
    WHERE e2.SalesMonth = e.SalesMonth
      AND e2.SalesYear = e.SalesYear
    GROUP BY e2.SalesMonth, e2.SalesYear
    HAVING e.SalesAmount = MAX(e2.SalesAmount)
)
ORDER BY e.SalesYear, e.SalesMonth;

--14. Find employees who made sales in every month using NOT EXISTS
CREATE TABLE Products (
    ProductID   INT PRIMARY KEY,
    Name        VARCHAR(50),
    Category    VARCHAR(50),
    Price       DECIMAL(10,2),
    Stock       INT
);

INSERT INTO Products (ProductID, Name, Category, Price, Stock) VALUES
(1, 'Laptop', 'Electronics', 1200.00, 15),
(2, 'Smartphone', 'Electronics', 800.00, 30),
(3, 'Tablet', 'Electronics', 500.00, 25),
(4, 'Headphones', 'Accessories', 150.00, 50),
(5, 'Keyboard', 'Accessories', 100.00, 40),
(6, 'Monitor', 'Electronics', 300.00, 20),
(7, 'Mouse', 'Accessories', 50.00, 60),
(8, 'Chair', 'Furniture', 200.00, 10),
(9, 'Desk', 'Furniture', 400.00, 5),
(10, 'Printer', 'Office Supplies', 250.00, 12),
(11, 'Scanner', 'Office Supplies', 180.00, 8),
(12, 'Notebook', 'Stationery', 10.00, 100),
(13, 'Pen', 'Stationery', 2.00, 500),
(14, 'Backpack', 'Accessories', 80.00, 30),
(15, 'Lamp', 'Furniture', 60.00, 25);

SELECT DISTINCT e.EmployeeID, e.EmployeeName
FROM #EmployeeSales e
WHERE NOT EXISTS (
    SELECT 1
    FROM (
        SELECT DISTINCT SalesMonth
        FROM #EmployeeSales
    ) m
    WHERE NOT EXISTS (
        SELECT 1
        FROM #EmployeeSales es
        WHERE es.EmployeeID = e.EmployeeID
          AND es.SalesMonth = m.SalesMonth
    )
);

--15. Retrieve the names of products that are more expensive than the average price of all products.
SELECT Name, Price
FROM Products
WHERE Price > (
    SELECT AVG(Price)
    FROM Products
);

SELECT AVG(Price) FROM Products

--16. Find the products that have a stock count lower than the highest stock count.
SELECT ProductID, Name, Stock
FROM Products
WHERE Stock < (
    SELECT MAX(Stock)
    FROM Products
);

--17. Get the names of products that belong to the same category as 'Laptop'.
SELECT Name
FROM Products
WHERE Category = (
    SELECT Category
    FROM Products
    WHERE Name = 'Laptop'
);

--18. Retrieve products whose price is greater than the lowest price in the Electronics category.
SELECT ProductID, Name, Category, Price
FROM Products
WHERE Price > (
    SELECT MIN(Price)
    FROM Products
    WHERE Category = 'Electronics'
);

SELECT MIN(Price)
FROM Products
WHERE Category = 'Electronics'


--19. Find the products that have a higher price than the average price of their respective category.
CREATE TABLE Orders (
    OrderID    INT PRIMARY KEY,
    ProductID  INT,
    Quantity   INT,
    OrderDate  DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Orders (OrderID, ProductID, Quantity, OrderDate) VALUES
(1, 1, 2, '2024-03-01'),
(2, 3, 5, '2024-03-05'),
(3, 2, 3, '2024-03-07'),
(4, 5, 4, '2024-03-10'),
(5, 8, 1, '2024-03-12'),
(6, 10, 2, '2024-03-15'),
(7, 12, 10, '2024-03-18'),
(8, 7, 6, '2024-03-20'),
(9, 6, 2, '2024-03-22'),
(10, 4, 3, '2024-03-25'),
(11, 9, 2, '2024-03-28'),
(12, 11, 1, '2024-03-30'),
(13, 14, 4, '2024-04-02'),
(14, 15, 5, '2024-04-05'),
(15, 13, 20, '2024-04-08');


SELECT ProductID, Name, Category, Price
FROM Products p
WHERE Price > (
    SELECT AVG(Price)
    FROM Products
    WHERE Category = p.Category
);

--20. Find the products that have been ordered at least once.
SELECT DISTINCT p.ProductID, p.Name, p.Category, p.Price
FROM Products p
INNER JOIN Orders o ON p.ProductID = o.ProductID;

SELECT ProductID, Name, Category, Price
FROM Products p
WHERE EXISTS (
    SELECT 1
    FROM Orders o
    WHERE o.ProductID = p.ProductID
);


SELECT ProductID, Name, Category, Price
FROM Products
WHERE ProductID IN (
    SELECT DISTINCT ProductID
    FROM Orders
);


--21. Retrieve the names of products that have been ordered more than the average quantity ordered.
-- Step 1: Total quantity per product
WITH ProductOrderTotals AS (
    SELECT 
        p.ProductID,
        p.Name,
        SUM(o.Quantity) AS TotalOrdered
    FROM Products p
    JOIN Orders o ON p.ProductID = o.ProductID
    GROUP BY p.ProductID, p.Name
),

-- Step 2: Compute overall average ordered quantity
AverageQuantity AS (
    SELECT AVG(TotalOrdered * 1.0) AS AvgQuantity
    FROM ProductOrderTotals
)

-- Step 3: Filter products above average
SELECT pot.ProductID, pot.Name, pot.TotalOrdered
FROM ProductOrderTotals pot
CROSS JOIN AverageQuantity aq
WHERE pot.TotalOrdered > aq.AvgQuantity
ORDER BY pot.TotalOrdered DESC;

--22. Find the products that have never been ordered.

SELECT p.ProductID, p.Name, p.Category, p.Price
FROM Products p
LEFT JOIN Orders o ON p.ProductID = o.ProductID
WHERE o.ProductID IS NULL;

SELECT ProductID, Name, Category, Price
FROM Products p
WHERE NOT EXISTS (
    SELECT 1
    FROM Orders o
    WHERE o.ProductID = p.ProductID
);

SELECT ProductID, Name, Category, Price
FROM Products
WHERE ProductID NOT IN (
    SELECT ProductID
    FROM Orders
);


--23. Retrieve the product with the highest total quantity ordered.
SELECT TOP 1 p.ProductID, p.Name, SUM(o.Quantity) AS TotalOrdered
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.ProductID, p.Name
ORDER BY TotalOrdered DESC;

WITH ProductTotals AS (
    SELECT 
        p.ProductID,
        p.Name,
        SUM(o.Quantity) AS TotalOrdered,
        RANK() OVER (ORDER BY SUM(o.Quantity) DESC) AS rnk
    FROM Products p
    JOIN Orders o ON p.ProductID = o.ProductID
    GROUP BY p.ProductID, p.Name
)
SELECT ProductID, Name, TotalOrdered
FROM ProductTotals
WHERE rnk = 1;
