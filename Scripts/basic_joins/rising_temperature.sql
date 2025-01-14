/*
 Rising Temperature
 ------------------

 Table: weather

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| recordDate    | date    |
| temperature   | int     |
+---------------+---------+

 id is the primary key for this table.
 There are no different rows with same recordDate.
 This table contains information about the temperature on a certain day.
*/

IF
    EXISTS (
        SELECT name FROM sys.databases
        WHERE name = 'db_9'
    )
    BEGIN
        IF
            NOT EXISTS (
                SELECT TABLE_NAME
                FROM db_9.INFORMATION_SCHEMA.TABLES
                WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'weather'
            )
            BEGIN
                CREATE TABLE db_9.dbo.weather (
                    id INT PRIMARY KEY,
                    recordDate DATE UNIQUE NOT NULL,
                    temperature INT NOT NULL
                )
            END

        IF NOT EXISTS (SELECT 1 FROM db_9.dbo.weather)
            BEGIN
                INSERT INTO db_9.dbo.weather
                VALUES (1, '2015-01-01', 10),
                (2, '2015-01-02', 25),
                (3, '2015-01-03', 20),
                (4, '2015-01-04', 30)
            END

            --Write a solution to find all dates id with higher temperatures compared to it's
            --previous dates. Return the result in any order.
        SELECT w2.id
        FROM db_9.dbo.weather AS w1
        INNER JOIN db_9.dbo.weather AS w2
            ON w2.id = w1.id + 1
        WHERE w2.temperature > w1.temperature
        ORDER BY w2.id ASC

    END
