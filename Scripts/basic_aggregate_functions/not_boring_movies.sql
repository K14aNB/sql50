/*
 Not Boring Movies
 -----------------

 Table: cinema

+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| id             | int      |
| movie          | varchar  |
| description    | varchar  |
| rating         | float    |
+----------------+----------+

 id is the primary key for this table.
 Each row contains information about the name of a movie, it's genre and rating.
 rating is a 2 decimal place float in range [0, 10]
*/

IF
    EXISTS (
        SELECT name FROM sys.databases
        WHERE name = 'db_15'
    )
    BEGIN
        IF
            NOT EXISTS (
                SELECT TABLE_NAME
                FROM db_15.INFORMATION_SCHEMA.TABLES
                WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'cinema'
            )
            BEGIN
                CREATE TABLE db_15.dbo.cinema (
                    id INT PRIMARY KEY,
                    movie VARCHAR(50) NOT NULL,
                    description VARCHAR(150) NOT NULL,
                    rating DECIMAL(4, 2) NOT NULL
                )
            END

        IF NOT EXISTS (SELECT 1 FROM db_15.dbo.cinema)
            BEGIN
                INSERT INTO db_15.dbo.cinema
                VALUES (1, 'War', 'great 3D', 8.9),
                (2, 'Science', 'fiction', 8.5),
                (3, 'irish', 'boring', 6.2),
                (4, 'Ice song', 'Fantacy', 8.6),
                (5, 'House card', 'Interesting', 9.1)
            END

            --Write a solution to report the movies with odd-numbered ID and a description that is
            --not "boring". Return the result ordered by rating in descending order.
        SELECT
            id,
            movie,
            description,
            rating
        FROM db_15.dbo.cinema
        WHERE id % 2 <> 0
            AND description NOT LIKE '%boring%'
            AND description NOT LIKE 'Boring%'
            AND description NOT LIKE '%boring'
        ORDER BY rating DESC

    END
