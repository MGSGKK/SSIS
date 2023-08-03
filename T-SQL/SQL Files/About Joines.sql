/*
JOINS
*/

--INNER JOIN/JOIN

CREATE TABLE #Test1
(
ID INT
)
CREATE TABLE #Test2
(
ID INT
)

INSERT INTO #Test1
VALUES(1),(2),(3),(2),(4),(3)
INSERT INTO #Test2
VALUES(1),(1),(3),(2),(4),(6)

INSERT INTO #Test2
VALUES(3)


SELECT * FROM #Test1
SELECT * FROM #Test2


SELECT *
FROM #Test1 A
INNER JOIN #Test2 B ON A.ID=B.ID


SELECT *
FROM #Test1 A
JOIN #Test2 B ON A.ID=B.ID

--LEFT OUTER JOIN /LEFT JOIN
INSERT INTO #Test1
VALUES(8)

SELECT * FROM #Test1
SELECT * FROM #Test2

SELECT *
FROM #Test1 A
LEFT JOIN #Test2 B ON A.ID=B.ID


SELECT *
FROM #Test1 A
LEFT OUTER JOIN #Test2 B ON A.ID=B.ID

--RIGHT OUTER JOIN /RIGHT JOIN

SELECT *
FROM #Test1 A
RIGHT JOIN #Test2 B ON A.ID=B.ID

SELECT *
FROM #Test1 A
RIGHT OUTER JOIN #Test2 B ON A.ID=B.ID

--FULL OUTER JOIN

SELECT *
FROM #Test1 A
FULL JOIN #Test2 B ON A.ID=B.ID

--CORSS JOIN/CARTESIAN JOIN

SELECT * FROM #Test1
SELECT * FROM #Test2

SELECT *
FROM #Test1 A
CROSS JOIN #Test2 B



SELECT * FROM [Sales].[SalesOrderHeader]
SELECT * FROM [Sales].[SalesOrderDetail]


SELECT SoH.PurchaseOrderNumber,P.Name As ProductNmae,SoH.TotalDue,ST.Name As RegionName
FROM [Sales].[SalesOrderHeader] SoH 
INNER JOIN [Sales].[SalesOrderDetail] SoD ON SoH.SalesOrderID=SoD.SalesOrderID
INNER JOIN Production.Product P ON SoD.ProductID=P.ProductID
INNER JOIN Sales.SalesTerritory ST ON SoH.TerritoryID=ST.TerritoryID

SELECT * FROM [Sales].[SalesOrderHeader]

SP_HELP '[Sales].[SalesOrderHeader]'

SELECT * FROM Production.ProductCategory
SELECT * FROM Production.ProductSubcategory
SELECT * FROM Production.Product
SELECT * FROM Sales.SalesOrderDetail

SELECT PC.Name As Category,PS.Name As SubCateogry,P.Name As Product,SoD.OrderQty,SoH.TotalDue
FROM [Sales].[SalesOrderHeader] SoH 
INNER JOIN [Sales].[SalesOrderDetail] SoD ON SoH.SalesOrderID=SoD.SalesOrderID
INNER JOIN Production.Product P ON SoD.ProductID=P.ProductID
INNER JOIN Production.ProductSubcategory PS ON PS.ProductSubcategoryID=P.ProductSubcategoryID
INNER JOIN Production.ProductCategory PC ON PC.ProductCategoryID=PS.ProductCategoryID


SELECT PC.Name As Category,PS.Name As SubCateogry,P.Name As Product,SUM(SoD.OrderQty) AS TotalOrders,SUM(SoH.TotalDue) AS TotalAmount
FROM [Sales].[SalesOrderHeader] SoH 
INNER JOIN [Sales].[SalesOrderDetail] SoD ON SoH.SalesOrderID=SoD.SalesOrderID
INNER JOIN Production.Product P ON SoD.ProductID=P.ProductID
INNER JOIN Production.ProductSubcategory PS ON PS.ProductSubcategoryID=P.ProductSubcategoryID
INNER JOIN Production.ProductCategory PC ON PC.ProductCategoryID=PS.ProductCategoryID
GROUP BY PC.Name,PS.Name,P.Name


SELECT PC.Name As Category,PS.Name As SubCateogry,P.Name As Product,
SUM(SoD.OrderQty) AS TotalOrders,
SUM(SoH.TotalDue) AS TotalAmount,
[dbo].[FnGetProfit](SUM(SoH.TotalDue),0.05) As Profit
FROM [Sales].[SalesOrderHeader] SoH 
INNER JOIN [Sales].[SalesOrderDetail] SoD ON SoH.SalesOrderID=SoD.SalesOrderID
INNER JOIN Production.Product P ON SoD.ProductID=P.ProductID
INNER JOIN Production.ProductSubcategory PS ON PS.ProductSubcategoryID=P.ProductSubcategoryID
INNER JOIN Production.ProductCategory PC ON PC.ProductCategoryID=PS.ProductCategoryID
GROUP BY PC.Name,PS.Name,P.Name

SELECT P.ProductID,P.Name As Product,SUM(SoD.LineTotal) As TotalAmount,SUM(SoD.OrderQty) As TotalOrders
FROM Sales.SalesOrderDetail SoD
RIGHT JOIN Production.Product P ON SoD.ProductID=P.ProductID
GROUP BY P.Name,P.ProductID

SELECT * FROM Sales.SalesOrderDetail
WHERE ProductID=410


SELECT P.Name As Product,SUM(SoD.LineTotal) As TotalAmount,SUM(SoD.OrderQty) As TotalOrders
FROM Sales.SalesOrderDetail SoD
INNER JOIN Production.Product P ON SoD.ProductID=P.ProductID
GROUP BY P.Name

SELECT P.Name As ProductName,SUM(SoD.OrderQty) As TotalOrders,SUM(SoH.TotalDue) As TotalAmount
,YEAR(SoH.OrderDate) As OrderYear,DATENAME(MONTH,SoH.OrderDate) As OrderMonth
,DATENAME(WEEKDAY,SoH.OrderDate) AS OrderWeek
FROM Sales.SalesOrderHeader SoH
INNER JOIN Sales.SalesOrderDetail SoD ON SoH.SalesOrderID=SoD.SalesOrderID
INNER JOIN Production.Product P On SoD.ProductID=p.ProductID
WHERE DATENAME(WEEKDAY,SoH.OrderDate) NOT IN ('Sunday','Saturday')
GROUP BY P.Name,YEAR(SoH.OrderDate),DATENAME(MONTH,SoH.OrderDate),DATENAME(WEEKDAY,SoH.OrderDate)


SELECT P.Name As ProductName,SUM(SoD.OrderQty) As TotalOrders,SUM(SoH.TotalDue) As TotalAmount,DATEPART(MONTH,SoH.OrderDate)
,YEAR(SoH.OrderDate) As OrderYear,DATENAME(MONTH,SoH.OrderDate) As OrderMonth
,DATENAME(WEEKDAY,SoH.OrderDate) AS OrderWeek
FROM Sales.SalesOrderHeader SoH
INNER JOIN Sales.SalesOrderDetail SoD ON SoH.SalesOrderID=SoD.SalesOrderID
INNER JOIN Production.Product P On SoD.ProductID=p.ProductID
WHERE DATENAME(WEEKDAY,SoH.OrderDate) IN ('Sunday','Saturday')
GROUP BY P.Name,YEAR(SoH.OrderDate),DATENAME(MONTH,SoH.OrderDate),DATENAME(WEEKDAY,SoH.OrderDate),DATEPART(MONTH,SoH.OrderDate)
ORDER BY YEAR(SoH.OrderDate),DATEPART(MONTH,SoH.OrderDate)

----SELF JOIN

CREATE TABLE EMPMger
(
EMPID INT IDENTITY(1,1) PRIMARY KEY,
EMPName VARCHAR(100),
MgrID INT,
FOREIGN KEY(MGRID) REFERENCES EMPMger(EMPID)
)

INSERT INTO EMPMger(EMPName,MgrID)
VALUES('Narendra',NULL)
INSERT INTO EMPMger(EMPName,MgrID)
VALUES('Abhidunnisa',1)
INSERT INTO EMPMger(EMPName,MgrID)
VALUES('Rajamouli',1)
INSERT INTO EMPMger(EMPName,MgrID)
VALUES('Ravindra',2)
INSERT INTO EMPMger(EMPName,MgrID)
VALUES('SaiKrishna',3)


SELECT * FROM EMPMger

SELECT E.EMPName As EMployeeNmae,M.EMPName As ManagerName
FROM EMPMger E
JOIN EMPMger M ON E.MgrID=M.EMPID


SELECT E.EMPName As EMployeeNmae,ISNULL(M.EMPName,'CEO') As ManagerName
FROM EMPMger E
LEFT JOIN EMPMger M ON E.MgrID=M.EMPID


/*
Joins With DML Operations
*/

CREATE TABLE Sales_Stg
(
SalesID INT ,
SaleDate DATETIME,
SaleAmount MONEY,
ProductName VARCHAR(100)
)


CREATE TABLE Sales
(
SalesID INT ,
SaleDate DATETIME,
SaleAmount MONEY,
ProductName VARCHAR(100),
InsertedDate DATETIME,
UpdatedDate DATETIME
)

INSERT INTO Sales_Stg(SalesID,SaleDate,SaleAmount,ProductName)
VALUES(1,'2022-01-28',16500,'Mobiles')
INSERT INTO Sales_Stg(SalesID,SaleDate,SaleAmount,ProductName)
VALUES(2,'2022-02-03',28700,'TV')
INSERT INTO Sales_Stg(SalesID,SaleDate,SaleAmount,ProductName)
VALUES(3,'2022-03-15',26500,'TV')
INSERT INTO Sales_Stg(SalesID,SaleDate,SaleAmount,ProductName)
VALUES(4,'2022-03-17',18950,'Mobile')

INSERT INTO Sales_Stg(SalesID,SaleDate,SaleAmount,ProductName)
VALUES(5,'2022-03-31',26540,'Fridge')


INSERT INTO Sales(SalesID,SaleDate,SaleAmount,ProductName,InsertedDate,UpdatedDate)
SELECT S.SalesID,S.SaleDate,S.SaleAmount,S.ProductName,GETDATE(),NULL
FROM Sales_Stg S
LEFT JOIN Sales M ON S.SalesID=M.SalesID
WHERE M.SalesID IS NULL

SELECT * FROM Sales_Stg
SELECT * FROM Sales

UPDATE Sales_Stg
SET SaleAmount=32850
WHERE SalesID=2


UPDATE M
SET M.SaleDate=S.SaleDate,
	M.SaleAmount=S.SaleAmount,
	M.ProductName=S.ProductName
	,M.UpdatedDate=GETDATE()
FROM Sales_Stg S
INNER JOIN Sales M ON S.SalesID=M.SalesID
WHERE M.SaleDate<>S.SaleDate OR M.SaleAmount<>S.SaleAmount OR M.ProductName<>S.ProductName

SELECT * FROM Sales_Stg
SELECT * FROM Sales

DELETE FROM Sales_Stg
WHERE SalesID=2


DELETE M
FROM Sales_Stg S
RIGHT JOIN Sales M ON S.SalesID=M.SalesID
WHERE S.SalesID IS NULL

DELETE M
FROM  Sales M
LEFT JOIN Sales_Stg S ON S.SalesID=M.SalesID
WHERE S.SalesID IS NULL