/*
 Replace Employee ID With Unique Identifier
 ------------------------------------------

 Table: employees

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| name          | varchar |
+---------------+---------+

 id is the primary key for this table.
 Each row of this table contains the id and name of an employee in a company.

 Table: employeeUNI

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| unique_id     | int     |
+---------------+---------+
 (id, unique_id) is the primary key for this table.
 Each row of this table contains the id and the corresponding unique id of an employee
 in the company.
*/

IF
    EXISTS (
        SELECT name FROM sys.databases
        WHERE name = 'db_6'
    )
    BEGIN
        IF
            NOT EXISTS (
                SELECT TABLE_NAME
                FROM db_6.INFORMATION_SCHEMA.TABLES
                WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'employees'
            )
            BEGIN
                CREATE TABLE db_6.dbo.employees (
                    id INT PRIMARY KEY, name VARCHAR(40)
                )
            END

        IF
            NOT EXISTS (
                SELECT TABLE_NAME
                FROM db_6.INFORMATION_SCHEMA.TABLES
                WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'employeeuni'
            )
            BEGIN
                CREATE TABLE db_6.dbo.employeeuni (
                    id INT FOREIGN KEY REFERENCES db_6.dbo.employees (id),
                    unique_id INT, PRIMARY KEY (id, unique_id)
                )
            END

        IF NOT EXISTS (SELECT 1 FROM db_6.dbo.employees)
            BEGIN
                INSERT INTO db_6.dbo.employees
                VALUES (1, 'Alice'),
                (7, 'Bob'),
                (11, 'Meir'),
                (90, 'Winston'),
                (3, 'Jonathan')
            END

        IF NOT EXISTS (SELECT 1 FROM db_6.dbo.employeeuni)
            BEGIN
                INSERT INTO db_6.dbo.employeeuni
                VALUES (3, 1),
                (11, 2),
                (90, 3)
            END

            --Write a solution to show the unique id of each user. If a user does not have a unique
            --ID replace, just show null. Return the result in any order.
        SELECT
            u.unique_id,
            e.name
        FROM db_6.dbo.employees AS e
        LEFT JOIN db_6.dbo.employeeuni AS u
            ON e.id = u.id
        ORDER BY e.name ASC

    END
