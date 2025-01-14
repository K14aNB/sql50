/*
 Number of Unique Subjects Taught by Each Teacher
 ------------------------------------------------

 Table: teacher

+-------------+------+
| Column Name | Type |
+-------------+------+
| teacher_id  | int  |
| subject_id  | int  |
| dept_id     | int  |
+-------------+------+

 (subject_id, dept_id) is the primary key combination for this table.
 Each row in this table indicates that the teacher with teacher_id teaches the subject
 subject_id in the department dept_id.
*/

IF
    EXISTS (
        SELECT name FROM sys.databases
        WHERE name = 'db_23'
    )
    BEGIN
        IF
            NOT EXISTS (
                SELECT TABLE_NAME
                FROM db_23.INFORMATION_SCHEMA.TABLES
                WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'teacher'
            )
            BEGIN
                CREATE TABLE db_23.dbo.teacher (
                    teacher_id INT NOT NULL,
                    subject_id INT,
                    dept_id INT,
                    PRIMARY KEY (subject_id, dept_id)
                )
            END

        IF NOT EXISTS (SELECT 1 FROM db_23.dbo.teacher)
            BEGIN
                INSERT INTO db_23.dbo.teacher
                VALUES (1, 2, 3),
                (1, 2, 4),
                (1, 3, 3),
                (2, 1, 1),
                (2, 2, 1),
                (2, 3, 1),
                (2, 4, 1)
            END

            --Write a solution to calculate the number of unique subjects each teacher teaches
            --in the university. Return the result in any order.
        SELECT
            teacher_id,
            COUNT(DISTINCT subject_id) AS cnt
        FROM db_23.dbo.teacher
        GROUP BY teacher_id
        ORDER BY teacher_id ASC

    END
