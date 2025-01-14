/*
 Average Selling Price
 ---------------------

 Table: prices

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| start_date    | date    |
| end_date      | date    |
| price         | int     |
+---------------+---------+

 (product_id, start_date, end_date) is the primary key combination for this table.
 Each row of this table indicates the price of the product with product_id in the
 period from start_date to end_date.
 For each product_id there will no overlapping periods. That means there will be no two
 intersecting periods for the same product_id.

 Table: unitssold

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| purchase_date | date    |
| units         | int     |
+---------------+---------+

 This table may contain duplicate rows.
 Each row of this table indicates the date, units and product_id of each product sold.
*/

IF
    EXISTS (
        SELECT name FROM sys.databases
        WHERE name = 'db_16'
    )
    BEGIN
        IF
            NOT EXISTS (
                SELECT TABLE_NAME
                FROM db_16.INFORMATION_SCHEMA.TABLES
                WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'prices'
            )
            BEGIN
                CREATE TABLE db_16.dbo.prices (
                    product_id INT NOT NULL,
                    start_date DATE NOT NULL,
                    end_date DATE NOT NULL,
                    price INT NOT NULL,
                    PRIMARY KEY (product_id, start_date, end_date)
                )
            END

        IF
            NOT EXISTS (
                SELECT TABLE_NAME
                FROM db_16.INFORMATION_SCHEMA.TABLES
                WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'unitssold'
            )
            BEGIN
                CREATE TABLE db_16.dbo.unitssold (
                    product_id INT NOT NULL,
                    purchase_date DATE NOT NULL,
                    units INT NOT NULL
                )
            END

        IF NOT EXISTS (SELECT 1 FROM db_16.dbo.prices)
            BEGIN
                INSERT INTO db_16.dbo.prices
                VALUES (1, '2019-02-17', '2019-02-28', 5),
                (1, '2019-03-01', '2019-03-22', 20),
                (2, '2019-02-01', '2019-02-20', 15),
                (2, '2019-02-21', '2019-03-31', 30)
            END

        IF NOT EXISTS (SELECT 1 FROM db_16.dbo.unitssold)
            BEGIN
                INSERT INTO db_16.dbo.unitssold
                VALUES (1, '2019-02-25', 100),
                (1, '2019-03-01', 15),
                (2, '2019-02-10', 200),
                (2, '2019-03-22', 30)
            END

            --Write a solution to find the average selling price for each product.
            --average_price should be rounded to 2 decimal places. If a product does not have any
            --sold units, its average selling price is assumed to be 0.
            --Return the result table in any order.
        SELECT
            p.product_id,
            COALESCE(ROUND(
                CAST(SUM(p.price * u.units) AS DECIMAL(10, 2))
                / SUM(u.units), 2
            ), 0.00) AS average_price
        FROM db_16.dbo.unitssold AS u
        LEFT JOIN db_16.dbo.prices AS p
            ON u.product_id = p.product_id
        WHERE u.purchase_date BETWEEN p.start_date AND p.end_date
        GROUP BY p.product_id
        ORDER BY p.product_id ASC

    END
