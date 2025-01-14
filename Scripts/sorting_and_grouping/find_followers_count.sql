/*
 Find Followers Count
 --------------------

 Table: followers

+-------------+------+
| Column Name | Type |
+-------------+------+
| user_id     | int  |
| follower_id | int  |
+-------------+------+

 (user_id, follower_id) is the primary key combination for this table.
 This table contains IDs of a user and a follower in a social media app where the
 follower follows the user.
*/

IF
    EXISTS (
        SELECT name FROM sys.databases
        WHERE name = 'db_27'
    )
    BEGIN
        IF
            NOT EXISTS (
                SELECT TABLE_NAME
                FROM db_27.INFORMATION_SCHEMA.TABLES
                WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'followers'
            )
            BEGIN
                CREATE TABLE db_27.dbo.followers (
                    user_id INT,
                    follower_id INT,
                    PRIMARY KEY (user_id, follower_id)
                )
            END

        IF NOT EXISTS (SELECT 1 FROM db_27.dbo.followers)
            BEGIN
                INSERT INTO db_27.dbo.followers
                VALUES (0, 1),
                (1, 0),
                (2, 0),
                (2, 1)
            END

            --Write a solution that will, for each user, return the number of followers.
            --Return the result table orderd by user_id in ascending order.
        SELECT
            user_id,
            COUNT(follower_id) AS followers_count
        FROM db_27.dbo.followers
        GROUP BY user_id
        ORDER BY user_id ASC

    END
