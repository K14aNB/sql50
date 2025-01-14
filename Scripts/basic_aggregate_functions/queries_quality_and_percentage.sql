/*
 Queries Quality and Percentage
 ------------------------------

 Table: queries

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| query_name  | varchar |
| result      | varchar |
| position    | int     |
| rating      | int     |
+-------------+---------+

 This table may have duplicate rows.
 This table contains information collected from some queries on a database.
 The postion column has a value from 1 to 500.
 The rating column has a value from 1 to 5.
 Query with rating less than 3 is a poor query.

 quality: The average of the ratio between query rating and its position.
 poor_query_percentage: The percentage of all queries with rating less than 3.
*/

IF
    EXISTS (
        SELECT name FROM sys.databases
        WHERE name = 'db_19'
    )
    BEGIN
        IF
            NOT EXISTS (
                SELECT TABLE_NAME
                FROM db_19.INFORMATION_SCHEMA.TABLES
                WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'queries'
            )
            BEGIN
                CREATE TABLE db_19.dbo.queries (
                    query_name VARCHAR(50) NOT NULL,
                    result VARCHAR(100) NOT NULL,
                    position INT NOT NULL CHECK (position BETWEEN 1 AND 500),
                    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5)
                )
            END

        IF NOT EXISTS (SELECT 1 FROM db_19.dbo.queries)
            BEGIN
                INSERT INTO db_19.dbo.queries
                VALUES ('Dog', 'Golden Retriever', 1, 5),
                ('Dog', 'German Shepherd', 2, 5),
                ('Dog', 'Mule', 200, 1),
                ('Cat', 'Shirazi', 5, 2),
                ('Cat', 'Siamese', 3, 3),
                ('Cat', 'Sphynx', 7, 4)
            END

            --Write a solution to find each query_name, quality and poor_query_percentage.
            --Both quality and poor_query_percentage should be rounded to 2 decimal places.
            --Return the result in any order.
        SELECT
            query_name,
            ROUND(AVG(CAST(rating AS DECIMAL(10, 2)) / position), 2) AS quality,
            ROUND(100.00 * SUM(CAST(
                CASE WHEN rating < 3 THEN 1 ELSE 0 END
                AS DECIMAL(10, 2)
            )) / COUNT(*), 2) AS poor_query_percentage
        FROM db_19.dbo.queries
        GROUP BY query_name
        ORDER BY query_name ASC

    END
