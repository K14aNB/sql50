/*
 Invalid Tweets
 --------------

 Table: tweets

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| tweet_id       | int     |
| content        | varchar |
+----------------+---------+

 tweet_id is the primary key for this table.
 content consists of characters on an American keyboard and no other special characters.
 This table contains all tweets in a social media app.
*/

IF
    EXISTS (
        SELECT name FROM sys.databases
        WHERE name = 'db_5'
    )
    BEGIN
        IF
            NOT EXISTS (
                SELECT TABLE_NAME
                FROM db_5.INFORMATION_SCHEMA.TABLES
                WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'tweets'
            )
            BEGIN
                CREATE TABLE db_5.dbo.tweets (
                    tweet_id INT PRIMARY KEY, content VARCHAR(140) NOT NULL
                )
            END

        IF NOT EXISTS (SELECT 1 FROM db_5.dbo.tweets)
            BEGIN
                INSERT INTO db_5.dbo.tweets
                VALUES (1, 'Let us Code'),
                (2, 'More than fifteen chars are here!')
            END

            --Write a solution to find the IDs of invalid tweets. The tweet is invalid if the number
            --of characters used in the content is strictly greater than 15.
            --Return the result in any order.
        SELECT tweet_id
        FROM db_5.dbo.tweets
        WHERE LEN(content) > 15
    END
