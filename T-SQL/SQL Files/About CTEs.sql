/*
CTEs
*/

DECLARE @StartNumber INT,@EndNumber INT
SELECT @StartNumber=1,@EndNumber=10000

;WITH CTE_GenerateSequence(Number)
AS
(
SELECT @StartNumber As Number
UNION ALL
SELECT Number+1 
FROM CTE_GenerateSequence
WHERE Number<@EndNumber
)
SELECT * FROM CTE_GenerateSequence  OPTION (MaxRecursion 10000)


;WITH CTE_GetSalesInfo
AS
(
SELECT SoD.ProductID,SoD.OrderQty,SoD.LineTotal,SoH.BillToAddressID,SoH.SalesOrderNumber,SoH.TotalDue
FROM Sales.SalesOrderDetail SoD
INNER JOIN Sales.SalesOrderHeader SoH ON SoD.SalesOrderID=SoH.SalesOrderID
),
CTE_GetllProdInfo
AS
(
SELECT PC.Name As Category,PS.Name As SubCategory, P.ProductID,P.Name As Product
FROM Production.Product P
INNER JOIN Production.ProductSubcategory PS ON P.ProductSubcategoryID=PS.ProductSubcategoryID
INNER JOIN Production.ProductCategory PC ON PS.ProductCategoryID=PC.ProductCategoryID
)
,
CTE_ProdDetails
AS
(
SELECT  S.ProductID,OrderQty,LineTotal,BillToAddressID,SalesOrderNumber,TotalDue,Category,SubCategory,Product
FROM CTE_GetSalesInfo S
LEFT JOIN CTE_GetllProdInfo P ON S.ProductID=P.ProductID
) 
SELECT * FROM CTE_ProdDetails

