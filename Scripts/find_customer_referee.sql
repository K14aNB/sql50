/*
 Find Customer Referee
 ---------------------

 Table: Customer

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| referee_id  | int     |
+-------------+---------+

 id is the primary key for this table.
 Each row of this table indicates the id of a customer,
 their name and id of the customer who referred them.
*/

IF EXISTS(SELECT name
          FROM sys.databases
          WHERE name = 'db_2')
BEGIN
IF NOT EXISTS(SELECT TABLE_NAME
              FROM db_2.INFORMATION_SCHEMA.TABLES
              WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'db_2')
BEGIN
CREATE TABLE db_2.dbo.customer(id INT PRIMARY KEY,
                               name VARCHAR(50) NOT NULL,
                               referee_id INT)
END

IF NOT EXISTS(SELECT 1 FROM db_2.dbo.customer)
BEGIN
INSERT INTO db_2.dbo.customer
VALUES(1, 'Will', NULL),
(2, 'Jane', NULL),
(3, 'Alex', 2),
(4, 'Bill', NULL),
(5, 'Zack', 1),
(6, 'Mark', 2)
END

--Find names of the customer that are not referred by the customer with id = 2.
--Return result in any order.
SELECT name
FROM db_2.dbo.customer
WHERE referee_id IS NULL OR referee_id <> 2

END