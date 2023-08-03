/*
Clustered Index
*/

SP_TABLES '%%'


SELECT * FROM Sales

CREATE CLUSTERED INDEX CI_Sales_SaleID 
ON Sales(SalesID )
DROP INDEX CI_Sales_SaleID
ON Sales

CREATE CLUSTERED INDEX CI_Sales_SaleID 
ON Sales(SalesID DESC)


SELECT * FROM Sales
DROP INDEX CI_Sales_SaleID
ON Sales

CREATE CLUSTERED INDEX CI_Sales_SaleID 
ON Sales(SalesID DESC,ProductName ASC)

SELECT * FROM Sales

/*
Non Clustered Index
*/

SELECT * FROM Sales
WHERE ProductName LIKE 'M%'

CREATE NONCLUSTERED INDEX NCI_Sales_ProdName 
ON Sales(ProductName)


CREATE NONCLUSTERED INDEX NCI_Sales_SaleAmount 
ON Sales(SaleAmount)

/*
Unique Indexes
*/
DROP INDEX CI_Sales_SaleID
ON Sales

CREATE UNIQUE CLUSTERED INDEX UCI_Sales_SaleID 
ON Sales(SalesID DESC,ProductName ASC)


CREATE UNIQUE NONCLUSTERED INDEX UNCI_Sales_SaleAmount 
ON Sales(SalesID)


/*
Column Store Index
*/
DROP INDEX [UCI_Sales_SaleID]
ON Sales


CREATE CLUSTERED COLUMNSTORE INDEX CCI_Sales
ON Sales

DROP INDEX CCI_Sales
ON Sales

CREATE NONCLUSTERED COLUMNSTORE INDEX NCCI_Sales_ProdName
ON Sales(ProductName)


--Disable

ALTER INDEX NCCI_Sales_ProdName
ON Sales
DISABLE


ALTER INDEX ALL
ON Sales
DISABLE

ALTER INDEX ALL
ON Sales
REBUILD