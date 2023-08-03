/*
Basic SELECT Query Syntax And Exection Process Steps
*/

SELECT * FROM [Sales].[SalesOrderHeader]

SELECT CustomerID,TotalDue FROM [Sales].[SalesOrderHeader]
WHERE TotalDue>15000

SELECT CustomerID,SUM(TotalDue) AS TotalDue FROM [Sales].[SalesOrderHeader]
WHERE TotalDue>15000
GROUP BY CustomerID


SELECT CustomerID,SUM(TotalDue) AS TotalDue FROM [Sales].[SalesOrderHeader]
WHERE TotalDue>15000
GROUP BY CustomerID


SELECT CustomerID,SUM(TotalDue) AS TotalDue FROM [Sales].[SalesOrderHeader]
WHERE TerritoryID=5
GROUP BY CustomerID
HAVING SUM(TotalDue) >15000
ORDER BY TotalDue ASC