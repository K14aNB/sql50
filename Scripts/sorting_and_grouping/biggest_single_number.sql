/*
 Biggest Single Number
 ---------------------

 Table: mynumbers

+-------------+------+
| Column Name | Type |
+-------------+------+
| num         | int  |
+-------------+------+

 This table may contain duplicates.
 Each row of this table contains an integer.

 A single number is a number that appeared only once in the table.
*/

IF
    EXISTS (
        SELECT name FROM sys.databases
        WHERE name = 'db_28'
    )
    BEGIN
        IF
            NOT EXISTS (
                SELECT TABLE_NAME
                FROM db_28.INFORMATION_SCHEMA.TABLES
                WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'mynumbers'
            )
            BEGIN
                CREATE TABLE db_28.dbo.mynumbers (num INT NOT NULL)
            END

        IF NOT EXISTS (SELECT 1 FROM db_28.dbo.mynumbers)
            BEGIN
                INSERT INTO db_28.dbo.mynumbers
                VALUES (8),
                (8),
                (3),
                (3),
                (1),
                (4),
                (5),
                (6)
            END

            --Find the largest single number. If there is no single number, report NULL.
            ; WITH cte AS (
            SELECT
                num,
                COUNT(num) AS cnt
            FROM db_28.dbo.mynumbers
            GROUP BY num
            HAVING COUNT(num) = 1
        )

        SELECT TOP 1 num
        FROM cte
        ORDER BY num DESC

    END
