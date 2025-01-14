/*
 Employees Whose Manager Left Company
 ------------------------------------

 Table: employees

+-------------+----------+
| Column Name | Type     |
+-------------+----------+
| employee_id | int      |
| name        | varchar  |
| manager_id  | int      |
| salary      | int      |
+-------------+----------+

 In SQL, employee_id is the primary key for this table.
 This table contains information about the employees, their salary and ID of their
 manager. Some employees do not have managers.
*/

IF
    EXISTS (
        SELECT name FROM sys.databases
        WHERE name = 'db_37'
    )
    BEGIN
        IF
            NOT EXISTS (
                SELECT TABLE_NAME
                FROM db_37.INFORMATION_SCHEMA.TABLES
                WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'employees'
            )
            BEGIN
                CREATE TABLE db_37.dbo.employees (
                    employee_id INT PRIMARY KEY,
                    name VARCHAR(40) NOT NULL,
                    manager_id INT,
                    salary INT NOT NULL
                )
            END

        IF NOT EXISTS (SELECT 1 FROM db_37.dbo.employees)
            BEGIN
                INSERT INTO db_37.dbo.employees
                VALUES (3, 'Mila', 9, 60301),
                (12, 'Antonella', NULL, 31000),
                (13, 'Emery', NULL, 67084),
                (1, 'Kalel', 11, 21241),
                (9, 'Mikela', NULL, 50937),
                (11, 'Joziah', 6, 28485)
            END

            --Find the IDS of the employees whose salary is strictly less than $30000 and whose
            --manager left the company. When a manager leaves the company, their information is
            --deleted from employees table, but reports still have their manager_id set to the
            --manager that left. Return the result ordered by employee_id.
        SELECT employee_id
        FROM db_37.dbo.employees
        WHERE salary < 30000
            AND manager_id NOT IN (
                SELECT employee_id
                FROM db_37.dbo.employees
            )
        ORDER BY employee_id ASC

    END
