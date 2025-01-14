/*
 Big Countries
 -------------

 Table: world

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| name        | varchar |
| continent   | varchar |
| area        | int     |
| population  | int     |
| gdp         | bigint  |
+-------------+---------+

 name is the primary key for this table.
 Each row of this table gives information about the name of a country, the continent,
 area, the population and its GDP value.

 A country is considered big if:
 * it has area of at least 3,000,000 km2
 * it has a population of at least 25,000,000.
*/

IF
    EXISTS (
        SELECT name
        FROM sys.databases
        WHERE name = 'db_3'
    )
    BEGIN
        IF
            NOT EXISTS (
                SELECT TABLE_NAME
                FROM db_3.INFORMATION_SCHEMA.TABLES
                WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'world'
            )
            BEGIN
                CREATE TABLE db_3.dbo.world (
                    name VARCHAR(50) PRIMARY KEY,
                    continent VARCHAR(40) NOT NULL,
                    area INT NOT NULL,
                    population INT NOT NULL,
                    gdp BIGINT NOT NULL
                )
            END

        IF NOT EXISTS (SELECT 1 FROM db_3.dbo.world)
            BEGIN
                INSERT INTO db_3.dbo.world
                VALUES ('Afghanistan', 'Asia', 652230, 25500100, 20343000000),
                ('Albania', 'Europe', 28748, 2831741, 12960000000),
                ('Algeria', 'Africa', 2381741, 37100000, 188681000000),
                ('Andorra', 'Europe', 468, 78115, 3712000000),
                ('Angola', 'Africa', 1246700, 20609294, 100990000000)
            END

            --Write a solution to find the name, population and area of the big countries.
            --Return result in any order.
        SELECT
            name,
            population,
            area
        FROM db_3.dbo.world
        WHERE area >= 3000000 OR population >= 25000000

    END
