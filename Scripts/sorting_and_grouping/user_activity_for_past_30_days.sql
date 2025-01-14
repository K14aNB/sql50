/*
 User Activity For Past 30 Days 1
 --------------------------------

 Table: activity

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | int     |
| session_id    | int     |
| activity_date | date    |
| activity_type | enum    |
+---------------+---------+

 This table may have duplicate rows.
 The activity_type column is an ENUM of type('open_session', 'end_session', 'scroll_down',
 'send_message')
 The table shows the user activities for a social media website.
 Note that each session belongs to exactly one user.
*/

IF
    EXISTS (
        SELECT name FROM sys.databases
        WHERE name = 'db_24'
    )
    BEGIN
        IF
            NOT EXISTS (
                SELECT TABLE_NAME
                FROM db_24.INFORMATION_SCHEMA.TABLES
                WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'activity'
            )
            BEGIN
                CREATE TABLE db_24.dbo.activity (
                    user_id INT NOT NULL,
                    session_id INT NOT NULL,
                    activity_date DATE NOT NULL,
                    activity_type VARCHAR(20)
                    CHECK (activity_type IN (
                        'open_session',
                        'end_session',
                        'scroll_down',
                        'send_message'
                    ))
                )
            END

        IF NOT EXISTS (SELECT 1 FROM db_24.dbo.activity)
            BEGIN
                INSERT INTO db_24.dbo.activity
                VALUES (1, 1, '2019-07-20', 'open_session'),
                (1, 1, '2019-07-20', 'scroll_down'),
                (1, 1, '2019-07-20', 'end_session'),
                (2, 4, '2019-07-20', 'open_session'),
                (2, 4, '2019-07-21', 'send_message'),
                (2, 4, '2019-07-21', 'end_session'),
                (3, 2, '2019-07-21', 'open_session'),
                (3, 2, '2019-07-21', 'send_message'),
                (3, 2, '2019-07-21', 'end_session'),
                (4, 3, '2019-06-25', 'open_session'),
                (4, 3, '2019-06-25', 'end_session')
            END

            --Write a solution to find the daily active user count for a period of 30 days ending
            --2019-07-27 inclusively. A user was active on some day if they made at least one
            --activity on that day. Return the result in any order.
        SELECT
            activity_date AS day,
            COUNT(DISTINCT user_id) AS active_users
        FROM db_24.dbo.activity
        WHERE activity_date BETWEEN '2019-06-27' AND '2019-07-27'
        GROUP BY activity_date
        ORDER BY activity_date ASC

    END
