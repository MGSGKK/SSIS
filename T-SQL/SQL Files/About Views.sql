/*
Views 
*/

/*
Simple View
*/

CREATE VIEW Vw_GetSalesHeaderInfo
AS
SELECT ProductKey,OrderDateKey,DueDateKey,ShipDateKey,CustomerKey,ExtendedAmount
FROM FactInternetSales

SELECT * FROM Vw_GetSalesHeaderInfo

/*
Complex View
*/
CREATE VIEW Vw_SubCtWiseSales
AS
SELECT PS.EnglishProductSubcategoryName As ProductSubCategory,FS.SalesAmount
FROM FactInternetSales FS
JOIN DimProduct P ON FS.ProductKey=P.ProductKey
JOIN DimProductSubcategory PS ON P.ProductSubcategoryKey=PS.ProductSubcategoryKey


SELECT ProductSubCategory,SUM(SalesAmount) As TotSale
FROM Vw_SubCtWiseSales
GROUP BY ProductSubCategory


ALTER VIEW Vw_SubCtWiseSales
AS
SELECT PS.EnglishProductSubcategoryName As ProductSubCategory,FS.SalesAmount,FS.OrderQuantity
FROM FactInternetSales FS
JOIN DimProduct P ON FS.ProductKey=P.ProductKey
JOIN DimProductSubcategory PS ON P.ProductSubcategoryKey=PS.ProductSubcategoryKey

SELECT * FROM Vw_SubCtWiseSales

DROP VIEW Vw_SubCtWiseSales

SELECT * FROM DimProductCategory

/*
With Schema Bindig
*/

CREATE VIEW dbo.Vw_SubCtWiseSales
   WITH SCHEMABINDING
AS
SELECT PS.EnglishProductSubcategoryName As ProductSubCategory,FS.SalesAmount,FS.OrderQuantity
FROM dbo.FactInternetSales FS
JOIN dbo.DimProduct P ON FS.ProductKey=P.ProductKey
JOIN dbo.DimProductSubcategory PS ON P.ProductSubcategoryKey=PS.ProductSubcategoryKey


/*
With Check Option
*/

CREATE VIEW Vw_GetProductInfo
AS
SELECT ProductKey,EnglishProductName
FROM DimProduct



ALTER VIEW Vw_GetProductInfo
AS
SELECT ProductKey,EnglishProductName
FROM DimProduct
WHERE EnglishProductName LIKE 'E%'
WITH CHECK OPTION


UPDATE Vw_GetProductInfo
SET EnglishProductName='Bearing Ball 1'
--SELECT * FROM DimProduct
WHERE EnglishProductName='Bearing Ball'



/*
Indexed View Or Materialized View
*/

CREATE VIEW Sales.vOrders
   WITH SCHEMABINDING
   AS  
      SELECT SUM(UnitPrice*OrderQty*(1.00-UnitPriceDiscount)) AS Revenue,
         OrderDate, ProductID, COUNT_BIG(*) AS COUNT
      FROM Sales.SalesOrderDetail AS od, Sales.SalesOrderHeader AS o
      WHERE od.SalesOrderID = o.SalesOrderID
      GROUP BY OrderDate, ProductID;

CREATE UNIQUE CLUSTERED INDEX IDX_V1
   ON Sales.vOrders (OrderDate, ProductID);

SELECT * FROM Sales.vOrders



CREATE VIEW Vw_SalesHeaderInfo
AS
SELECT SalesOrderID,OrderDate,TerritoryID,TotalDue
FROM Sales.SalesOrderHeader

DROP VIEW Vw_SalesHeaderInfo

SELECT * FROM Vw_AllSalesInformation

CREATE VIEW Vw_AllSalesInformation
AS
SELECT PC.Name As Category,PS.Name As SubCat,P.Name As ProductName,ST.Name As Region,SUM(SO.OrderQty) As TotalOrders,SUM(SH.TotalDue) As TotalSaleAmount
FROM Sales.SalesOrderHeader SH
LEFT JOIN Sales.SalesOrderDetail SO ON SH.SalesOrderID=SO.SalesOrderID
LEFT JOIN Production.Product P ON SO.ProductID=P.ProductID
LEFT JOIN Production.ProductSubcategory PS ON P.ProductSubcategoryID=PS.ProductSubcategoryID
LEFT JOIN Production.ProductCategory PC ON PS.ProductCategoryID=PC.ProductCategoryID
LEFT JOIN Sales.SalesTerritory ST ON SH.TerritoryID=ST.TerritoryID
GROUP BY PC.Name ,PS.Name,P.Name,ST.Name


CREATE VIEW Vw_GetProductInfo
AS
SELECT ProductID,Name
FROM Production.Product

ALTER VIEW Vw_GetProductInfo
AS
SELECT ProductID,Name
FROM Production.Product
WHERE Name LIKE 'E%'
WITH CHECK OPTION

SELECT * FROM Vw_GetProductInfo

UPDATE Vw_GetProductInfo
SET Name='Ixternal Lock Washer 1'
WHERE ProductID=409


SELECT * FROM Vw_AllSalesInformation
WHERE Region='Northwest'


CREATE VIEW Sales.vOrders
   WITH SCHEMABINDING
   AS  
      SELECT SUM(UnitPrice*OrderQty*(1.00-UnitPriceDiscount)) AS Revenue,
         OrderDate, ProductID, COUNT_BIG(*) AS COUNT
      FROM Sales.SalesOrderDetail AS od, Sales.SalesOrderHeader AS o
      WHERE od.SalesOrderID = o.SalesOrderID
      GROUP BY OrderDate, ProductID;

SELECT * FROM Sales.vOrders

CREATE UNIQUE CLUSTERED INDEX IDX_V1
   ON Sales.vOrders (OrderDate, ProductID);
