/*
Pivot

Syntax:
SELECT <non-pivoted column>, <list of pivoted column>    
FROM  (<SELECT query  to produces the data>)  AS <alias name>    
PIVOT ( <aggregation function>(<column name that will aggregated>)    
FOR  [<column name that  will become column headers>]    
    IN ( [list of  pivoted columns]) ) AS <alias name  for  PIVOT table>    
<ORDER BY clause> 

*/

;WITH CTE_YearWsieSales
AS
(
SELECT YEAR(OrderDate) As OrderYear,SUM(TotalDue) As TotalSales
FROM Sales.SalesOrderheader
GROUP BY YEAR(OrderDate)
)
SELECT * FROM CTE_YearWsieSales
PIVOT
(
SUM(TotalSales)
FOR OrderYear IN ([2011],[2012],[2013],[2014])
) As PivotResults


;WITH CTE_YearWsieSales
AS
(
SELECT YEAR(OrderDate) As OrderYear,SUM(TotalDue) As TotalSales,SUM(Freight) As TotalFriegnt
FROM Sales.SalesOrderheader
GROUP BY YEAR(OrderDate)
)
SELECT * FROM CTE_YearWsieSales
PIVOT
(
SUM(TotalSales)
FOR OrderYear IN ([2011],[2012],[2013],[2014])
) As PivotResults


DECLARE @ColumnNames NVARCHAR(MAX),@SQLStatement NVARCHAR(MAX)

WITH CTE_GetAllYears
AS
(
SELECT QUOTENAME(YEAR(OrderDate),'[') As orderYear
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate)
)
SELECT @ColumnNames=STRING_AGG(orderYear,',') 
FROM CTE_GetAllYears


SET @SQLStatement=
';WITH CTE_YearWsieSales
AS
(
SELECT YEAR(OrderDate) As OrderYear,SUM(TotalDue) As TotalSales,SUM(Freight) As TotalFriegnt
FROM Sales.SalesOrderheader
GROUP BY YEAR(OrderDate)
)
SELECT * FROM CTE_YearWsieSales
PIVOT
(
SUM(TotalSales)
FOR OrderYear IN ('+@ColumnNames+')) As PivotResults'

EXEC(@SQLStatement)


/*
Dymanic SQL Queires
*/

ALTER PROCEDURE UspGetObjectScriptsCreation @TableName NVARCHAR(MAX),@COlumnNames NVARCHAR(MAX)
AS
BEGIN

DECLARE @SQLStatement NVARCHAR(MAX)
SET @SQLStatement='CREATE TABLE '+@TableName+CHAR(10)+
'('+CHAR(10)+@COlumnNames+CHAR(10)+')'

PRINT @SQLStatement
END


EXEC UspGetObjectScriptsCreation 'EMPS','EMPID INT IDENTITY(1,1),EMPName VARCHAR(100),Salary MONEY'





ALTER PROCEDURE UspGetObjectScriptsCreation @TableName NVARCHAR(MAX),@COlumnNames NVARCHAR(MAX)
AS
BEGIN

DECLARE @SQLStatement NVARCHAR(MAX)
SET @SQLStatement='CREATE TABLE '+@TableName+CHAR(10)+
'('+CHAR(10)+@COlumnNames+CHAR(10)+')'

EXEC (@SQLStatement)
END

ALTER PROCEDURE UspGetObjectScriptsCreation @TableName NVARCHAR(MAX),@COlumnNames NVARCHAR(MAX)
AS
BEGIN

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME=@TableName)
BEGIN
	RAISERROR('TableAlready Exists',16,1)
END
ELSE
BEGIN
DECLARE @SQLStatement NVARCHAR(MAX)
SET @SQLStatement='CREATE TABLE '+@TableName+CHAR(10)+
'('+CHAR(10)+@COlumnNames+CHAR(10)+')'

EXEC (@SQLStatement)

PRINT 'Table Got Created'
END
END

EXEC UspGetObjectScriptsCreation 'EMPS','EMPID INT IDENTITY(1,1),EMPName VARCHAR(100),Salary MONEY'


DECLARE @ColumnName NVARCHAR(MAX) ='SubTotal,TotalDue',@SQL NVARCHAR(MAX)

SET @SQL='SELECT TerritoryID,BillToAddressID,ShipToAddressID,'+@ColumnName + ' FROM AdventureWorks2016.Sales.SalesOrderHeader'

EXEC (@SQL)


ALTER PROC UsppDynamicColumnSelctionSalesResults  @ColumnName NVARCHAR(MAX)=NULL
AS
BEGIN
	DECLARE @SQL NVARCHAR(MAX)
	SET @SQL='SELECT TerritoryID,BillToAddressID,ShipToAddressID,'+@ColumnName + ' FROM AdventureWorks2016.Sales.SalesOrderHeader'

	EXEC (@SQL)
END

EXEC UsppDynamicColumnSelctionSalesResults 'SubTotal,TotalDue'



ALTER PROC UsppDynamicColumnSelctionSalesResults  @ColumnName NVARCHAR(MAX)=NULL
AS
BEGIN
	DECLARE @SQL NVARCHAR(MAX)
	IF @ColumnName IS NULL
	BEGIN
		SET @SQL='SELECT TerritoryID,BillToAddressID,ShipToAddressID FROM AdventureWorks2016.Sales.SalesOrderHeader'
		EXEC (@SQL)
	END
	ELSE
	BEGIN
	SET @SQL='SELECT TerritoryID,BillToAddressID,ShipToAddressID,'+@ColumnName + ' FROM AdventureWorks2016.Sales.SalesOrderHeader'
	EXEC (@SQL)
	END
END

EXEC UsppDynamicColumnSelctionSalesResults 