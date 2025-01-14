/*
 Employee Bonus
 --------------

 Table: employee

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| empId       | int     |
| name        | varchar |
| supervisor  | int     |
| salary      | int     |
+-------------+---------+

 empId is the primary key for this table.
 Each row of this table indicates the name and the ID of an employee in addition to
 their salary and id of their manager.

 Table: bonus

+-------------+------+
| Column Name | Type |
+-------------+------+
| empId       | int  |
| bonus       | int  |
+-------------+------+

 empId is the foreign key for this table.
 Each row of this table contains the id of an employee and their respective bonus.
*/

IF
    EXISTS (
        SELECT name FROM sys.databases
        WHERE name = 'db_11'
    )
    BEGIN
        IF
            NOT EXISTS (
                SELECT TABLE_NAME
                FROM db_11.INFORMATION_SCHEMA.TABLES
                WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'employee'
            )
            BEGIN
                CREATE TABLE db_11.dbo.employee (
                    empid INT PRIMARY KEY,
                    name VARCHAR(40) NOT NULL,
                    supervisor INT,
                    salary INT NOT NULL
                )
            END

        IF
            NOT EXISTS (
                SELECT TABLE_NAME
                FROM db_11.INFORMATION_SCHEMA.TABLES
                WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'bonus'
            )
            BEGIN
                CREATE TABLE db_11.dbo.bonus (
                    empid INT FOREIGN KEY REFERENCES db_11.dbo.employee (empid),
                    bonus INT NOT NULL
                )
            END

        IF NOT EXISTS (SELECT 1 FROM db_11.dbo.employee)
            BEGIN
                INSERT INTO db_11.dbo.employee
                VALUES (3, 'Brad', NULL, 4000),
                (1, 'John', 3, 1000),
                (2, 'Dan', 3, 2000),
                (4, 'Thomas', 3, 4000)
            END

        IF NOT EXISTS (SELECT 1 FROM db_11.dbo.bonus)
            BEGIN
                INSERT INTO db_11.dbo.bonus
                VALUES (2, 500),
                (4, 2000)
            END

            --Write a solution to report the name and bonus amount of each employee with a bonus
            --less than 1000.
        SELECT
            e.name,
            b.bonus
        FROM db_11.dbo.employee AS e
        LEFT JOIN db_11.dbo.bonus AS b
            ON e.empid = b.empid
        WHERE b.bonus < 1000 OR b.bonus IS NULL
        ORDER BY b.bonus
    END
