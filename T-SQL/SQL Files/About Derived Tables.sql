/*
Derived Tables
*/

SELECT PC.Name As Category,PS.Name As SubCategory, P.ProductID,P.Name As Product
FROM Production.Product P
INNER JOIN Production.ProductSubcategory PS ON P.ProductSubcategoryID=PS.ProductSubcategoryID
INNER JOIN Production.ProductCategory PC ON PS.ProductCategoryID=PC.ProductCategoryID
WHERE PC.Name='Bikes'

SELECT * FROM 
(
SELECT PC.Name As Category,PS.Name As SubCategory, P.ProductID,P.Name As Product
FROM Production.Product P
INNER JOIN Production.ProductSubcategory PS ON P.ProductSubcategoryID=PS.ProductSubcategoryID
INNER JOIN Production.ProductCategory PC ON PS.ProductCategoryID=PC.ProductCategoryID
) A
WHERE Category='Bikes'