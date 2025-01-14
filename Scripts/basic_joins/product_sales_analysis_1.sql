/*
 Product Sales Analysis 1
 ------------------------

 Table: sales

+-------------+-------+
| Column Name | Type  |
+-------------+-------+
| sale_id     | int   |
| product_id  | int   |
| year        | int   |
| quantity    | int   |
| price       | int   |
+-------------+-------+

 (sale_id, year) is the primary key for this table.
 product_id is the foreign key to product table.
 Each row of this table shows a sale on the product product_id in a certain year.
 Note that price is per unit.

 Table: product
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| product_id   | int     |
| product_name | varchar |
+--------------+---------+

 product_id is the primary key for this table.
 Each row of this table indicates the product name of each product.
*/

IF
    EXISTS (
        SELECT name FROM sys.databases
        WHERE name = 'db_7'
    )
    BEGIN
        IF
            NOT EXISTS (
                SELECT TABLE_NAME
                FROM db_7.INFORMATION_SCHEMA.TABLES
                WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'product'
            )
            BEGIN
                CREATE TABLE db_7.dbo.product (
                    product_id INT PRIMARY KEY,
                    product_name VARCHAR(40) NOT NULL UNIQUE
                )
            END

        IF
            NOT EXISTS (
                SELECT TABLE_NAME
                FROM db_7.INFORMATION_SCHEMA.TABLES
                WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'sales'
            )
            BEGIN
                CREATE TABLE db_7.dbo.sales (
                    sale_id INT,
                    product_id INT FOREIGN KEY REFERENCES db_7.dbo.product (
                        product_id
                    ),
                    year INT,
                    quantity INT NOT NULL,
                    price INT NOT NULL,
                    PRIMARY KEY (sale_id, year)
                )
            END

        IF NOT EXISTS (SELECT 1 FROM db_7.dbo.product)
            BEGIN
                INSERT INTO db_7.dbo.product
                VALUES (100, 'Nokia'),
                (200, 'Apple'),
                (300, 'Samsung')
            END

        IF NOT EXISTS (SELECT 1 FROM db_7.dbo.sales)
            BEGIN
                INSERT INTO db_7.dbo.sales
                VALUES (1, 100, 2008, 10, 5000),
                (2, 100, 2009, 12, 5000),
                (7, 200, 2011, 15, 9000)
            END

            --Write a solution to report the product_name, year and price for each sale_id in the
            --sales table. Return the result in any order.
        SELECT
            p.product_name,
            s.year,
            s.price
        FROM db_7.dbo.sales AS s
        INNER JOIN db_7.dbo.product AS p
            ON s.product_id = p.product_id

    END
