/*
 List Products Ordered In Period
 -------------------------------

 Table: products

+------------------+---------+
| Column Name      | Type    |
+------------------+---------+
| product_id       | int     |
| product_name     | varchar |
| product_category | varchar |
+------------------+---------+

 product_id is the primary key for this table.
 This table contains data about the company's products.

 Table: orders

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| order_date    | date    |
| unit          | int     |
+---------------+---------+

 This table may have duplicate rows.
 product_id is the foreign key to products table.
 unit is the number of products ordered in order_date.
*/

IF
    EXISTS (
        SELECT name FROM sys.databases
        WHERE name = 'db_49'
    )
    BEGIN
        IF
            NOT EXISTS (
                SELECT TABLE_NAME
                FROM db_49.INFORMATION_SCHEMA.TABLES
                WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'products'
            )
            BEGIN
                CREATE TABLE db_49.dbo.products (
                    product_id INT PRIMARY KEY,
                    product_name VARCHAR(50) NOT NULL,
                    product_category VARCHAR(40) NOT NULL
                )
            END

        IF
            NOT EXISTS (
                SELECT TABLE_NAME
                FROM db_49.INFORMATION_SCHEMA.TABLES
                WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'orders'
            )
            BEGIN
                CREATE TABLE db_49.dbo.orders (
                    product_id INT
                    FOREIGN KEY REFERENCES db_49.dbo.products (product_id),
                    order_date DATE NOT NULL,
                    unit INT NOT NULL
                )
            END

        IF NOT EXISTS (SELECT 1 FROM db_49.dbo.products)
            BEGIN
                INSERT INTO db_49.dbo.products
                VALUES (1, 'Leetcode Solutions', 'Book'),
                (2, 'Jewels of Stringology', 'Book'),
                (3, 'HP', 'Laptop'),
                (4, 'Lenovo', 'Laptop'),
                (5, 'Leetcode Kit', 'T-shirt')
            END

        IF NOT EXISTS (SELECT 1 FROM db_49.dbo.orders)
            BEGIN
                INSERT INTO db_49.dbo.orders
                VALUES (1, '2020-02-05', 60),
                (1, '2020-02-10', 70),
                (2, '2020-01-18', 30),
                (2, '2020-02-11', 80),
                (3, '2020-02-17', 2),
                (3, '2020-02-24', 3),
                (4, '2020-03-01', 20),
                (4, '2020-03-04', 30),
                (4, '2020-03-04', 60),
                (5, '2020-02-25', 50),
                (5, '2020-02-27', 50),
                (5, '2020-03-01', 50)
            END

            --Write a solution to get the names of products that have at least 100 units ordered
            --in February 2020 and their amount. Return the result in any order.
        SELECT
            p.product_name,
            SUM(o.unit) AS unit
        FROM db_49.dbo.products AS p
        INNER JOIN db_49.dbo.orders AS o
            ON p.product_id = o.product_id
        WHERE DATEPART(YEAR, o.order_date) = '2020'
            AND DATEPART(MONTH, o.order_date) = '02'
        GROUP BY p.product_name
        HAVING SUM(o.unit) >= 100
        ORDER BY p.product_name ASC

    END
