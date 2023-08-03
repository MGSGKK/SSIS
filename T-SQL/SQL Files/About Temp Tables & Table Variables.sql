/*
Temp Tables
*/

CREATE TABLE #Sales
(
SaleID INT,
SaleAmount MONEY
)

SELECT * FROM #Sales


CREATE TABLE ##Sales
(
SaleID INT,
SaleAmount MONEY
)

SELECT * FROM ##Sales


SELECT *
INTO #SalesOrderDetails
FROM Sales.SalesOrderDetail

SELECT * FROM #SalesOrderDetails


SELECT *
INTO #SalesOrders
FROM Sales.SalesOrderDetail
WHERE 1=2


SELECT * FROM #SalesOrders


SELECT *
INTO SalesOrders
FROM Sales.SalesOrderDetail
WHERE 1=2

SELECT *
INTO #SalesOrderDetails
FROM Sales.SalesOrderDetail


SELECT 
ProductID,SUM(LineTotal) As TotaAmount
FROM #SalesOrderDetails
GROUP BY ProductID


SELECT 
ProductID,MAX(LineTotal) As mAXTotaAmount
FROM #SalesOrderDetails
GROUP BY ProductID

SELECT 
ProductID,MIN(LineTotal) As mAXTotaAmount
FROM #SalesOrderDetails
GROUP BY ProductID


--Table Variables

DECLARE @Number INT,@String VARCHAR(100)

DECLARE @RecordCount BIGINT

SELECT @RecordCount=COUNT(*)
FROM Sales.SalesOrderDetail

SET @RecordCount=(SELECT COUNT(*)
FROM Sales.SalesOrderDetail)

PRINT 'The Table Is Having the No of Records :'+ CONVERT(VARCHAR(10),@RecordCount)


DECLARE @ProdcutInfo TABLE
(
ProdId INT ,
ProdName VARCHAR(100)
)

INSERT INTO @ProdcutInfo(ProdId,ProdName)
VALUES(1,'Mobiles')
INSERT INTO @ProdcutInfo(ProdId,ProdName)
VALUES(2,'TvS')

SELECT * FROM @ProdcutInfo
