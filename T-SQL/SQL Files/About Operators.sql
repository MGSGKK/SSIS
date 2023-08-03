/*
Operators
*/

/*
Arthametic Operators
	+,-,*,/,%
*/

SELECT 25+25
SELECT 50-25
SELECT 2*2
SELECT 4/2
SELECT 4%2

USE AdventureWorks2016
go
SELECT SalesOrderID,SubTotal+TaxAmt+Freight FROM Sales.SalesOrderHeader


/*
Logical Operators
*/

SELECT * FROM Sales.SalesOrderHeader
WHERE TotalDue>15000 AND Freight>1000 AND SubTotal>15000


SELECT * FROM Sales.SalesOrderDetail
WHERE UnitPrice=5.00 OR ProductID=711


SELECT * FROM Sales.SalesOrderDetail
WHERE ProductID=711

SELECT * FROM Sales.SalesOrderDetail
WHERE ProductID IN (711,712,713,714,715)

SELECT * FROM Sales.SalesOrderDetail
WHERE ProductID NOT IN (711,712,713,714,715)

/*
Comparison Operators
	=,!=,<,>,<=,>=,<!,!>,<>
*/
SELECT * FROM Sales.SalesOrderDetail
WHERE ProductID=711

SELECT * FROM Sales.SalesOrderDetail
WHERE ProductID!=711

SELECT * FROM Sales.SalesOrderDetail
WHERE ProductID<>711


/*
Special Operators
	
*/

SELECT * FROM Sales.SalesOrderDetail
WHERE ProductID IN (711,712,713,714,715)

SELECT * FROM Sales.SalesOrderDetail
WHERE ProductID BETWEEN 711 AND 720

SELECT * FROM Sales.SalesOrderDetail
WHERE CarrierTrackingNumber IS NULL 


SELECT * FROM Person.EmailAddress

SELECT * FROM Person.EmailAddress
WHERE EmailAddress LIKE 'a%'

SELECT * FROM Person.EmailAddress
WHERE EmailAddress LIKE '%m'

SELECT * FROM Person.EmailAddress
WHERE EmailAddress LIKE '%j%'


SELECT * FROM Person.EmailAddress
WHERE EmailAddress LIKE 'r_b%'

SELECT * FROM Person.EmailAddress
WHERE EmailAddress LIKE '%[@.,:-]%'

/*
Set Operator
*/

/*
UNION 
	UNION It Will Return Unique Records Means it Will Avoid Duplicates
*/

CREATE TABLE #Temp1
(
ID INT 
)

CREATE TABLE #Temp2
(
ID INT 
)

INSERT INTO #Temp1(ID)
VALUES(1),(2),(3),(4),(5),(2)

INSERT INTO #Temp2(ID)
VALUES(8),(7),(1),(6),(5),(2)


SELECT * FROM #Temp1
SELECT * FROM #Temp2

SELECT * FROM #Temp1
UNION 
SELECT * FROM #Temp2


/*
UNION ALL
	UNION It Will Return All Records From All Datasets. Include Duplicates
*/


SELECT * FROM #Temp1
SELECT * FROM #Temp2

SELECT * FROM #Temp1
UNION ALL
SELECT * FROM #Temp2

/*
INTERSECT
	Intersect Will Return Common Recrods Between All Datasets
*/

SELECT * FROM #Temp1
SELECT * FROM #Temp2

SELECT * FROM #Temp1
INTERSECT
SELECT * FROM #Temp2

/*
EXCEPT
	Except Will Return the Records Form First Dataset Which are the Recrods not there in 2nd Dataset
*/

SELECT * FROM #Temp1
SELECT * FROM #Temp2

SELECT * FROM #Temp1
EXCEPT
SELECT * FROM #Temp2



SELECT * FROM #Temp2
EXCEPT
SELECT * FROM #Temp1

/*
Assignment Operators
*/

DECLARE @A1 INT,@B1 INT
SET @A1=10
SET @B1=@A1
SELECT @B1

