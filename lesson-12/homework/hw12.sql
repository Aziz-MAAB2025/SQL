--create database lesson_12_hw_12
--use lesson_12_hw_12
---1. Write a solution to report the first name, last name, city, and state of each person in the Person table. 
---If the address of a personId is not present in the Address table, report null instead.

Create table Person (personId int, firstName varchar(255), lastName varchar(255))
Create table Address (addressId int, personId int, city varchar(255), state varchar(255))
Truncate table Person
insert into Person (personId, lastName, firstName) values ('1', 'Wang', 'Allen')
insert into Person (personId, lastName, firstName) values ('2', 'Alice', 'Bob')
Truncate table Address
insert into Address (addressId, personId, city, state) values ('1', '2', 'New York City', 'New York')
insert into Address (addressId, personId, city, state) values ('2', '3', 'Leetcode', 'California')

select * from Person
select * from Address
SELECT 
    p.firstName,
    p.lastName,
    a.city,
    a.state
FROM 
    Person p
LEFT JOIN 
    Address a ON p.personId = a.personId;

---2. Write a solution to find the employees who earn more than their managers.
Create table Employee (id int, name varchar(255), salary int, managerId int)
Truncate table Employee
insert into Employee (id, name, salary, managerId) values ('1', 'Joe', '70000', '3')
insert into Employee (id, name, salary, managerId) values ('2', 'Henry', '80000', '4')
insert into Employee (id, name, salary, managerId) values ('3', 'Sam', '60000', NULL)
insert into Employee (id, name, salary, managerId) values ('4', 'Max', '90000', NULL)
SELECT 
    e1.name AS Employee
FROM 
    Employee e1
INNER JOIN 
    Employee e2 ON e1.managerId = e2.id
WHERE 
    e1.salary > e2.salary;

---3. Write a solution to report all the duplicate emails. 
--- Note that it''s guaranteed that the email field is not NULL.
drop table if exists Person
Create table Person 
(id int, email varchar(255)) 
Truncate table Person 
insert into Person (id, email) values ('1', 'a@b.com') 
insert into Person (id, email) values ('2', 'c@d.com') 
insert into Person (id, email) values ('3', 'a@b.com')
select * from Person
SELECT 
    email
FROM 
    Person
GROUP BY 
    email
HAVING 
    COUNT(email) > 1;

---5.  Find those parents who has only girls.

CREATE TABLE boys (
    Id INT PRIMARY KEY,
    name VARCHAR(100),
    ParentName VARCHAR(100)
);

CREATE TABLE girls (
    Id INT PRIMARY KEY,
    name VARCHAR(100),
    ParentName VARCHAR(100)
);

INSERT INTO boys (Id, name, ParentName) 
VALUES 
(1, 'John', 'Michael'),  
(2, 'David', 'James'),   
(3, 'Alex', 'Robert'),   
(4, 'Luke', 'Michael'),  
(5, 'Ethan', 'David'),    
(6, 'Mason', 'George');  


INSERT INTO girls (Id, name, ParentName) 
VALUES 
(1, 'Emma', 'Mike'),  
(2, 'Olivia', 'James'),  
(3, 'Ava', 'Robert'),    
(4, 'Sophia', 'Mike'),  
(5, 'Mia', 'John'),      
(6, 'Isabella', 'Emily'),
(7, 'Charlotte', 'George');

select * from boys
select * from girls
SELECT DISTINCT g.ParentName
FROM girls g
WHERE NOT EXISTS (
    SELECT 1 
    FROM boys b 
    WHERE b.Id = g.id

--- 6.Find total Sales amount for the orders which weights more than 50 for each customer along with their least weight.
-----(from TSQL2012 database, Sales.Orders Table)
-----You can find tsql2012 database in here: https://gist.github.com/alejotima/cac70484db23834591b142ad07e79e67

 USE TSQL2012;

SELECT 
    o.custid,
    ISNULL(SUM(od.qty * od.unitprice), 0) AS TotalSalesAmount,
    MIN(o.freight) AS LeastWeight
FROM 
    Sales.Orders o
LEFT JOIN 
    Sales.OrderDetails od ON o.orderid = od.orderid
WHERE 
    o.freight > 50 OR o.freight IS NULL
GROUP BY 
    o.custid
HAVING 
    COUNT(o.orderid) > 0;

--- 7. You have the tables below, write a query to get the expected output
DROP TABLE IF EXISTS Cart1;
DROP TABLE IF EXISTS Cart2;
GO

CREATE TABLE Cart1
(
Item  VARCHAR(100) PRIMARY KEY
);
GO

CREATE TABLE Cart2
(
Item  VARCHAR(100) PRIMARY KEY
);
GO

INSERT INTO Cart1 (Item) VALUES
('Sugar'),('Bread'),('Juice'),('Soda'),('Flour');
GO

INSERT INTO Cart2 (Item) VALUES
('Sugar'),('Bread'),('Butter'),('Cheese'),('Fruit');
GO
SELECT * FROM Cart1
SELECT * FROM Cart2

SELECT c1.Item
FROM Cart1 c1
INNER JOIN Cart2 c2 ON c1.Item = c2.Item;

SELECT 
    c1.Item AS [Item Cart 1],
    c2.Item AS [Item Cart 2]
FROM 
    Cart1 c1
FULL OUTER JOIN 
    Cart2 c2 ON c1.Item = c2.Item
ORDER BY 
    COALESCE(isnull (c1.Item, ' '), isnull(c2.Item, ' '));

--- 8. Customers Who Never Order

Create table Customers (id int, name varchar(255))
Create table Orders (id int, customerId int)
Truncate table Customers
insert into Customers (id, name) values ('1', 'Joe')
insert into Customers (id, name) values ('2', 'Henry')
insert into Customers (id, name) values ('3', 'Sam')
insert into Customers (id, name) values ('4', 'Max')
Truncate table Orders
insert into Orders (id, customerId) values ('1', '3')
insert into Orders (id, customerId) values ('2', '1')

select * from Customers
select * from Orders

SELECT c.name AS Customers
FROM Customers c
LEFT JOIN Orders o ON c.id = o.customerId
WHERE o.customerId IS NULL;

--- 9. Students and Examinations
--Write a solution to find the number of times each student attended each exam.
--Return the result table ordered by student_id and subject_name.

Create table Students (student_id int, student_name varchar(20))
Create table Subjects (subject_name varchar(20))
Create table Examinations (student_id int, subject_name varchar(20))
Truncate table Students
insert into Students (student_id, student_name) values ('1', 'Alice')
insert into Students (student_id, student_name) values ('2', 'Bob')
insert into Students (student_id, student_name) values ('13', 'John')
insert into Students (student_id, student_name) values ('6', 'Alex')
Truncate table Subjects
insert into Subjects (subject_name) values ('Math')
insert into Subjects (subject_name) values ('Physics')
insert into Subjects (subject_name) values ('Programming')
Truncate table Examinations
insert into Examinations (student_id, subject_name) values ('1', 'Math')
insert into Examinations (student_id, subject_name) values ('1', 'Physics')
insert into Examinations (student_id, subject_name) values ('1', 'Programming')
insert into Examinations (student_id, subject_name) values ('2', 'Programming')
insert into Examinations (student_id, subject_name) values ('1', 'Physics')
insert into Examinations (student_id, subject_name) values ('1', 'Math')
insert into Examinations (student_id, subject_name) values ('13', 'Math')
insert into Examinations (student_id, subject_name) values ('13', 'Programming')
insert into Examinations (student_id, subject_name) values ('13', 'Physics')
insert into Examinations (student_id, subject_name) values ('2', 'Math')
insert into Examinations (student_id, subject_name) values ('1', 'Math')
select * from Students
select * from Subjects
select * from Examinations

SELECT
    s.student_id,
    s.student_name,
    sub.subject_name,
    COUNT(e.subject_name) AS attended_exams
FROM
    Students s
CROSS JOIN
    Subjects sub
LEFT JOIN
    Examinations e
    ON s.student_id = e.student_id AND sub.subject_name = e.subject_name
GROUP BY
    s.student_id,
    s.student_name,
    sub.subject_name
ORDER BY
    s.student_id,
    sub.subject_name;



