/*
 Fix Names in a Table
 --------------------

 Table: users

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| user_id        | int     |
| name           | varchar |
+----------------+---------+

 user_id is the primary key for this table.
 This table contains ID and name of a user. The name consists of only lowercase and
 uppercase characters.
*/

IF
    EXISTS (
        SELECT name FROM sys.databases
        WHERE name = 'db_44'
    )
    BEGIN
        IF
            NOT EXISTS (
                SELECT TABLE_NAME
                FROM db_44.INFORMATION_SCHEMA.TABLES
                WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'users'
            )
            BEGIN
                CREATE TABLE db_44.dbo.users (
                    user_id INT PRIMARY KEY, name VARCHAR(40) NOT NULL
                )
            END

        IF NOT EXISTS (SELECT 1 FROM db_44.dbo.users)
            BEGIN
                INSERT INTO db_44.dbo.users
                VALUES (1, 'aLice'),
                (2, 'bOB')
            END

            --Write a solution to fix the names so that only first character is uppercase and rest
            --are lowercase. Return the result ordered by user_id.
        SELECT
            user_id,
            (CONCAT(
                UPPER(SUBSTRING(name, 1, 1)),
                LOWER(SUBSTRING(name, 2, LEN(name) - 1))
            )) AS name
        FROM db_44.dbo.users
        ORDER BY user_id ASC

    END
