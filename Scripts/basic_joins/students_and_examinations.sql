/*
 Students And Examinations
 -------------------------

 Table: students
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| student_id    | int     |
| student_name  | varchar |
+---------------+---------+
 student_id is the primary key for this table.
 Each row of this table contains the ID and name of one student in the school.

 Table: subjects
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| subject_name | varchar |
+--------------+---------+

 subject_name is the primary key for this table.
 Each row of this table contains the name of one subject in the school.

 Table: examinations
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| student_id   | int     |
| subject_name | varchar |
+--------------+---------+

 There is no primary key for this table. It may contain duplicates.
 Each student from students table takes every course form subjects table.
 Each row of this table indicates that student of student_id attended the exam of
 subject_name
*/

IF
    EXISTS (
        SELECT name FROM sys.databases
        WHERE name = 'db_12'
    )
    BEGIN
        IF
            NOT EXISTS (
                SELECT TABLE_NAME
                FROM db_12.INFORMATION_SCHEMA.TABLES
                WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'students'
            )
            BEGIN
                CREATE TABLE db_12.dbo.students (
                    student_id INT PRIMARY KEY,
                    student_name VARCHAR(40) NOT NULL
                )
            END

        IF
            NOT EXISTS (
                SELECT TABLE_NAME
                FROM db_12.INFORMATION_SCHEMA.TABLES
                WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'subjects'
            )
            BEGIN
                CREATE TABLE db_12.dbo.subjects (
                    subject_name VARCHAR(100) PRIMARY KEY
                )
            END

        IF
            NOT EXISTS (
                SELECT TABLE_NAME
                FROM db_12.INFORMATION_SCHEMA.TABLES
                WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'examinations'
            )
            BEGIN
                CREATE TABLE db_12.dbo.examinations (
                    student_id INT FOREIGN KEY
                    REFERENCES db_12.dbo.students (student_id),
                    subject_name VARCHAR(100) FOREIGN KEY
                    REFERENCES db_12.dbo.subjects (subject_name)
                )
            END

        IF NOT EXISTS (SELECT 1 FROM db_12.dbo.students)
            BEGIN
                INSERT INTO db_12.dbo.students
                VALUES (1, 'Alice'),
                (2, 'Bob'),
                (13, 'John'),
                (6, 'Alex')
            END

        IF NOT EXISTS (SELECT 1 FROM db_12.dbo.subjects)
            BEGIN
                INSERT INTO db_12.dbo.subjects
                VALUES ('Math'),
                ('Physics'),
                ('Programming')
            END

        IF NOT EXISTS (SELECT 1 FROM db_12.dbo.examinations)
            BEGIN
                INSERT INTO db_12.dbo.examinations
                VALUES (1, 'Math'),
                (1, 'Physics'),
                (1, 'Programming'),
                (2, 'Programming'),
                (1, 'Physics'),
                (1, 'Math'),
                (13, 'Math'),
                (13, 'Programming'),
                (13, 'Physics'),
                (2, 'Math'),
                (1, 'Math')
            END

            --Write a solution to find the number of times each student attended each exam.
            --Return the result ordered by student_id and subject_name.
        SELECT
            st.student_id,
            st.student_name,
            sb.subject_name,
            COUNT(e.subject_name) AS attended_exams
        FROM db_12.dbo.students AS st
        CROSS JOIN db_12.dbo.subjects AS sb
        LEFT JOIN db_12.dbo.examinations AS e
            ON st.student_id = e.student_id AND sb.subject_name = e.subject_name
        GROUP BY st.student_id, st.student_name, sb.subject_name
        ORDER BY st.student_id ASC, sb.subject_name ASC

    END
