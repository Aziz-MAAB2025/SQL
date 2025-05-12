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
