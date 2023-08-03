/*
System Version tables Or Temporal tables
*/

CREATE TABLE Customers
(
	CustomerID INT PRIMARY KEY,
	CustName VARCHAR(100),
	Location NVARCHAR(100),
	StartDate DATETIME2 GENERATED ALWAYS AS ROW START NOT NULL,
	EndDate DATETIME2 GENERATED ALWAYS AS ROW END NOT NULL,
	PERIOD FOR SYSTEM_TIME (StartDate,EndDate)
) 
WITH (SYSTEM_VERSIONING=ON)


ALTER TABLE Customers SET (SYSTEM_VERSIONING=OFF)
DROP TABLE [dbo].[Customers]
DROP TABLE [dbo].[MSSQL_TemporalHistoryFor_658101385]

CREATE TABLE Customers
(
CustomerID INT PRIMARY KEY,
CustName VARCHAR(100),
Location NVARCHAR(100),
StartDate DATETIME2 GENERATED ALWAYS AS ROW START NOT NULL,
EndDate DATETIME2 GENERATED ALWAYS AS ROW END NOT NULL,
PERIOD FOR SYSTEM_TIME (StartDate,EndDate)
) 
WITH 
	(
		SYSTEM_VERSIONING=ON 
		(
			HISTORY_TABLE=dbo.CustomersHistory
		)
	)

INSERT INTO Customers([CustomerID], [CustName], [Location])
VALUES(1,'AAA','USA')
INSERT INTO Customers([CustomerID], [CustName], [Location])
VALUES(2,'BBB','CANADA')
INSERT INTO Customers([CustomerID], [CustName], [Location])
VALUES(3,'CCC','FRANCE')

SELECT * FROM Customers
SELECT * FROM [dbo].[CustomersHistory]

UPDATE Customers
SET CustName='DDD'
WHERE CustomerID =3

DELETE FROM Customers
WHERE CustomerID =3
