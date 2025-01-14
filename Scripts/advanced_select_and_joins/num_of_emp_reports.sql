/*
 Number of Employees Which Report to Each Employee
 -------------------------------------------------

 Table: employees

+-------------+----------+
| Column Name | Type     |
+-------------+----------+
| employee_id | int      |
| name        | varchar  |
| reports_to  | int      |
| age         | int      |
+-------------+----------+

 employee_id is the primary key for this table.
 This table contains information about the employees and the id of the manager they
 report to. Some employees do not report to anyone.

 Manager is an employee who has at least 1 other employee reporting to them.
*/

IF
    EXISTS (
        SELECT name FROM sys.databases
        WHERE name = 'db_30'
    )
    BEGIN
        IF
            NOT EXISTS (
                SELECT TABLE_NAME
                FROM db_30.INFORMATION_SCHEMA.TABLES
                WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'employees'
            )
            BEGIN
                CREATE TABLE db_30.dbo.employees (
                    employee_id INT PRIMARY KEY,
                    name VARCHAR(40) NOT NULL,
                    reports_to INT,
                    age TINYINT NOT NULL
                )
            END

        IF NOT EXISTS (SELECT 1 FROM db_30.dbo.employees)
            BEGIN
                INSERT INTO db_30.dbo.employees
                VALUES (9, 'Hercy', NULL, 43),
                (6, 'Alice', 9, 41),
                (4, 'Bob', 9, 36),
                (2, 'Winston', NULL, 37)
            END

            --Write a solution to report ids and the names of all managers, the number of employees
            --who report directly to them, and the average age of reports rounded to the nearest
            --integer. Return the result ordered by employee_id.
        SELECT
            e1.employee_id,
            e1.name,
            COUNT(e2.reports_to) AS report_counts,
            ROUND(AVG(CAST(e2.age AS DECIMAL(4, 2))), 0) AS average_age
        FROM db_30.dbo.employees AS e1
        INNER JOIN db_30.dbo.employees AS e2
            ON e1.employee_id = e2.reports_to
        GROUP BY e1.employee_id, e1.name
        ORDER BY e1.employee_id ASC

    END
