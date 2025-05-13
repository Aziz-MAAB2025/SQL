create database lesson_2
use lesson_2
---1.Create a table Employees with columns: EmpID INT, Name (VARCHAR(50)), and Salary (DECIMAL(10,2))
create table Employees (EmpID INT, Name VARCHAR(50), SALARY decimal(10,2))

select * from Employees
---2. Insert three records into the Employees table using different INSERT INTO approaches (single-row insert and multiple-row insert).
INSERT INTO Employees (EmpID, Name, SALARY) VALUES (1, 'jOHN', 5000000)
---3. Update the Salary of an employee to 7000 where EmpID = 1.
UPDATE Employees
SET SALARY=7000 WHERE EmpID='1'
DELETE FROM Employees WHERE EmpID=1

---4. Delete a record from the Employees table where EmpID = 2.
INSERT INTO Employees (EmpID, Name, SALARY) VALUES (2, 'SARAH', 8000)
select * from Employees
DELETE FROM Employees WHERE EmpID=2

---5. Give a brief definition for difference between DELETE, TRUNCATE, and DROP.
create table Employees (EmpID INT, Name VARCHAR(50), SALARY decimal(10,2))
select * from Employees
INSERT INTO Employees (EmpID, Name, SALARY) VALUES (2, 'SARAH', 8000)
DELETE FROM Employees WHERE Name='SARAH'
TRUNCATE TABLE EMPLOYEES
ALTER TABLE EMPLOYEES
DROP COLUMN SALARY

---6. Modify the Name column in the Employees table to VARCHAR(100)
create table Employees (EmpID INT, Name VARCHAR(50), SALARY decimal(10,2))
INSERT INTO Employees (EmpID, Name, SALARY) VALUES (2, 'SARAH', 8000)
SELECT * FROM Employees
ALTER TABLE EMPLOYEES
ALTER COLUMN NAME VARCHAR (100)
SELECT * FROM Employees

---7. Add a new column Department (VARCHAR(50)) to the Employees table.
ALTER TABLE EMPLOYEES
ADD DEPARTMENT VARCHAR(50)

---8. Change the data type of the Salary column to FLOAT.
ALTER TABLE EMPLOYEES
ALTER COLUMN SALARY FLOAT
SELECT * FROM Employees

--- 9. Create another table Departments with columns DepartmentID (INT, PRIMARY KEY) and DepartmentName (VARCHAR(50)).
DROP TABLE Departments
CREATE TABLE Departments (DepartmentID INT PRIMARY KEY, DepartmentName VARCHAR(50))
SELECT * FROM Departments

--- 10. Remove all records from the Employees table without deleting its structure.
ALTER TABLE Employees
SELECT * FROM Employees
TRUNCATE table employees

--- 11. Insert five records into the Departments table using INSERT INTO SELECT method(you can write anything you want as data).
SELECT * FROM Departments
ALTER TABLE Departments
ADD SALARY INT

INSERT INTO Departments (DepartmentID, DepartmentName, SALARY) VALUES (1, 'SARAH', 5000)
INSERT INTO Departments (DepartmentID, DepartmentName, SALARY) VALUES (2, 'JOHN', 6000)
INSERT INTO Departments (DepartmentID, DepartmentName, SALARY) VALUES (3, 'LARA', 7000)
INSERT INTO Departments (DepartmentID, DepartmentName, SALARY) VALUES (4, 'MICHIEL', 8000)
INSERT INTO Departments (DepartmentID, DepartmentName, SALARY) VALUES (5, 'TIMATI', 9000)

--- 12. Update the Department of all employees where Salary > 5000 to 'Management'.
UPDATE Departments
SET DepartmentName = 'Management'
WHERE Salary > 5000
SELECT * FROM Departments

--- 13. Write a query that removes all employees but keeps the table structure intact.
TRUNCATE TABLE DEPARTMENTS 

--- 14. Drop the Department column from the Employees table.
ALTER TABLE EMPLOYEES
DROP COLUMN DEPARTMENT

--- 15. Rename the Employees table to StaffMembers using SQL commands.
SELECT * FROM EMPLOYEES
sp_rename 'EMPLOYEES', 'StaffMembers'
SELECT * FROM StaffMembers

--- 16. Write a query to completely remove the Departments table from the database.
SELECT * FROM Departments
drop table Departments

--- 17. Create a table named Products with at least 5 columns, including: ProductID (Primary Key), ProductName (VARCHAR), Category (VARCHAR), Price (DECIMAL)
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    Price DECIMAL(10, 2))
	SELECT * FROM Products

--- 18. Add a CHECK constraint to ensure Price is always greater than 0.

ALTER TABLE PRODUCTS
ADD CONSTRAINT price CHECK (Price > 0)
SELECT * FROM Products

---19. Modify the table to add a StockQuantity column with a DEFAULT value of 50.
ALTER TABLE Products
ADD StockQuantity INT DEFAULT 50
SELECT * FROM Products

---20. Rename Category to ProductCategory
SELECT * FROM Products
ALTER TABLE Products
CHANGE COLUMN Category ProductCategory VARCHAR(50)

---21. Insert 5 records into the Products table using standard INSERT INTO queries.
SELECT * FROM Products
INSERT INTO Products (ProductID, ProductName, category, Price, StockQuantity)
VALUES
(1, 'Laptop', 'Electronics', 799.99, 50),
(2, 'Smartphone', 'Electronics', 599.99, 50),
(3, 'Headphones', 'Accessories', 149.99, 50),
(4, 'Coffee Maker', 'Home Appliances', 89.99, 50),
(5, 'Desk Chair', 'Furniture', 129.99, 50)
SELECT * FROM Products

--- 22. Use SELECT INTO to create a backup table called Products_Backup containing all Products data.
SELECT *
INTO Products_Backup
FROM Products
SELECT * FROM Products_Backup

--- 23. Rename the Products table to Inventory
SELECT * FROM PRODUCTS
sp_rename 'PRODUCTS', 'Inventory'
SELECT * FROM Inventory

--- 24. Alter the Inventory table to change the data type of Price from DECIMAL(10,2) to FLOAT.
SELECT * FROM Inventory
ALTER TABLE Inventory
ALTER COLUMN Price FLOAT

---25. Add an IDENTITY column named ProductCode that starts from 1000 and increments by 5 to Inventory table.
SELECT * FROM Inventory
ALTER TABLE Inventory
ADD ProductCode INT IDENTITY(1000, 5)
