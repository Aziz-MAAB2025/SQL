create database lesson_6_hw_6
use lesson_6_hw_6

--- 1. Puzzle 1: Finding Distinct Values
--Question: Explain at least two ways to find distinct values based on two columns.
create table InputTbl (col1 VARCHAR (10), col2 VARCHAR (10))
INSERT INTO InputTbl VALUES ('a', 'b'), ('b', 'a'), ('c', 'd'), ('c', 'd'), ('m', 'n')
SELECT * FROM InputTbl
SELECT DISTINCT
    CASE WHEN col1 < col2 THEN col1 ELSE col2 END AS val1,
    CASE WHEN col1 < col2 THEN col2 ELSE col1 END AS val2
FROM InputTbl

--- 2. Puzzle 2: Removing Rows with All Zeroes
--Question: If all the columns have zero values, then don’t show that row. 
--- In this case, we have to remove the 5th row while selecting data.
CREATE TABLE TestMultipleZero (
    A INT NULL,
    B INT NULL,
    C INT NULL,
    D INT NULL
);

INSERT INTO TestMultipleZero(A,B,C,D)
VALUES 
    (0,0,0,1),
    (0,0,1,0),
    (0,1,0,0),
    (1,0,0,0),
    (0,0,0,0),
    (1,1,1,0);
SELECT * FROM TestMultipleZero
SELECT *
FROM TestMultipleZero
WHERE NOT (ISNULL(A, 0) = 0 AND ISNULL(B, 0) = 0 AND ISNULL(C, 0) = 0 AND ISNULL(D, 0) = 0)
--- Puzzle 3: Find those with odd ids
create table section1(id int, name varchar(20))
insert into section1 values (1, 'Been'),
       (2, 'Roma'),
       (3, 'Steven'),
       (4, 'Paulo'),
       (5, 'Genryh'),
       (6, 'Bruno'),
       (7, 'Fred'),
       (8, 'Andro')
SELECT * FROM section1
SELECT *
FROM section1
WHERE id % 2 = 1;
-- WHERE id % 2 = 1 - ID ni 2 ga bo'lganda qoldiq 1 chiqsin

--- Puzzle 4: Person with the smallest id (use the table in puzzle 3)

SELECT TOP 1 *
FROM section1
ORDER BY id ASC;

--- Puzzle 5: Person with the highest id (use the table in puzzle 3)
SELECT TOP 1 *
FROM section1
ORDER BY id DESC;

--- Puzzle 6: People whose name starts with b (use the table in puzzle 3)
SELECT *
FROM section1
WHERE name LIKE 'B%'

--- Puzle 7: Write a query to return only the rows where the code contains the literal underscore _ (not as a wildcard).
CREATE TABLE ProductCodes (
    Code VARCHAR(20)
);

INSERT INTO ProductCodes (Code) VALUES
('X-123'),
('X_456'),
('X#789'),
('X-001'),
('X%202'),
('X_ABC'),
('X#DEF'),
('X-999');
SELECT * FROM ProductCodes

SELECT *
FROM ProductCodes
WHERE Code LIKE '%\_%' ESCAPE '\';
