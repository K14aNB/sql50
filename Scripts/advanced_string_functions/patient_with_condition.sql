/*
 Patient With A Condition
 ------------------------
 Table: patients

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| patient_id   | int     |
| patient_name | varchar |
| conditions   | varchar |
+--------------+---------+

 patient_id is the primary key for this table.
 conditions contains 0 or more codes separated by spaces.
 This table contains information of patients in the hospital.
 */

IF
    EXISTS (
        SELECT name FROM sys.databases
        WHERE name = 'db_44'
    )
    BEGIN
        IF
            NOT EXISTS (
                SELECT TABLE_NAME
                FROM db_44.INFORMATION_SCHEMA.TABLES
                WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'patients'
            )
            BEGIN
                CREATE TABLE db_44.dbo.patients (
                    patient_id INT PRIMARY KEY,
                    patient_name VARCHAR(40) NOT NULL,
                    conditions VARCHAR(100)
                )
            END

        IF NOT EXISTS (SELECT 1 FROM db_44.dbo.patients)
            BEGIN
                INSERT INTO db_44.dbo.patients
                VALUES (1, 'Daniel', 'YFEV COUGH'),
                (2, 'Alice', NULL),
                (3, 'Bob', 'DIAB100 MYOP'),
                (4, 'George', 'ACNE DIAB100'),
                (5, 'Alain', 'DIAB201'),
                (6, 'Daniel', 'SADIAB100')
            END

            --Write a solution to find the patient_id, patient_name and conditions of the patients
            --who have Type 1 Diabetes. Type 1 Diabetes always starts with DIAB1 prefix.
            --Return the result in any order.
        SELECT
            patient_id,
            patient_name,
            conditions
        FROM db_44.dbo.patients
        WHERE conditions LIKE 'DIAB1%' OR conditions LIKE '% DIAB1%'

    END
