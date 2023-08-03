/*
Aggregate Functions
*/

--SUM

SELECT * FROM Sales.SalesOrderDetail
SELECT * FROM Sales.SalesOrderHeader	

SELECT ProductID,SUM(LineTotal) AS TotalSales
FROM Sales.SalesOrderDetail
GROUP BY ProductID
ORDER BY ProductID


--MAX

SELECT ProductID,MAX(LineTotal) AS MAxSales
FROM Sales.SalesOrderDetail
GROUP BY ProductID
ORDER BY ProductID

SELECT * FROM Sales.SalesOrderDetail
WHERE ProductID=707
ORDER BY LineTotal DESC


--MIN

SELECT ProductID,MIN(LineTotal) AS MAxSales
FROM Sales.SalesOrderDetail
GROUP BY ProductID
ORDER BY ProductID

SELECT * FROM Sales.SalesOrderDetail
WHERE ProductID=707
ORDER BY LineTotal 

---AVG
SELECT ProductID,AVG(LineTotal) AS MAxSales
FROM Sales.SalesOrderDetail
GROUP BY ProductID
ORDER BY ProductID

SELECT * FROM Sales.SalesOrderDetail
WHERE ProductID=707
ORDER BY LineTotal 


---COUNT 

SELECT COUNT(*) FROM Sales.SalesOrderDetail

SELECT COUNT(*) FROM Person.Person

SELECT FirstName,MiddleName,LastName FROM Person.Person

SELECT COUNT(FirstName),COUNT(MiddleName),COUNT(LastName) FROM Person.Person

SELECT COUNT(DISTINCT ProductID) FROM Sales.SalesOrderDetail

/*
DATETIME Functions
*/

---GETDATE()

SELECT GETDATE()

SELECT GETUTCDATE()

--DATEADD
SELECT DATEADD(DAY,1,GETDATE())
SELECT DATEADD(MONTH,1,GETDATE())
SELECT DATEADD(YEAR,1,GETDATE())
SELECT DATEADD(HOUR,1,GETDATE())
SELECT DATEADD(YEAR,-1,GETDATE())


SELECT OrderDate,DATEADD(DAY,5,OrderDate) AS DelivryDate
FROM Sales.SalesOrderHeader

---DATEDIFF

DECLARE @StartDate DATE, @EndDate DATE
SET @StartDate='2020-03-31'
SET @EndDate=GETDATE()

SELECT DATEDIFF(DAY,@StartDate,@EndDate)

SELECT DATEDIFF(MONTH,@StartDate,@EndDate)

SELECT DATEDIFF(YEAR,@StartDate,@EndDate)

SELECT OrderDate,ShipDate,DATEDIFF(DAY,OrderDate,ShipDate) AS NoOfDays
FROM Sales.SalesOrderHeader

---DATENAME

SELECT DATENAME(Month,GETDATE())
SELECT DATENAME(WEEKDAY,GETDATE())
SELECT OrderDate,DATENAME(Month,OrderDate) As MonthNmae,DATENAME(WEEKDAY,OrderDate) As WeekName
FROM Sales.SalesOrderHeader



---DATEPART
SELECT GETDATE()

SELECT DATEPART(YEAR,GETDATE())
SELECT DATEPART(MONTH,GETDATE())
SELECT DATEPART(DAY,GETDATE())
SELECT DATEPART(QUARTER,GETDATE())
SELECT DATEPART(HOUR,GETDATE())


SELECT OrderDate,DATEPART(YEAR,OrderDate)
FROM Sales.SalesOrderHeader

--YEAR

SELECT YEAR(GETDATE())

SELECT OrderDate,DATEPART(YEAR,OrderDate),YEAR(OrderDate)
FROM Sales.SalesOrderHeader

/*
String Functions
*/

SELECT Ascii('A')
SELECT Ascii('a')
SELECT Ascii(',')
SELECT Ascii('~')
SELECT Ascii(' ')


SELECT ASCII('Kiran')

SELECT Char(68)
SELECT Char(97)
SELECT Char(124)


DECLARE @String VARCHAR(100)='This Is T-SQL Class'
SELECT LEFT(@String,6)

SELECT Len('This Is T-SQL Class')

SELECT ProductID,Name,LEFT(Name,4) AS First4Chars,LEN(Name) As NoOfChars
FROM Production.Product

SELECT ProductID,Name,LEFT(Name,4) AS First4Chars,LEN(Name) As NoOfChars
FROM Production.Product
WHERE LEN(Name)>=15

DECLARE @String VARCHAR(100)='This Is T-SQL Class'
SELECT LOWER(@String)


DECLARE @String VARCHAR(100)='   This Is T-SQL Class'
SELECT LEN(@String),LEN(LTRIM(@String))

SELECT ProductCategoryID,Name,LOWER(Name),LTRIM(Name)
FROM Production.ProductCategory

DECLARE @String VARCHAR(100)='This Is T-SQL Class'

SELECT QUOTENAME(@String),QUOTENAME(@String,')'),QUOTENAME(@String,'{')


DECLARE @String VARCHAR(100)='This Is T-SQL Class'

SELECT REPLACE(@String,'i','e')

DECLARE @String VARCHAR(100)='This Is T-SQL Class'
SELECT REPLICATE(@String,2)

DECLARE @String VARCHAR(100)='This Is T-SQL Class'
SELECT REVERSE(@String)

SELECT ProductCategoryID,Name,RIGHT(Name,6)
FROM Production.ProductCategory

DECLARE @String VARCHAR(100)='This Is T-SQL Class   '

SELECT RTRIM(@String),@String

DECLARE @Name VARCHAR(100)='Sai Krishna'

SELECT 'Hi Welcome to SQL Class' +Space(1) +@Name

SELECT Name, STUFF(Name,1,5,'Hai')
FROM Production.ProductCategory

SELECT Name,SUBSTRING(Name,1,5)
FROM Production.ProductCategory

SELECT EmailAddress,CHARINDEX('@',EmailAddress)
FROM Person.EmailAddress


SELECT EmailAddress,SUBSTRING(EmailAddress,1,CHARINDEX('@',EmailAddress)-1) As UserName,
SUBSTRING(EmailAddress,CHARINDEX('@',EmailAddress)+1,LEN(EmailAddress)) AS DomainName
FROM Person.EmailAddress


DECLARE @PeopleInfo TABLE
(
Names NVARCHAR(250)
)

INSERT INTO @PeopleInfo(Names)
VALUES('Narendra'),('Sai Krish5632na'),('Abhi98qunisha'),('Ravindra 23526 Reddy'),('Rajamouli123')

SELECT Names,PATINDEX('%[0-9]%',Names)
FROM @PeopleInfo

SELECT EmailAddress,PATINDEX('%[0-9]%',EmailAddress),PATINDEX('%[,''&@#~!.]%',EmailAddress)
FROM Person.EmailAddress

/*
MatheMatical Functions
*/

DECLARE @number DECIMAL ='12.48'

SELECT FLOOR(@number)

DECLARE @number DECIMAL ='12.49'

SELECT FLOOR(@number)

SELECT TotalDue,FLOOR(TotalDue)
FROM Sales.SalesOrderHeader


SELECT TotalDue,FLOOR(TotalDue),CEILING(TotalDue)
FROM Sales.SalesOrderHeader


DECLARE @Data TABLE
(
ID INT
)
INSERT INTO @Data(ID)
VALUES(1),(2),(3),(-4),(-2),(-10),(6)

SELECT *
FROM @Data
WHERE SIGN(ID)=1

SELECT *
FROM @Data
WHERE SIGN(ID)=-1


/*
Convertion Functions
*/

---CAST
DECLARE @Num INT=10,@Num1 DECIMAL =10.25

SELECT CAST(@Num AS VARCHAR(10)),CAST(@Num1 AS INT)

DECLARE @Date DATETIME =GETDATE()

SELECT CAST(@Date AS DATE)

SELECT OrderDate,CAST(OrderDate AS DATE)
FROM Sales.SalesOrderHeader


---CONVERT
DECLARE @Num INT=10,@Num1 DECIMAL =10.25

SELECT CONVERT(VARCHAR(10),@Num),CONVERT(INT,@Num1)

DECLARE @Date DATETIME =GETDATE()

SELECT CONVERT(DATE,@Date)

SELECT OrderDate,CONVERT(DATE,OrderDate)
FROM Sales.SalesOrderHeader

DECLARE @Datetime DATETIME =GETDATE()

SELECT @Datetime,CONVERT(VARCHAR,@Datetime,1),CONVERT(VARCHAR,@Datetime,2),CONVERT(VARCHAR,@Datetime,127)


--TRY_CAST

DECLARE @Num NVARCHAR(100)='Djwksa17828'
SELECT TRY_CAST(@Num AS INT)

CREATE TABLE #Sample
(
[Values] NVARCHAR(100)
)

INSERT INTO #Sample([Values])
VALUES('123'),('123ABC'),('234'),('245ndskj')


SELECT *
FROM	#Sample
WHERE TRY_CAST([Values] AS INT) IS NOT NULL


SELECT *
FROM	#Sample
WHERE TRY_CAST([Values] AS INT) IS NULL



SELECT *
FROM	#Sample
WHERE TRY_CONVERT(INT,[Values]) IS NOT NULL


SELECT *
FROM	#Sample
WHERE TRY_CONVERT(INT,[Values]) IS NULL



/*
User Defined Functions
*/

--Scalar UserDefined Functions

SELECT * FROM Sales.SalesOrderHeader


CREATE FUNCTION dbo.FnGetProfit (@SaleAmount DECIMAL)
RETURNS DECIMAL
AS 
BEGIN
RETURN 
	(
		SELECT @SaleAmount*0.10
	)
END


SELECT dbo.FnGetProfit(1000) AS Profit

SELECT SalesOrderID,SalesOrderNumber,PurchaseOrderNumber,TotalDue,dbo.FnGetProfit(TotalDue) As Profit
FROM Sales.SalesOrderHeader


ALTER FUNCTION dbo.FnGetProfit (@SaleAmount DECIMAL,@ProfitPerntge DECIMAL (4,2))
RETURNS DECIMAL(20,10)
AS 
BEGIN
RETURN 
	(
		SELECT @SaleAmount*@ProfitPerntge
	)
END

SELECT SalesOrderID,SalesOrderNumber,PurchaseOrderNumber,TotalDue,dbo.FnGetProfit(TotalDue,0.08) As Profit
FROM Sales.SalesOrderHeader


SELECT ProductID,LineTotal,dbo.FnGetProfit(LineTotal,0.05) As Profit
FROM Sales.SalesOrderDetail

-- InlineTable Vlaued Function

CREATE FUNCTION dbo.FnGetProductWiseSales (@ProdID INT)
RETURNS TABLE
RETURN 
(
SELECT ProductID,SUM(LineTotal) As TotalSales,dbo.FnGetProfit(LineTotal,0.05) As Profit
FROM Sales.SalesOrderDetail 
WHERE ProductID=@ProdID
GROUP BY ProductID,LineTotal
)


SELECT * FROM dbo.FnGetProductWiseSales(717)

CREATE FUNCTION dbo.FnGetAllSaleDetails()
RETURNS @Sales TABLE
(
RegionName VARCHAR(100),
TotalOrderQty BIGINT,
Amount MONEY,
SaleType VARCHAR(100)
)
AS
BEGIN
INSERT INTO @Sales(RegionName,TotalOrderQty,Amount,SaleType)
SELECT ST.Name As RegionName,SUM(SoD.OrderQty) As TotalOrders, SUM(SoH.SubTotal) AS TotalSub,'SubTotal' As [SaleTye]
FROM Sales.SalesOrderDetail SoD
JOIN Sales.SalesOrderHeader SoH ON SoD.SalesOrderID=SoH.SalesOrderID
JOIN Sales.SalesTerritory ST ON SoH.TerritoryID=ST.TerritoryID
GROUP BY ST.Name
UNION ALL
SELECT ST.Name As RegionName,SUM(SoD.OrderQty) As TotalOrders, SUM(SoH.TaxAmt) AS TotalTax,'TaxAmount' As [SaleTye]
FROM Sales.SalesOrderDetail SoD
JOIN Sales.SalesOrderHeader SoH ON SoD.SalesOrderID=SoH.SalesOrderID
JOIN Sales.SalesTerritory ST ON SoH.TerritoryID=ST.TerritoryID
GROUP BY ST.Name
UNION ALL
SELECT ST.Name As RegionName,SUM(SoD.OrderQty) As TotalOrders, SUM(SoH.Freight) AS TotalFreight,'Frieght' As [SaleTye]
FROM Sales.SalesOrderDetail SoD
JOIN Sales.SalesOrderHeader SoH ON SoD.SalesOrderID=SoH.SalesOrderID
JOIN Sales.SalesTerritory ST ON SoH.TerritoryID=ST.TerritoryID
GROUP BY ST.Name
RETURN
END 

SELECT * FROM dbo.FnGetAllSaleDetails()

ALTER FUNCTION dbo.FnGetAllSaleDetails(@SaleType NVARCHAR(100))
RETURNS @Sales TABLE
(
RegionName VARCHAR(100),
TotalOrderQty BIGINT,
Amount MONEY,
SaleType VARCHAR(100)
)
AS
BEGIN
INSERT INTO @Sales(RegionName,TotalOrderQty,Amount,SaleType)
SELECT * FROM 
(
SELECT ST.Name As RegionName,SUM(SoD.OrderQty) As TotalOrders, SUM(SoH.SubTotal) AS TotalSub,'SubTotal' As [SaleTye]
FROM Sales.SalesOrderDetail SoD
JOIN Sales.SalesOrderHeader SoH ON SoD.SalesOrderID=SoH.SalesOrderID
JOIN Sales.SalesTerritory ST ON SoH.TerritoryID=ST.TerritoryID
GROUP BY ST.Name
UNION ALL
SELECT ST.Name As RegionName,SUM(SoD.OrderQty) As TotalOrders, SUM(SoH.TaxAmt) AS TotalTax,'TaxAmount' As [SaleTye]
FROM Sales.SalesOrderDetail SoD
JOIN Sales.SalesOrderHeader SoH ON SoD.SalesOrderID=SoH.SalesOrderID
JOIN Sales.SalesTerritory ST ON SoH.TerritoryID=ST.TerritoryID
GROUP BY ST.Name
UNION ALL
SELECT ST.Name As RegionName,SUM(SoD.OrderQty) As TotalOrders, SUM(SoH.Freight) AS TotalFreight,'Frieght' As [SaleTye]
FROM Sales.SalesOrderDetail SoD
JOIN Sales.SalesOrderHeader SoH ON SoD.SalesOrderID=SoH.SalesOrderID
JOIN Sales.SalesTerritory ST ON SoH.TerritoryID=ST.TerritoryID
GROUP BY ST.Name
)ABC
WHERE [SaleTye]=@SaleType
RETURN
END 

SELECT * FROM dbo.FnGetAllSaleDetails('TaxAmount')