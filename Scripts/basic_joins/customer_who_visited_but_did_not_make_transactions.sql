/*
 Customer Who Visited But Did Not Make Any Transactions
 ------------------------------------------------------

 Table: visits

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| visit_id    | int     |
| customer_id | int     |
+-------------+---------+

 visit_id is the primary key for this table.
 This table contains information about the customers who visited the mall.

 Table: transactions

 +----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| transaction_id | int     |
| visit_id       | int     |
| amount         | int     |
+----------------+---------+

 transaction_id is the primary key for this table.
 This table contains information about the transactions made during visits with visit_id.
*/

IF
    EXISTS (
        SELECT name FROM sys.databases
        WHERE name = 'db_8'
    )
    BEGIN
        IF
            NOT EXISTS (
                SELECT TABLE_NAME
                FROM db_8.INFORMATION_SCHEMA.TABLES
                WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'visits'
            )
            BEGIN
                CREATE TABLE db_8.dbo.visits (
                    visit_id INT PRIMARY KEY, customer_id INT NOT NULL
                )
            END

        IF
            NOT EXISTS (
                SELECT TABLE_NAME
                FROM db_8.INFORMATION_SCHEMA.TABLES
                WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'transactions'
            )
            BEGIN
                CREATE TABLE db_8.dbo.transactions (
                    transaction_id INT PRIMARY KEY,
                    visit_id INT FOREIGN KEY REFERENCES db_8.dbo.visits (visit_id),
                    amount INT NOT NULL
                )
            END

        IF NOT EXISTS (SELECT 1 FROM db_8.dbo.visits)
            BEGIN
                INSERT INTO db_8.dbo.visits
                VALUES (1, 23),
                (2, 9),
                (4, 30),
                (5, 54),
                (6, 96),
                (7, 54),
                (8, 54)
            END

        IF NOT EXISTS (SELECT 1 FROM db_8.dbo.transactions)
            BEGIN
                INSERT INTO db_8.dbo.transactions
                VALUES (2, 5, 310),
                (3, 5, 300),
                (9, 5, 200),
                (12, 1, 910),
                (13, 2, 970)
            END

            --Write a solution to find IDs of the users who visited without making transactions and
            --the number of times they made such visits. Return result in any order.
        SELECT
            v.customer_id,
            COUNT(v.visit_id) AS count_no_trans
        FROM db_8.dbo.visits AS v
        LEFT JOIN db_8.dbo.transactions AS t
            ON v.visit_id = t.visit_id
        WHERE t.visit_id IS NULL
        GROUP BY v.customer_id
        ORDER BY v.customer_id ASC

    END
