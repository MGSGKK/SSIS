/*
Stored Procedures
*/


--System SPs

SP_RENAME '[dbo].[EMP]','dbo.Employee'

SP_RENAME 'Employee.EMPID','EmployeeID'

sp_help '[HumanResources].[Department]'

sp_help '[Sales].[SalesOrderDetail]'

SP_HELPTEXT 'uspGetBillOfMaterials'

sp_tables 'E%'


SP_COLUMNS '%%'


sp_depends 'uspGetBillOfMaterials'

SP_DEPENDS '[HumanResources].[vEmployeeDepartment]'


--User Defined Stroed Procedures

CREATE PROCEDURE Usp_GetSalesOrderInfo
AS
BEGIN
SELECT * FROM Sales.SalesOrderDetail
END


EXEC Usp_GetSalesOrderInfo


ALTER PROCEDURE Usp_GetSalesOrderInfo @ProdID INT
AS
BEGIN
SELECT * FROM Sales.SalesOrderDetail
WHERE ProductID=@ProdID
END


EXEC Usp_GetSalesOrderInfo 711

DECLARE @ProdID INT
SET @ProdID=711

EXEC  Usp_GetSalesOrderInfo @ProdID


CREATE PROC UspGetAllSalesInfo
AS
BEGIN

SELECT PC.Name,PS.Name,P.Name,Sod.OrderQty,SoH.TotalDue
FROM Sales.SalesOrderHeader SoH
LEFT JOIN Sales.SalesOrderDetail SoD ON SoH.SalesOrderID=SoD.SalesOrderID
LEFT JOIN Production.Product P ON Sod.ProductID=P.ProductID
LEFT JOIN Production.ProductSubcategory PS ON P.ProductSubcategoryID=PS.ProductSubcategoryID
LEFT JOIN Production.ProductCategory PC ON PS.ProductCategoryID=PC.ProductCategoryID

END


EXEC UspGetAllSalesInfo


ALTER PROC UspGetAllSalesInfo
AS
BEGIN

SELECT PC.Name As Category,PS.Name As SubCategory,P.Name As Product,SUM(Sod.OrderQty) AS TotalOrders,SUM(SoH.TotalDue) TotalSale
FROM Sales.SalesOrderHeader SoH
LEFT JOIN Sales.SalesOrderDetail SoD ON SoH.SalesOrderID=SoD.SalesOrderID
LEFT JOIN Production.Product P ON Sod.ProductID=P.ProductID
LEFT JOIN Production.ProductSubcategory PS ON P.ProductSubcategoryID=PS.ProductSubcategoryID
LEFT JOIN Production.ProductCategory PC ON PS.ProductCategoryID=PC.ProductCategoryID
GROUP BY PC.Name,PS.Name,P.Name
END


ALTER PROC UspGetAllSalesInfo @CatName VARCHAR(10)
AS
BEGIN

SELECT PC.Name As Category,PS.Name As SubCategory,P.Name As Product,SUM(Sod.OrderQty) AS TotalOrders,SUM(SoH.TotalDue) TotalSale
FROM Sales.SalesOrderHeader SoH
LEFT JOIN Sales.SalesOrderDetail SoD ON SoH.SalesOrderID=SoD.SalesOrderID
LEFT JOIN Production.Product P ON Sod.ProductID=P.ProductID
LEFT JOIN Production.ProductSubcategory PS ON P.ProductSubcategoryID=PS.ProductSubcategoryID
LEFT JOIN Production.ProductCategory PC ON PS.ProductCategoryID=PC.ProductCategoryID
WHERE PC.Name LIKE + @CatName+'%'
GROUP BY PC.Name,PS.Name,P.Name
END


EXEC UspGetAllSalesInfo 'Clo'



ALTER PROC UspPrintAtoZ
AS
BEGIN

DECLARE @StartASCII INT=65,@EndASCII INT=90

WHILE @StartASCII<=@EndASCII
BEGIN
PRINT CHAR(@StartASCII)

SET @StartASCII=@StartASCII+1
END


END


EXEC UspPrintAtoZ


ALTER PROC UspPrintAtoZ @StartASCII INT,@EndASCII INT
AS
BEGIN


WHILE @StartASCII<=@EndASCII
BEGIN
SELECT @StartASCII,CHAR(@StartASCII)

SET @StartASCII=@StartASCII+1
END


END

-- Assign Default Values to SPs Input Parameters
ALTER PROC UspPrintAtoZ @StartASCII INT=64,@EndASCII INT=90
AS
BEGIN


WHILE @StartASCII<=@EndASCII
BEGIN
SELECT @StartASCII,CHAR(@StartASCII)

SET @StartASCII=@StartASCII+1
END


END


EXEC UspPrintAtoZ 58,90


EXEC UspPrintAtoZ



ALTER PROC UspPopulateData
AS
BEGIN
MERGE INTO [SQLB14]..Sales M
USING [SQLB14]..Sales_Stg S ON M.SalesID=S.SalesID
WHEN MATCHED 
AND 
(
M.SaleDate<>S.SaleDate
OR	M.SaleAmount<>S.SaleAmount
OR	M.ProductName<>S.ProductName
)
THEN 
UPDATE 
SET M.SaleDate=S.SaleDate,
	M.SaleAmount=S.SaleAmount,
	M.ProductName=S.ProductName,
	M.UpdatedDate=GETDATE()
WHEN NOT MATCHED BY TARGET
THEN 
INSERT 
(
SalesID
,SaleDate
,SaleAmount
,ProductName
,InsertedDate
,UpdatedDate
)
VALUES
(
S.SalesID
,S.SaleDate
,S.SaleAmount
,S.ProductName
,GETDATE()
,NULL
)
WHEN NOT MATCHED BY SOURCE
THEN
DELETE
OUTPUT $ACTION,INSERTED.*,DELETED.*;
END

---OutPut Parameters

CREATE PROC UspGetTableRecordCount @RecCount INT OUTPUT
AS
BEGIN
	SELECT @RecCount=COUNT(*) FROM Sales.SalesOrderDetail
END


DECLARE @RecordCount INT	
EXEC UspGetTableRecordCount @RecordCount OUTPUT

SELECT @RecordCount As NoOfRows


ALTER PROC UspGetTableRecordCount @Schemname VARCHAR(100),@TableNmae VARCHAR(100)
AS
BEGIN

DECLARE @SQLStatement NVARCHAR(MAX)

SET @SQLStatement=
'SELECT COUNT(*) FROM '+@Schemname+'.'+@TableNmae

EXEC (@SQLStatement)

END



DECLARE @Count INT 
EXEC UspGetTableRecordCount 'Sales','SalesOrderHeader'
--SELECT @Count

ALTER PROC UspGetTableRecordCount @Schemname VARCHAR(100),@TableNmae VARCHAR(100)
AS
BEGIN

DECLARE @SQLStatement NVARCHAR(MAX)

SET @SQLStatement=
'SELECT COUNT(*) FROM '+@Schemname+'.'+@TableNmae

EXEC (@SQLStatement)

END


/*
Table Valued Parameters
*/


CREATE TYPE RegionWsieSales AS TABLE
(
RegionName VARCHAR(100),
SubTotal MONEY,
TaxAmount MONEY,
Frieght MONEY,
TotalDue MONEY
)


CREATE TABLE RegionWsieSales
(
RegionName VARCHAR(100),
SubTotal MONEY,
TaxAmount MONEY,
Frieght MONEY,
TotalDue MONEY
)


CREATE PROC UspGetPopulateData @Results RegionWsieSales READONLY
AS 
BEGIN

INSERT INTO RegionWsieSales
(
RegionName
,SubTotal
,TaxAmount
,Frieght
,TotalDue
)
SELECT A.RegionName,A.SubTotal,A.TaxAmount,A.Frieght,A.TotalDue
FROM @Results A
LEFT JOIN RegionWsieSales B ON A.RegionName=B.RegionName
WHERE B.RegionName IS NULL


UPDATE B
SET 
B.RegionName=A.RegionName,B.SubTotal=A.SubTotal,B.TaxAmount=A.TaxAmount,B.Frieght=A.Frieght,B.TotalDue=A.TotalDue
FROM @Results A
INNER JOIN RegionWsieSales B ON A.RegionName=B.RegionName

END


DECLARE @Results RegionWsieSales

INSERT INTO @Results
SELECT ST.Name As RegionName,SUM(SH.SubTotal) As TotalSub,SUM(SH.TaxAmt) As TotTaxAmount,SUM(SH.Freight) As TotFrieght,SUM(SH.TotalDue) As TotalDue
FROM AdventureWorks2016.Sales.SalesOrderHeader SH
LEFT JOIN AdventureWorks2016.Sales.SalesTerritory ST ON SH.TerritoryID=ST.TerritoryID
GROUP BY ST.Name

EXEC UspGetPopulateData @Results


SELECT * FROM RegionWsieSales


/*
===========================================
*/

CREATE PROCEDURE UspGetProductInfomration
AS
BEGIN
	SELECT *
	FROM Production.Product
END


EXEC UspGetProductInfomration


ALTER PROCEDURE UspGetProductInfomration @ProductID INT
AS
BEGIN
	SELECT *
	FROM Production.Product
	WHERE ProductID=@ProductID
END


EXEC UspGetProductInfomration 711

DECLARE @ProdID INT=711
EXEC UspGetProductInfomration @ProdID

CREATE PROC UspPopulateDataIntoEMPMain @NoOfRecrods INT OUTPUT
AS
BEGIN
		MERGE INTO Employee_Main T
		USING Employee_Stage S ON T.EMPID=S.EMPID
		WHEN MATCHED AND (T.EMPName<>S.EMPName OR T.Salary<>S.Salary)
		THEN
		UPDATE
			SET T.EMPName=S.EMPName,
				T.Salary=S.Salary,
				T.UpdatedDate=GETDATE()
		WHEN NOT MATCHED BY TARGET
		THEN 
		INSERT (EMPID,EMPName,Salary,InsertedDate,UpdatedDate)
		VALUES(S.EMPID,S.EMPName,S.Salary,GETDATE(),NULL)
		WHEN NOT MATCHED BY SOURCE
		THEN
		DELETE;
		SELECT @NoOfRecrods=@@ROWCOUNT
END


SELECT * FROM Employee_Stage
SELECT * FROM Employee_Main

UPDATE Employee_Stage
SET Salary=58500
WHERE EMPID=2


DECLARE @RecrodCount INT

EXEC UspPopulateDataIntoEMPMain @RecrodCount OUTPUT

SELECT 'Effected Recrod Count ::: ' + CONVERt(VARCHAR(10),@RecrodCount)

CREATE PROC UspGetMetaDataInfo @TableName VARCHAR(100)
AS
BEGIN
	SELECT *
	FROM INFORMATION_SCHEMA.COLUMNS
	WHERE TABLE_NAME=@TableName
END


EXEC UspGetMetaDataInfo 'Employee_Main'


ALTER PROC UspGetMetaDataInfo @TableName VARCHAR(100)='Employee_Main'
AS
BEGIN
	SELECT *
	FROM INFORMATION_SCHEMA.COLUMNS
	WHERE TABLE_NAME=@TableName
END

EXEC UspGetMetaDataInfo 'Employee_Stage'
