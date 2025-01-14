/*
 Group Sold Products By Date
 ---------------------------

 Table: activities

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| sell_date   | date    |
| product     | varchar |
+-------------+---------+

 There is no primary key for this table.
 It may contain duplicates.
 Each row of this table contains product name and date it was sold in a market.
*/

IF
    EXISTS (
        SELECT name FROM sys.databases
        WHERE name = 'db_48'
    )
    BEGIN
        IF
            NOT EXISTS (
                SELECT TABLE_NAME
                FROM db_48.INFORMATION_SCHEMA.TABLES
                WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'activities'
            )
            BEGIN
                CREATE TABLE db_48.dbo.activities (
                    sell_date DATE NOT NULL,
                    product VARCHAR(100) NOT NULL
                )
            END

        IF NOT EXISTS (SELECT 1 FROM db_48.dbo.activities)
            BEGIN
                INSERT INTO db_48.dbo.activities
                VALUES ('2020-05-30', 'Headphone'),
                ('2020-06-01', 'Pencil'),
                ('2020-06-02', 'Mask'),
                ('2020-05-30', 'Basketball'),
                ('2020-06-01', 'Bible'),
                ('2020-06-02', 'Mask'),
                ('2020-05-30', 'T-Shirt')
            END

            --Write a solution to find for each date the number of different products sold and
            --their names. The sold products names for each date should be sorted lexicographically.
            --Return the result ordered by sell_date.
            ; WITH cte AS (
            SELECT DISTINCT * FROM db_48.dbo.activities
        )

        SELECT
            sell_date,
            COUNT(DISTINCT product) AS num_sold,
            STRING_AGG(product, ',')
            WITHIN GROUP (
                ORDER BY product ASC
            ) AS products
        FROM cte
        GROUP BY sell_date
        ORDER BY sell_date ASC

    END
