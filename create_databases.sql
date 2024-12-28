/*
 Script for creating databases
*/

DECLARE @db_name VARCHAR(15)
SET @db_name = 'db_'
DECLARE @counter INT
SET @counter = 1
DECLARE @database_name VARCHAR(15)
WHILE @counter <= 50
BEGIN
SET @database_name = @db_name + CAST(@counter AS CHAR(2))
IF NOT EXISTS(SELECT name FROM sys.databases WHERE name = @database_name)
BEGIN
EXEC('CREATE DATABASE ' + @database_name)
END
SET @counter = @counter + 1
END