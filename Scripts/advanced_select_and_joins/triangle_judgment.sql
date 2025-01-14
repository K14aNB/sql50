/*
 Triangle Judgement
 ------------------

 Table: triangle

+-------------+------+
| Column Name | Type |
+-------------+------+
| x           | int  |
| y           | int  |
| z           | int  |
+-------------+------+

 In SQL, (x, y, z) is the primary key combination for the table.
 Each row of this table contains the lengths of three line segments.
*/

IF
    EXISTS (
        SELECT name FROM sys.databases
        WHERE name = 'db_32'
    )
    BEGIN
        IF
            NOT EXISTS (
                SELECT TABLE_NAME
                FROM db_32.INFORMATION_SCHEMA.TABLES
                WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'triangle'
            )
            BEGIN
                CREATE TABLE db_32.dbo.triangle (
                    x INT, y INT, z INT, PRIMARY KEY (x, y, z)
                )
            END

        IF NOT EXISTS (SELECT 1 FROM db_32.dbo.triangle)
            BEGIN
                INSERT INTO db_32.dbo.triangle
                VALUES (13, 15, 30),
                (10, 20, 15)
            END

            --Report every three line segments whether they can form a triangle.
            --Return the result in any order.
        SELECT
            x,
            y,
            z,
            (CASE WHEN (x + y > z) AND (x + z > y) AND (y + z > x) THEN 'Yes'
                ELSE 'No'
            END) AS triangle
        FROM db_32.dbo.triangle

    END
