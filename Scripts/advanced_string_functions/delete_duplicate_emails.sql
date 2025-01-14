/*
 Delete Duplicate Emails
 -----------------------

 Table: person

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| email       | varchar |
+-------------+---------+

 id is the primary key for this table.
 Each row of this table contains an email. The emails will not contain uppercase letters.
*/

IF
    EXISTS (
        SELECT name FROM sys.databases
        WHERE name = 'db_46'
    )
    BEGIN
        IF
            NOT EXISTS (
                SELECT TABLE_NAME
                FROM db_46.INFORMATION_SCHEMA.TABLES
                WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'person'
            )
            BEGIN
                CREATE TABLE db_46.dbo.person (
                    id INT PRIMARY KEY, email VARCHAR(50)
                )
            END

        IF NOT EXISTS (SELECT 1 FROM db_46.dbo.person)
            BEGIN
                INSERT INTO db_46.dbo.person
                VALUES (1, 'john@example.com'),
                (2, 'bob@example.com'),
                (3, 'john@example.com')
            END

            --Write a solution to delete all duplicate emails, keeping only one unique email with
            --smallest id.
            ; WITH cte AS (
            SELECT
                id,
                email,
                ROW_NUMBER() OVER (
                    PARTITION BY email
                    ORDER BY id ASC
                ) AS row_no
            FROM db_46.dbo.person
        )

        DELETE FROM db_46.dbo.person
        WHERE email IN (
                SELECT email FROM cte
                WHERE row_no > 1
            )
            AND id IN (
                SELECT id FROM cte
                WHERE row_no > 1
            )

        SELECT * FROM db_46.dbo.person

    END
