--- 1. Write a query to find the minimum (MIN) price of a product in the Products table.
SELECT * FROM Products
SELECT MIN(Price) FROM Products

--- 2. Write a query to find the maximum (MAX) Salary from the Employees table.
SELECT * FROM Employees
SELECT MAX(Salary) FROM Employees

--- 3. Write a query to count the number of rows in the Customers table.
SELECT COUNT(*) FROM Customers

--- 4. Write a query to count the number of unique product categories from the Products table.
SELECT * FROM Products
SELECT DISTINCT Category FROM Products
SELECT COUNT(DISTINCT Category) FROM Products

--- 5. Write a query to find the total sales amount for the product with id 7 in the Sales table.
SELECT * FROM Sales
SELECT SUM(SALEAMOUNT) AS TOTAL_AMOUNT FROM Sales

SELECT ProductID AS Product_ID, SUM(SALEAMOUNT) TOTAL_Product_ID FROM SALES
GROUP BY ProductID
HAVING ProductID = 7

--- 6. Write a query to calculate the average age of employees in the Employees table.
SELECT AVG(Age) FROM Employees

--- 7. Write a query to count the number of employees in each department.
SELECT * FROM Employees
SELECT DepartmentName, COUNT(*) AS employee_count
FROM Employees
GROUP BY DepartmentName

--- 8. Write a query to show the minimum and maximum Price of products grouped by Category. Use products table.
SELECT 
	CATEGORY, 
	MIN(Price) MIN_PRICE, 
	MAX(Price) MAX_PRICE 
FROM 
	Products
GROUP BY 
	Category

--- 9. Write a query to calculate the total sales per Customer in the Sales table.
SELECT * FROM Sales
SELECT 
	CustomerID,
	SUM(SaleAmount) AS TOTAL_SALEAMOUNT
FROM 
	Sales
GROUP BY
	CustomerID

--- 10. Write a query to filter departments having more than 5 employees from the Employees table.(DeptID is enough, 
--- if you don't have DeptName)
SELECT 
    DepartmentName
FROM 
    Employees
GROUP BY 
    DepartmentName
HAVING 
    COUNT(*) > 5;

--- 11. Write a query to calculate the total sales and average sales for each product category from the Sales table.
	select * from Sales
	select 
		ProductID,
		sum(SaleAmount) as total_sales,
		AVG(SaleAmount) as average_sales
	from 
		Sales
	group by 
		ProductID

--- 12. Write a query to count the number of employees from the Department HR.
SELECT COUNT(FirstName) AS TOTAL_NUMBER_OF_EMPLOYEES FROM Employees 

--- 13. Write a query that finds the highest and lowest Salary by department in the Employees table.
--- (DeptID is enough, if you don't have DeptName).
SELECT * FROM Employees
SELECT 
	DepartmentName, 
	MIN(Salary) MIN_Salary, 
	MAX(Salary) MAX_Salary 
FROM 
	Employees
GROUP BY 
	DepartmentName

--- 14. Write a query to calculate the average salary per Department.
--- (DeptID is enough, if you don't have DeptName).

SELECT 
	DepartmentName,  
	AVG(Salary) AVERAGE_Salary 
FROM 
	Employees
GROUP BY 
	DepartmentName

--- 15. Write a query to show the AVG salary and COUNT(*) of employees working in each department.
--- (DeptID is enough, if you don't have DeptName).
SELECT * FROM Employees
SELECT 
	DepartmentName,  
	AVG(Salary) AVERAGE_Salary,
	COUNT(*) NUMBER_OF_EMPLOYEES
FROM 
	Employees
GROUP BY 
	DepartmentName

--- 16. Write a query to filter product categories with an average price greater than 400.
SELECT * FROM Products
SELECT 
	Category,  
	AVG(Price) AVERAGE_PRICE
FROM 
	Products
GROUP BY 
	Category
HAVING
	AVG(Price) > 400

--- 17. Write a query that calculates the total sales for each year in the Sales table.
	SELECT * FROM Sales
	SELECT 
    YEAR(SaleDate) AS SaleYear,
    SUM(SaleAmount) AS TotalSales
FROM 
    Sales
GROUP BY 
    YEAR(SaleDate)
ORDER BY 
    SaleYear;

--- 18. Write a query to show the list of customers who placed at least 3 orders.
SELECT * FROM Orders
	SELECT 
    CustomerID,
    COUNT(*) AS OrderCount
FROM 
    Orders
GROUP BY 
    CustomerID
HAVING 
    COUNT(*) >= 3;

--- 19. Write a query to filter out Departments with average salary expenses greater than 60000.
--- (DeptID is enough, if you don't have DeptName).
SELECT 
	DepartmentName,  
	AVG(Salary) AVERAGE_Salary
FROM 
	Employees
GROUP BY 
	DepartmentName
HAVING
	AVG(Salary) > 60000

--- 20. Write a query that shows the average price for each product category, 
--- and then filter categories with an average price greater than 150.
SELECT * FROM Products
SELECT
	Category,
	AVG(Price)
FROM 
	Products
GROUP BY 
	Category
HAVING
	AVG(Price) >= 150

--- 21. Write a query to calculate the total sales for each Customer, 
--- then filter the results to include only Customers with total sales over 1500.
SELECT * FROM Sales
	SELECT
		CustomerID,
		SUM(SaleAmount) TOTAL_SALES
	FROM 
		Sales
	GROUP BY
		CustomerID
	HAVING
		SUM(SaleAmount)>1500

--- 22. Write a query to find the total and average salary of employees in each department, and 
--- filter the output to include only departments with an average salary greater than 65000.

SELECT * FROM Employees
	SELECT 
    DepartmentName,
    SUM(Salary) AS TotalSalary,
    AVG(Salary) AS AvgSalary
FROM 
    Employees
GROUP BY 
    DepartmentName
HAVING 
    AVG(Salary) > 65000;

/*
23. Write a query to find total amount for the orders which weights more than $50 for each customer 
along with their least purchases.
(least amount might be lower than 50, use tsql2012.sales.orders table,freight col, 
ask ur assistant to give the TSQL2012 database).
*/

SELECT custid,SUM(IIF(freight > 50, FREIGHT, 0)) TOTAL_AMT_OVER_50,MIN(FREIGHT) AS MIN_AMOUNT FROM tsql2012.sales.orders
GROUP BY custid

SELECT custid,SUM(CASE WHEN freight > 50 THEN freight ELSE 0 END) TOTAL_AMT_OVER_50,MIN(FREIGHT) AS MIN_AMOUNT FROM tsql2012.sales.orders
GROUP BY custid

SELECT custid,CASE WHEN freight > 50 THEN freight ELSE 0 END AS AMOUNT_TO_SUM, freight
FROM TSQL2012.Sales.Orders
ORDER BY custid

--- 24. Write a query that calculates the total sales and counts unique products sold in each month of each year, 
---- and then filter the months with at least 2 products sold.(Orders)
SELECT *,YEAR(OrderDate) AS YEAR_NUM,MONTH(OrderDate) AS MONTH_NUM, DAY(ORDERDATE) FROM Orders
ORDER BY MONTH_NUM


SELECT YEAR(OrderDate) SALES_YEAR,MONTH(OrderDate) AS SALES_MONTH, SUM(TOTALAMOUNT) AS TOTAL_AMOUNT,COUNT(DISTINCT PRODUCTID) AS UNIQUE_PRODUCTS FROM Orders
GROUP BY YEAR(OrderDate),MONTH(OrderDate)
HAVING COUNT(DISTINCT PRODUCTID)  >= 2

--- 25. Write a query to find the MIN and MAX order quantity per Year. From orders table.
SELECT * FROM Orders

SELECT YEAR(ORDERDATE) SALES_YEAR, MIN(QUANTITY) MIN_QTY, MAX(QUANTITY) MAX_QTY
FROM Orders
GROUP BY YEAR(ORDERDATE)

