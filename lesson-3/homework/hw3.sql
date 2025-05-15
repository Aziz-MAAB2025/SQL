--- Lesson_3 hw_3
--- 1.Define and explain the purpose of BULK INSERT in SQL Server.
--- BULK INSERT is a Transact-SQL (T-SQL) command in SQL Server that 
--- is used to quickly import large amounts of data from 
--- a data file (usually a text or CSV file) into a SQL Server table.
example
BULK INSERT Sales.dbo.Orders
FROM 'C:\Data\orders.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2)

--- 2. List four file formats that can be imported into SQL Server.
.csv, .txt, .xls, .xlsx, .xml, .json.

--- 3. Create a table Products with columns: 
ProductID (INT, PRIMARY KEY), 
ProductName (VARCHAR(50)), 
Price (DECIMAL(10,2)).

create table Products (ProductID INT PRIMARY KEY, 
ProductName VARCHAR(50),  
Price DECIMAL(10,2))

--- 4. Insert three records into the Products table using INSERT INTO.
INSERT INTO Products VALUES (1, 'Sugar', 5000), (2, 'Milk', 6000), (3, 'Coffee', 7000)
SELECT * FROM Products

--- 5. Explain the difference between NULL and NOT NULL.
--- NULL- Indicates that a column can store a null value, 
--- which represents the absence of data or an unknown value. 
--- It is not the same as zero, an empty string, or any specific value.

--- NOT NULL- Specifies that a column must always contain a valid, 
--- non-null value. You cannot insert or update a record without providing a value for this column, 
--- or the database will reject the operation.

--- 6. Add a UNIQUE constraint to the ProductName column in the Products table.
ALTER TABLE PRODUCTS
ADD CONSTRAINT unique_product_name UNIQUE (ProductName)
SELECT * FROM Products

--- 7.Write a comment in a SQL query explaining its purpose

- Explanation:
- The comment, -- Adds a UNIQUE constraint to the ProductName column to ensure no duplicate product names, is placed above the query.
- It clearly describes the query’s purpose: modifying the Products table to enforce uniqueness on the ProductName column.
- In SQL, comments starting with -- are single-line comments and are ignored by the database engine.

--- 8. Add CategoryID column to the Products table.
SELECT * FROM Products
ALTER TABLE PRODUCTS
ADD CategoryID INT

--- 9. Create a table Categories with a CategoryID as PRIMARY KEY and a CategoryName as UNIQUE.
CREATE TABLE categories (CategoryID INT PRIMARY KEY, CategoryName VARCHAR(100) UNIQUE)
SELECT * FROM categories

--- 10. Explain the purpose of the IDENTITY column in SQL Server.
--- In SQL Server, the IDENTITY property is used to create an auto-incrementing column that generates unique,
--- sequential values automatically when new rows are inserted into a table. 
--- It is commonly used for primary key columns to ensure each row has a unique identifier without requiring manual input.


--- 11. Use BULK INSERT to import data from a text file into the Products table.

BULK INSERT Products from 'customers.txt'
---
--- 12. Create a FOREIGN KEY in the Products table that references the Categories table
SELECT * FROM categories
SELECT * FROM Products
ALTER TABLE Products
ADD CONSTRAINT CategoryId FOREIGN

--- 13. Explain the differences between PRIMARY KEY and UNIQUE KEY.
--- PRIMARY KEY: Ensures that no two rows have the same value in the primary key column(s), 
--- and nulls are not allowed.

--- UNIQUE KEY: Also ensures uniqueness across rows, 
--- but allows one or more NULL values (depending on the database system).

--- 14. Add a CHECK constraint to the Products table ensuring Price > 0.
SELECT * FROM Products
ALTER TABLE Products
ADD CONSTRAINT chk_price_products CHECK (Price > 0)

--- 15. Modify the Products table to add a column Stock (INT, NOT NULL)
SELECT * FROM Products
ALTER TABLE Products
ADD Stock INT NOT NULL DEFAULT 0

--- 16. Use the ISNULL function to replace NULL values in Price column with a 0.
UPDATE Products
SET Price = 0
WHERE Price IS NULL

--- 17. Describe the purpose and usage of FOREIGN KEY constraints in SQL Server.
--A FOREIGN KEY constraint in SQL Server is used to enforce a relationship between two tables. 
--It ensures that the value in a column (or group of columns) in one table matches values in a column of another table,
--typically a PRIMARY KEY or UNIQUE column.

--- 18. Write a script to create a Customers table with a CHECK constraint ensuring Age >= 18.
DROP TABLE CUSTOMERS
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Age INT NOT NULL,
    CONSTRAINT chk_age CHECK (Age >= 18))
SELECT * FROM CUSTOMERS

--- 19. Create a table with an IDENTITY column starting at 100 and incrementing by 10.
CREATE TABLE UYLAR (
UY_RAQAMLARI INT IDENTITY(100,10) NOT NULL,
XONADON_EGASI VARCHAR(50),
YOSHI INT NOT NULL, CONSTRAINT CHK_YOSHI CHECK (YOSHI>=50))
SELECT * FROM UYLAR

INSERT INTO UYLAR (XONADON_EGASI, YOSHI) VALUES ('OLIM', 60), ('SALIM', 70), ('XALIM', 80)

--- 20. Write a query to create a composite PRIMARY KEY in a new table OrderDetails.
CREATE TABLE OrderDetails (
OrderID int,
ProductID int,
Quantity int,
UnitPrice decimal (10,2) not null,
constraint PK_OrderDetails PRIMARY KEY (OrderID, ProductID))
SELECT * FROM OrderDetails

--- 21. Explain the use of COALESCE and ISNULL functions for handling NULL values.
--1. ISNULL Function
--- Purpose - Replaces NULL with a specified replacement value.
--2. COALESCE Function
--- Purpose - Returns the first non-NULL value from a list of expressions.

--- 22. Create a table Employees with both PRIMARY KEY on EmpID and UNIQUE KEY on Email.
DROP TABLE EMPLOYEES
CREATE TABLE Employees (EmpID INT PRIMARY KEY, 
NAME VARCHAR (100) NOT NULL,
Email VARCHAR (100) UNIQUE)
SELECT * FROM Employees

--- 23. Write a query to create a FOREIGN KEY with ON DELETE CASCADE and ON UPDATE CASCADE options.
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    CONSTRAINT fk_customer
        FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID)
        ON DELETE CASCADE
        ON UPDATE CASCADE)
