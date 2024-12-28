/*
 Article Views 1
 ---------------

 Table: views

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| article_id    | int     |
| author_id     | int     |
| viewer_id     | int     |
| view_date     | date    |
+---------------+---------+

 There is no primary key for this table.
 Each row of this table indicates that some viewer viewed an article on some date.
 Note that equal author_id and viewer_id indicate the same person.
*/

IF EXISTS(SELECT name FROM sys.databases WHERE name = 'db_4')
BEGIN
IF NOT EXISTS(SELECT TABLE_NAME
              FROM db_4.INFORMATION_SCHEMA.TABLES
              WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'views')
BEGIN
CREATE TABLE db_4.dbo.views(article_id INT NOT NULL,
                            author_id INT NOT NULL,
                            viewer_id INT NOT NULL,
                            view_date DATE NOT NULL)
END

IF NOT EXISTS(SELECT 1 FROM db_4.dbo.views)
BEGIN
INSERT INTO db_4.dbo.views
VALUES(1, 3, 5, '2019-08-01'),
(1, 3, 6, '2019-08-02'),
(2, 7, 7, '2019-08-01'),
(2, 7, 6, '2019-08-02'),
(4, 7, 1, '2019-07-22'),
(3, 4, 4, '2019-07-21'),
(3, 4, 4, '2019-07-21')
END

--Write a solution to find all authors that viewed at least one of their articles.
--Return the result sorted by id in ascending order.
SELECT DISTINCT author_id AS id
FROM db_4.dbo.views
WHERE author_id = viewer_id
ORDER BY id ASC
END