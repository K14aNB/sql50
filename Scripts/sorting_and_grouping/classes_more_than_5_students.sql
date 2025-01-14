/*
 Classes More Than 5 Students
 ----------------------------

 Table: courses

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| student     | varchar |
| class       | varchar |
+-------------+---------+

 (student, class) is the primary key combination for this table.
 Each row of this table indicates the name of the student and
 the class they are enrolled.
*/

IF EXISTS(SELECT name
          FROM sys.databases
          WHERE name = 'db_26')
BEGIN
IF NOT EXISTS(SELECT TABLE_NAME
              FROM db_26.INFORMATION_SCHEMA.TABLES
              WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'courses')
BEGIN
CREATE TABLE db_26.dbo.courses(student VARCHAR(40),
                               class VARCHAR(20),
                               PRIMARY KEY(student, class))
END

IF NOT EXISTS(SELECT 1 FROM db_26.dbo.courses)
BEGIN
INSERT INTO db_26.dbo.courses
VALUES('A', 'Math'),
('B', 'English'),
('C', 'Math'),
('D', 'Biology'),
('E', 'Math'),
('F', 'Computer'),
('G', 'Math'),
('H', 'Math'),
('I', 'Math')
END

--Write a solution to find all the classes that have at least five students.
--Return the result table in any order.
;WITH cte2 AS
(
    SELECT class,
    ROW_NUMBER() OVER(PARTITION BY class ORDER BY student ASC) AS row_no
    FROM db_26.dbo.courses
)
SELECT DISTINCT class FROM cte2
WHERE row_no >= 5
ORDER BY class ASC

END