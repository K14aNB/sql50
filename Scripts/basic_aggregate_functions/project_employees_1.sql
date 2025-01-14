/*
 Project Employees 1
 -------------------

 Table: project

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| project_id  | int     |
| employee_id | int     |
+-------------+---------+

 (project_id, employee_id) is the primary key for this table.
 employee_id is the foreign key to employee table.
 Each row of this table indicates that the employee with employee_id is working on the
 project with project_id.

 Table: employee

+------------------+---------+
| Column Name      | Type    |
+------------------+---------+
| employee_id      | int     |
| name             | varchar |
| experience_years | int     |
+------------------+---------+

 employee_id is the primary key for this table.
 It is guarenteed that experience_years is not NULL.
 Each row of this table contains information about one employee.
*/

IF
    EXISTS (
        SELECT name FROM sys.databases
        WHERE name = 'db_17'
    )
    BEGIN
        IF
            NOT EXISTS (
                SELECT TABLE_NAME
                FROM db_17.INFORMATION_SCHEMA.TABLES
                WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'employee'
            )
            BEGIN
                CREATE TABLE db_17.dbo.employee (
                    employee_id INT PRIMARY KEY,
                    name VARCHAR(40) NOT NULL,
                    experience_years INT NOT NULL
                )
            END

        IF
            NOT EXISTS (
                SELECT TABLE_NAME
                FROM db_17.INFORMATION_SCHEMA.TABLES
                WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'project'
            )
            BEGIN
                CREATE TABLE db_17.dbo.project (
                    project_id INT,
                    employee_id INT
                    FOREIGN KEY REFERENCES
                    db_17.dbo.employee (employee_id)
                    PRIMARY KEY (project_id, employee_id)
                )
            END

        IF NOT EXISTS (SELECT 1 FROM db_17.dbo.employee)
            BEGIN
                INSERT INTO db_17.dbo.employee
                VALUES (1, 'Khaled', 3),
                (2, 'Ali', 2),
                (3, 'John', 1),
                (4, 'Doe', 2)
            END

        IF NOT EXISTS (SELECT 1 FROM db_17.dbo.project)
            BEGIN
                INSERT INTO db_17.dbo.project
                VALUES (1, 1),
                (1, 2),
                (1, 3),
                (2, 1),
                (2, 4)
            END

            --Write SQL query that reports the average years of experience of all employees for each
            --project, rounded to 2 decimal places. Return the result in any order.
        SELECT
            p.project_id,
            AVG(CAST(e.experience_years AS DECIMAL(6, 2))) AS average_years
        FROM db_17.dbo.employee AS e
        INNER JOIN db_17.dbo.project AS p
            ON e.employee_id = p.employee_id
        GROUP BY p.project_id
        ORDER BY p.project_id

    END
