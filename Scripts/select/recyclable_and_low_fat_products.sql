/*
 Recyclable And Low Fat Products
 -------------------------------

 Table: products
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| product_id  | int     |
| low_fats    | enum    |
| recyclable  | enum    |
+-------------+---------+

 product_id is the primary key for this table.
 low_fats is an ENUM of type ('Y', 'N').
 recyclable is an ENUM of type ('Y', 'N').
*/

IF
    EXISTS (
        SELECT name
        FROM sys.databases
        WHERE name = 'db_1'
    )
    BEGIN
        IF
            NOT EXISTS (
                SELECT TABLE_NAME
                FROM db_1.INFORMATION_SCHEMA.TABLES
                WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'products'
            )
            BEGIN
                CREATE TABLE db_1.dbo.products (
                    product_id INT PRIMARY KEY,
                    low_fats CHAR(1) NOT NULL CHECK (low_fats IN ('Y', 'N')),
                    recyclable CHAR(1) NOT NULL CHECK (recyclable IN ('Y', 'N'))
                )
            END
        IF NOT EXISTS (SELECT 1 FROM db_1.dbo.products)
            BEGIN
                INSERT INTO db_1.dbo.products
                VALUES (0, 'Y', 'N'),
                (1, 'Y', 'Y'),
                (2, 'N', 'Y'),
                (3, 'Y', 'Y'),
                (4, 'N', 'N')
            END

            --Write a solution to find the ids of products that are both low fat and recyclable.
        SELECT product_id
        FROM db_1.dbo.products
        WHERE low_fats = 'Y' AND recyclable = 'Y'

    END
