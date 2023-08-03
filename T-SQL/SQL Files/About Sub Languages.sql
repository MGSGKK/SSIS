/*
Sub Languages
*/

/*
DDL
	Data Defination Language
		A) CREATE
		B) ALTER
		C) DROP
		D) TRUNCATE
*/

---CREATE

CREATE TABLE Employee
(
EMPID INT,
EMPName VARCHAR(100),
Salary MONEY,
Gender CHAR(6),
DeptID INT
)

CREATE TABLE Department 
(
DeptID INT,
DeptName VARCHAR(50)
)

CREATE VIEW

CREATE PROCEDURE

CREATE FUNCTION

CREATE TRIGGER

CREATE INDEX

--ALTER

ALTER TABLE Employee
ADD DOB DATE

ALTER TABLE Employee
ADD [Gender] CHAR(50)

ALTER TABLE Employee
ALTER COLUMN [Gender] CHAR(50)

ALTER TABLE Employee
DROP COLUMN [Gender]
ALTER VIEW

ALTER PROCEDURE

ALTER FUNCTION

ALTER TRIGGER

---DROP
DROP TABLE [dbo].[Department]
DROP TABLE [dbo].Employee

DROP VIEW 
DROP PROCEDURE
DROP FUNCTION
DROP TRIGGER

--TRUNCATE

SELECT * FROM Employee

TRUNCATE TABLE Employee

/*
DML
	Data Manipulation Language
		A) INSERT
		B) UPDATE
		C) DELETE
*/

SELECT * FROM Employee
/*
INSERT

				Syntax:
				INSERT INTO <TableName>(Column1,Column2,etc..)
				VALUES(Value1,Valu2,etc...)
*/

INSERT INTO Employee([EMPID], [EMPName], [Salary], [Gender], [DeptID])
VALUES(1,'Abhilash',45000,'Male',1)
INSERT INTO Employee([EMPID], [EMPName], [Salary], [Gender], [DeptID])
VALUES(2,'Abhidunnisa',75000,'FeMale',1)
INSERT INTO Employee([EMPID], [EMPName], [Salary], [Gender], [DeptID])
VALUES(3,'Ravindra',55000,'Male',1)
INSERT INTO Employee([EMPID], [EMPName], [Salary], [Gender], [DeptID])
VALUES(4,'RajaMouli',58000,'Male',1)

INSERT INTO Employee([EMPID], [EMPName], [Salary], [Gender], [DeptID])
VALUES(1,'Abhilash',45000,'Male',1),(2,'Abhidunnisa',75000,'FeMale',1),
(3,'Ravindra',55000,'Male',1),
(4,'RajaMouli',58000,'Male',1)

SELECT * FROM Employee

/*
UPDATE
					Syntax:
					UPDATE <TableName>
					SET <ColumnName>=<Value>,
						<ColumnName2>=<Value>,etc..
					WHERE <Condition>
*/
SELECT * FROM Employee

UPDATE Employee
SET Salary=65000
WHERE EMPID=2

UPDATE Employee
SET Salary=65000

/*
	DELETE 
				Syntax:
					DELETE FROM <TableName>
					WHERE <Condition>
*/

SELECT * FROM Employee

DELETE FROM Employee
WHERE EMPID=3

DELETE FROM Employee

/*
DQL
	Data Query Langage
		A) SELECT
*/

SELECT * FROM Employee

SELECT EMPID,EMPName,Gender
FROM Employee


--SCHEMA
CREATE SCHEMA EMPDetails
GO

SELECT * FROM sys.schemas

CREATE TABLE EMPDetails.Employee
(
EMPID INT,
EMPName VARCHAR(100),
Salary MONEY,
Gender CHAR(6),
DeptID INT
)


/*
TCL
	Transaction Control Language
		A) COMMIT
		B) ROLLBACK
		C) Save Point
*/

BEGIN TRANSACTION
DELETE FROM Employee

ROLLBACK


SELECT * FROM Employee

BEGIN TRAN

UPDATE Employee
SET Salary=65000
WHERE EMPID=2

COMMIT

UPDATE Employee
SET Gender='Male'
WHERE EMPID=1
