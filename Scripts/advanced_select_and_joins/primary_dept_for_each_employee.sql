/*
 Primary Department For Each Employee
 ------------------------------------

 Table: employee

+---------------+---------+
| Column Name   |  Type   |
+---------------+---------+
| employee_id   | int     |
| department_id | int     |
| primary_flag  | varchar |
+---------------+---------+

 (employee_id, department_id) is the primary key combination for this table.
 employee_id is the id of the employee.
 department_id is the id of the department to which the employee belongs to.
 primary_flag is an ENUM of type ('Y', 'N'). If the flag is 'Y', the department is the
 primary department for the employee. If the flag is 'N', the department is not the
 primary department for the employee.

 Employees can belong to multiple departments. When employee joins other department,
 they need to decide which department is their primary department. Note that when
 an employee belongs to only one department, their primary column is 'N'.
*/

IF
    EXISTS (
        SELECT name FROM sys.databases
        WHERE name = 'db_31'
    )
    BEGIN
        IF
            NOT EXISTS (
                SELECT TABLE_NAME
                FROM db_31.INFORMATION_SCHEMA.TABLES
                WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'employee'
            )
            BEGIN
                CREATE TABLE db_31.dbo.employee (
                    employee_id INT,
                    department_id INT,
                    primary_flag CHAR(1) CHECK (primary_flag IN ('Y', 'N')),
                    PRIMARY KEY (employee_id, department_id)
                )
            END

        IF NOT EXISTS (SELECT 1 FROM db_31.dbo.employee)
            BEGIN
                INSERT INTO db_31.dbo.employee
                VALUES (1, 1, 'N'),
                (2, 1, 'Y'),
                (2, 2, 'N'),
                (3, 3, 'N'),
                (4, 2, 'N'),
                (4, 3, 'Y'),
                (4, 4, 'N')
            END

            --Write a solution to report all the employees with their primary department.
            --For employees who belong to one department, report only their department.
            ; WITH cte AS (
            SELECT employee_id
            FROM db_31.dbo.employee
            GROUP BY employee_id
            HAVING COUNT(employee_id) = 1
        )

        SELECT
            employee_id,
            department_id
        FROM db_31.dbo.employee
        WHERE employee_id IN (SELECT employee_id FROM cte)
            OR primary_flag = 'Y'
        ORDER BY employee_id ASC

    END
