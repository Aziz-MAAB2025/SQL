--create database lesson_22_hw_22
--use lesson_22_hw_22
CREATE TABLE sales_data (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    customer_name VARCHAR(100),
    product_category VARCHAR(50),
    product_name VARCHAR(100),
    quantity_sold INT,
    unit_price DECIMAL(10,2),
    total_amount DECIMAL(10,2),
    order_date DATE,
    region VARCHAR(50)
);

INSERT INTO sales_data VALUES
    (1, 101, 'Alice', 'Electronics', 'Laptop', 1, 1200.00, 1200.00, '2024-01-01', 'North'),
    (2, 102, 'Bob', 'Electronics', 'Phone', 2, 600.00, 1200.00, '2024-01-02', 'South'),
    (3, 103, 'Charlie', 'Clothing', 'T-Shirt', 5, 20.00, 100.00, '2024-01-03', 'East'),
    (4, 104, 'David', 'Furniture', 'Table', 1, 250.00, 250.00, '2024-01-04', 'West'),
    (5, 105, 'Eve', 'Electronics', 'Tablet', 1, 300.00, 300.00, '2024-01-05', 'North'),
    (6, 106, 'Frank', 'Clothing', 'Jacket', 2, 80.00, 160.00, '2024-01-06', 'South'),
    (7, 107, 'Grace', 'Electronics', 'Headphones', 3, 50.00, 150.00, '2024-01-07', 'East'),
    (8, 108, 'Hank', 'Furniture', 'Chair', 4, 75.00, 300.00, '2024-01-08', 'West'),
    (9, 109, 'Ivy', 'Clothing', 'Jeans', 1, 40.00, 40.00, '2024-01-09', 'North'),
    (10, 110, 'Jack', 'Electronics', 'Laptop', 2, 1200.00, 2400.00, '2024-01-10', 'South'),
    (11, 101, 'Alice', 'Electronics', 'Phone', 1, 600.00, 600.00, '2024-01-11', 'North'),
    (12, 102, 'Bob', 'Furniture', 'Sofa', 1, 500.00, 500.00, '2024-01-12', 'South'),
    (13, 103, 'Charlie', 'Electronics', 'Camera', 1, 400.00, 400.00, '2024-01-13', 'East'),
    (14, 104, 'David', 'Clothing', 'Sweater', 2, 60.00, 120.00, '2024-01-14', 'West'),
    (15, 105, 'Eve', 'Furniture', 'Bed', 1, 800.00, 800.00, '2024-01-15', 'North'),
    (16, 106, 'Frank', 'Electronics', 'Monitor', 1, 200.00, 200.00, '2024-01-16', 'South'),
    (17, 107, 'Grace', 'Clothing', 'Scarf', 3, 25.00, 75.00, '2024-01-17', 'East'),
    (18, 108, 'Hank', 'Furniture', 'Desk', 1, 350.00, 350.00, '2024-01-18', 'West'),
    (19, 109, 'Ivy', 'Electronics', 'Speaker', 2, 100.00, 200.00, '2024-01-19', 'North'),
    (20, 110, 'Jack', 'Clothing', 'Shoes', 1, 90.00, 90.00, '2024-01-20', 'South'),
    (21, 111, 'Kevin', 'Electronics', 'Mouse', 3, 25.00, 75.00, '2024-01-21', 'East'),
    (22, 112, 'Laura', 'Furniture', 'Couch', 1, 700.00, 700.00, '2024-01-22', 'West'),
    (23, 113, 'Mike', 'Clothing', 'Hat', 4, 15.00, 60.00, '2024-01-23', 'North'),
    (24, 114, 'Nancy', 'Electronics', 'Smartwatch', 1, 250.00, 250.00, '2024-01-24', 'South'),
    (25, 115, 'Oscar', 'Furniture', 'Wardrobe', 1, 1000.00, 1000.00, '2024-01-25', 'East')


---1. Compute Running Total Sales per Customer
SELECT
    sale_id,
    customer_id,
    customer_name,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total_sales
FROM sales_data
ORDER BY customer_id, order_date;


---2. Count the Number of Orders per Product Category
SELECT
    product_category,
    COUNT(*) AS number_of_orders
FROM sales_data
GROUP BY product_category
ORDER BY product_category;

SELECT
    sale_id,
    product_category,
    COUNT(*) OVER (PARTITION BY product_category) AS number_of_orders
FROM sales_data
ORDER BY product_category, sale_id;

---3. Find the Maximum Total Amount per Product Category

SELECT
    product_category,
    MAX(total_amount) AS max_total_amount
FROM sales_data
GROUP BY product_category
ORDER BY product_category;

SELECT
    sale_id,
    product_category,
    total_amount,
    MAX(total_amount) OVER (PARTITION BY product_category) AS max_total_amount_in_category
FROM sales_data
ORDER BY product_category, sale_id;

---4. Find the Minimum Price of Products per Product Category

SELECT
    product_category,
    MIN(unit_price) AS min_unit_price
FROM sales_data
GROUP BY product_category
ORDER BY product_category;

SELECT
    sale_id,
    product_category,
    product_name,
    unit_price,
    MIN(unit_price) OVER (PARTITION BY product_category) AS min_unit_price_in_category
FROM sales_data
ORDER BY product_category, sale_id;

---5. Compute the Moving Average of Sales of 3 days (prev day, curr day, next day)

SELECT
    sale_id,
    customer_id,
    customer_name,
    order_date,
    total_amount,
    AVG(total_amount) OVER (
        ORDER BY order_date
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) AS moving_avg_3days
FROM sales_data
ORDER BY order_date;

---6. Find the Total Sales per Region
SELECT
    region,
    SUM(total_amount) AS total_sales
FROM sales_data
GROUP BY region
ORDER BY region;


SELECT
    sale_id,
    region,
    total_amount,
    SUM(total_amount) OVER (PARTITION BY region) AS total_sales_per_region
FROM sales_data
ORDER BY region, sale_id;

---7. Compute the Rank of Customers Based on Their Total Purchase Amount

WITH CustomerTotals AS (
    SELECT
        customer_id,
        customer_name,
        SUM(total_amount) AS total_purchase
    FROM sales_data
    GROUP BY customer_id, customer_name
)
SELECT
    customer_id,
    customer_name,
    total_purchase,
    RANK() OVER (ORDER BY total_purchase DESC) AS purchase_rank
FROM CustomerTotals
ORDER BY purchase_rank;


---8. Calculate the Difference Between Current and Previous Sale Amount per Customer
SELECT
    sale_id,
    customer_id,
    customer_name,
    order_date,
    total_amount,
    LAG(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS previous_sale_amount,
    total_amount - LAG(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS difference_from_previous
FROM sales_data
ORDER BY customer_id, order_date;


---9. Find the Top 3 Most Expensive Products in Each Category
SELECT
    product_category,
    product_name,
    unit_price,
    rank_in_category
FROM (
    SELECT
        product_category,
        product_name,
        unit_price,
        RANK() OVER (
            PARTITION BY product_category
            ORDER BY unit_price DESC
        ) AS rank_in_category
    FROM sales_data
) AS ranked
WHERE rank_in_category <= 3
ORDER BY product_category, rank_in_category, product_name;

---10. Compute the Cumulative Sum of Sales Per Region by Order Date

SELECT
    sale_id,
    region,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY region
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_sales
FROM sales_data
ORDER BY region, order_date;

---11. Compute Cumulative Revenue per Product Category
SELECT
    sale_id,
    product_category,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY product_category
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_revenue
FROM sales_data
ORDER BY product_category, order_date;

---12. Here you need to find out the sum of previous values. Please go through the sample input and expected output.

--Sample Input

--| ID |
--|----|
--|  1 |
--|  2 |
--|  3 |
--|  4 |
--|  5 |
--Expected Output

--| ID | SumPreValues |
--|----|--------------|
--|  1 |            1 |
--|  2 |            3 |
--|  3 |            6 |
--|  4 |           10 |
--|  5 |           15 |

SELECT
    ID,
    SUM(ID) OVER (
        ORDER BY ID
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS SumPreValues
FROM your_table
ORDER BY ID;


---13. Sum of Previous Values to Current Value
CREATE TABLE OneColumn (
    Value SMALLINT
);
INSERT INTO OneColumn VALUES (10), (20), (30), (40), (100);

SELECT
    Value,
    SUM(Value) OVER (
        ORDER BY Value
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS [Sum of Previous]
FROM OneColumn
ORDER BY Value;

---14. Find customers who have purchased items from more than one product_category
SELECT
    customer_id,
    customer_name,
    COUNT(DISTINCT product_category) AS category_count
FROM sales_data
GROUP BY customer_id, customer_name
HAVING COUNT(DISTINCT product_category) > 1
ORDER BY customer_id;

---15. Find Customers with Above-Average Spending in Their Region

WITH CustomerRegionTotals AS (
    SELECT
        customer_id,
        customer_name,
        region,
        SUM(total_amount) AS customer_total
    FROM sales_data
    GROUP BY customer_id, customer_name, region
),
RegionAverages AS (
    SELECT
        region,
        AVG(customer_total) AS avg_region_spending
    FROM CustomerRegionTotals
    GROUP BY region
)
SELECT
    c.customer_id,
    c.customer_name,
    c.region,
    c.customer_total,
    r.avg_region_spending
FROM CustomerRegionTotals c
JOIN RegionAverages r
  ON c.region = r.region
WHERE c.customer_total > r.avg_region_spending
ORDER BY c.region, c.customer_total DESC;


---16. Rank customers based on their total spending (total_amount) within each region. 
--If multiple customers have the same spending, they should receive the same rank.

WITH CustomerTotals AS (
    SELECT
        customer_id,
        customer_name,
        region,
        SUM(total_amount) AS total_spending
    FROM sales_data
    GROUP BY customer_id, customer_name, region
)
SELECT
    customer_id,
    customer_name,
    region,
    total_spending,
    RANK() OVER (
        PARTITION BY region
        ORDER BY total_spending DESC
    ) AS spending_rank
FROM CustomerTotals
ORDER BY region, spending_rank;

---17. Calculate the running total (cumulative_sales) of total_amount for each customer_id, ordered by order_date.
SELECT
    sale_id,
    customer_id,
    customer_name,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_sales
FROM sales_data
ORDER BY customer_id, order_date;

---18. Calculate the sales growth rate (growth_rate) for each month compared to the previous month.

--WITH MonthlySales AS (
--    SELECT
--        DATE_FORMAT(order_date, '%Y-%m') AS month,
--        SUM(total_amount) AS monthly_sales
--    FROM sales_data
--    GROUP BY DATE_FORMAT(order_date, '%Y-%m')
--)
--SELECT
--    month,
--    monthly_sales,
--    LAG(monthly_sales) OVER (ORDER BY month) AS prev_month_sales,
--    ROUND(
--        (monthly_sales - LAG(monthly_sales) OVER (ORDER BY month)) 
--        / NULLIF(LAG(monthly_sales) OVER (ORDER BY month), 0) * 100,
--        2
--    ) AS growth_rate
--FROM MonthlySales
--ORDER BY month;

/* SOLUTION */











---19. Identify customers whose total_amount is higher than their last order''s total_amount.(Table sales_data)

/*SELECT
    sale_id,
    customer_id,
    customer_name,
    order_date,
    total_amount,
    LAG(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS previous_order_amount
FROM sales_data
WHERE total_amount > LAG(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    )
ORDER BY customer_id, order_date;*/

/* SOLUTION */


















---20. Identify Products that prices are above the average product price

SELECT
    product_name,
    product_category,
    unit_price
FROM sales_data
WHERE unit_price > (
    SELECT AVG(unit_price) FROM sales_data
)
ORDER BY unit_price DESC;



SELECT DISTINCT
    product_name,
    product_category,
    unit_price
FROM sales_data
WHERE unit_price > (
    SELECT AVG(unit_price) FROM sales_data
)
ORDER BY unit_price DESC;



---21. In this puzzle you have to find the sum of val1 and val2 for each group and put that value at the beginning of the group in the new column. 
-- The challenge here is to do this in a single select. For more details please see the sample input and expected output.

CREATE TABLE MyData (
    Id INT, Grp INT, Val1 INT, Val2 INT
);
INSERT INTO MyData VALUES
(1,1,30,29), (2,1,19,0), (3,1,11,45), (4,2,0,0), (5,2,100,17);

/*
Sample Input

| Id  | Grp | Val1 | Val2 |  
|-----|-----|------|------|  
|  1  |  1  |   30 |   29 |  
|  2  |  1  |   19 |    0 |  
|  3  |  1  |   11 |   45 |  
|  4  |  2  |    0 |    0 |  
|  5  |  2  |  100 |   17 |
Expected Output

| Id | Grp | Val1 | Val2 | Tot  |
|----|-----|------|------|------|
| 1  | 1   | 30   | 29   | 134  |
| 2  | 1   | 19   | 0    | NULL |
| 3  | 1   | 11   | 45   | NULL |
| 4  | 2   | 0    | 0    | 117  |
| 5  | 2   | 100  | 17   | NULL |

*/

SELECT
    Id,
    Grp,
    Val1,
    Val2,
    CASE 
        WHEN Id = MIN(Id) OVER (PARTITION BY Grp)
        THEN SUM(Val1 + Val2) OVER (PARTITION BY Grp)
        ELSE NULL
    END AS Tot
FROM MyData
ORDER BY Grp, Id;

---22. Here you have to sum up the value of the cost column based on the values of Id. 
---For Quantity if values are different then we have to add those values.Please go through the sample input and expected output for details.

CREATE TABLE TheSumPuzzle (
    ID INT, Cost INT, Quantity INT
);
INSERT INTO TheSumPuzzle VALUES
(1234,12,164), (1234,13,164), (1235,100,130), (1235,100,135), (1236,12,136);

/*
Sample Input

| Id   | Cost | Quantity |  
|------|------|----------|  
| 1234 |   12 |      164 |  
| 1234 |   13 |      164 |  
| 1235 |  100 |      130 |  
| 1235 |  100 |      135 |  
| 1236 |   12 |      136 | 
Expected Output

| Id   | Cost | Quantity |
|------|------|----------|
| 1234 | 25   | 164      |
| 1235 | 200  | 265      |
| 1236 | 12   | 136      |

*/

SELECT
    ID,
    SUM(Cost) AS Cost,
    SUM(DISTINCT Quantity) AS Quantity
FROM TheSumPuzzle
GROUP BY ID
ORDER BY ID;


---23. From following set of integers, write an SQL statement to determine the expected outputs

CREATE TABLE Seats 
( 
SeatNumber INTEGER 
); 

INSERT INTO Seats VALUES 
(7),(13),(14),(15),(27),(28),(29),(30), 
(31),(32),(33),(34),(35),(52),(53),(54); 

/*
Output:

---------------------
|Gap Start	|Gap End|
---------------------
|     1     |	6	|
|     8     |	12	|
|     16    |	26	|
|     36    |	51	|
---------------------
*/

WITH WithNext AS (
    SELECT
        SeatNumber,
        LEAD(SeatNumber) OVER (ORDER BY SeatNumber) AS NextSeat
    FROM Seats
)
SELECT
    SeatNumber + 1 AS [Gap Start],
    NextSeat - 1   AS [Gap End]
FROM WithNext
WHERE NextSeat > SeatNumber + 1
ORDER BY SeatNumber;











