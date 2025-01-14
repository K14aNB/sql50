/*
 Percentage of Users Attended a Contest
 --------------------------------------

 Table: users

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| user_id     | int     |
| user_name   | varchar |
+-------------+---------+

 user_id is the primary key for this table.
 Each row of this table contains the name and id of a user.

 Table: register

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| contest_id  | int     |
| user_id     | int     |
+-------------+---------+

 (contest_id, user_id) is the primary key combination for this table.
 Each row of this table contains the id of a user and the contest they registered into.
*/

IF
    EXISTS (
        SELECT name FROM sys.databases
        WHERE name = 'db_18'
    )
    BEGIN
        IF
            NOT EXISTS (
                SELECT TABLE_NAME
                FROM db_18.INFORMATION_SCHEMA.TABLES
                WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'users'
            )
            BEGIN
                CREATE TABLE db_18.dbo.users (
                    user_id INT PRIMARY KEY, user_name VARCHAR(40) NOT NULL
                )
            END

        IF
            NOT EXISTS (
                SELECT TABLE_NAME
                FROM db_18.INFORMATION_SCHEMA.TABLES
                WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'register'
            )
            BEGIN
                CREATE TABLE db_18.dbo.register (
                    contest_id INT,
                    user_id INT,
                    PRIMARY KEY (contest_id, user_id)
                )
            END

        IF NOT EXISTS (SELECT 1 FROM db_18.dbo.users)
            BEGIN
                INSERT INTO db_18.dbo.users
                VALUES (6, 'Alice'),
                (2, 'Bob'),
                (7, 'Alex')
            END

        IF NOT EXISTS (SELECT 1 FROM db_18.dbo.register)
            BEGIN
                INSERT INTO db_18.dbo.register
                VALUES (215, 6),
                (209, 2),
                (208, 2),
                (210, 6),
                (208, 6),
                (209, 7),
                (209, 6),
                (215, 7),
                (208, 7),
                (210, 2),
                (207, 2),
                (210, 7)
            END

            --Write a solution to find the percentage of the users registered in each contest
            --rounded to two decimals. Return the table ordered by percentage in descending order.
            --In case of a tie, order it by contest_id in ascending order.

        SELECT
            contest_id,
            ROUND(100.00 * (
                CAST(COUNT(DISTINCT user_id) AS DECIMAL(10, 2))
                / (SELECT COUNT(DISTINCT user_id) FROM db_18.dbo.users)
            ), 2) AS percentage
        FROM db_18.dbo.register
        GROUP BY contest_id
        ORDER BY percentage DESC, contest_id ASC

    END
