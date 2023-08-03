/*
Execution PLans
*/

SELECT * FROM [Sales].[SalesOrderHeader]

SELECT * FROM [Sales].[SalesOrderHeader]
WHERE TotalDue>25000


SELECT PC.Name As Category,PS.Name As SubCateogry,P.Name As Product,SUM(SoD.OrderQty) AS TotalOrders,SUM(SoH.TotalDue) AS TotalAmount
FROM [Sales].[SalesOrderHeader] SoH 
INNER JOIN [Sales].[SalesOrderDetail] SoD ON SoH.SalesOrderID=SoD.SalesOrderID
INNER JOIN Production.Product P ON SoD.ProductID=P.ProductID
INNER JOIN Production.ProductSubcategory PS ON PS.ProductSubcategoryID=P.ProductSubcategoryID
INNER JOIN Production.ProductCategory PC ON PC.ProductCategoryID=PS.ProductCategoryID
GROUP BY PC.Name,PS.Name,P.Name