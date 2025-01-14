/*
 Find Users With Valid Emails
 ----------------------------

 Table: users

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | int     |
| name          | varchar |
| mail          | varchar |
+---------------+---------+

 user_id is the primary key for this table.
 This table contains information of the users signed up in a website.
 Some emails are invalid.
*/

IF
    EXISTS (
        SELECT name FROM sys.databases
        WHERE name = 'db_50'
    )
    BEGIN
        IF
            NOT EXISTS (
                SELECT TABLE_NAME
                FROM db_50.INFORMATION_SCHEMA.TABLES
                WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'users'
            )
            BEGIN
                CREATE TABLE db_50.dbo.users (
                    user_id INT PRIMARY KEY,
                    name VARCHAR(40) NOT NULL,
                    mail VARCHAR(50) NOT NULL
                )
            END

        IF NOT EXISTS (SELECT 1 FROM db_50.dbo.users)
            BEGIN
                INSERT INTO db_50.dbo.users
                VALUES (1, 'Winston', 'winston@leetcode.com'),
                (2, 'Jonathan', 'jonathanisgreat'),
                (3, 'Annabelle', 'bella-@leetcode.com'),
                (4, 'Sally', 'sally.come@leetcode.com'),
                (5, 'Marwan', 'quarz#2020@leetcode.com'),
                (6, 'David', 'david69@gmail.com'),
                (7, 'Shapiro', '.shapo@leetcode.com'),
                (8, 'Brock', 'B@leetcode.com')
            END

            --Write a solution to find the users who have valid emails.
            --A valid email has a prefix and domain name where:
            -- * The prefix name is a string that may contain letters (upper or lower case), digits,
            --  underscore (_), period (.) or dash(-). The prefix must start with a letter.
            -- * The domain is @leetcode.com
            --Return the result in any order.
        SELECT *
        FROM db_50.dbo.users
        WHERE mail LIKE '[a-zA-Z][a-zA-Z0-9_.-]%@leetcode.com'
            AND mail NOT LIKE '%[^a-zA-Z0-9_.-]%@leetcode.com'
            OR mail LIKE '[a-zA-Z]@leetcode.com'

    END
