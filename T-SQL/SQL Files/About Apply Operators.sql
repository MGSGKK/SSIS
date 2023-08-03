/*
Apply Operators
*/

SELECT * FROM [dbo].[FnGetProductWiseSales](711)

SELECT P.Name As ProductName,M.Profit,M.TotalSales
FROM Production.Product P 
CROSS APPLY [dbo].[FnGetProductWiseSales] (P.ProductID) M


SELECT P.Name As ProductName,M.Profit,M.TotalSales
FROM Production.Product P 
OUTER APPLY [dbo].[FnGetProductWiseSales] (P.ProductID) M