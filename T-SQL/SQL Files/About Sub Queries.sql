/*
SUb Queries
*/

SELECT * FROM Sales.SalesOrderDetail
SELECT * FROM Sales.SalesOrderHeader

--Single Row Sub Query
SELECT * FROM Sales.SalesOrderDetail
WHERE SalesOrderID =
(
SELECT MAX(SalesOrderID)
FROM Sales.SalesOrderHeader
)

--Multi Row Sub Query

SELECT * FROM Production.Product
WHERE ProductID IN 
(
SELECT DISTINCT ProductID
FROM Sales.SalesOrderDetail
)

SELECT * FROM Production.Product
WHERE ProductID NOT IN 
(
SELECT DISTINCT ProductID
FROM Sales.SalesOrderDetail
)

--CoRrelated Sub Query
SELECT *
FROM Production.Product P
WHERE EXISTS
(
SELECT *
FROM Sales.SalesOrderDetail S
WHERE S.ProductID=P.ProductID
)

SELECT *
FROM Production.Product P
WHERE NOT EXISTS
(
SELECT *
FROM Sales.SalesOrderDetail S
WHERE S.ProductID=P.ProductID
)

SELECT * FROM Sales.SalesOrderDetail
WHERE SalesOrderID=43659
SELECT * FROM Sales.SalesOrderHeader

SELECT SalesOrderID,PurchaseOrderNumber
,
(
SELECT SUM(OrderQty) 
FROM Sales.SalesOrderDetail SD 
WHERE SH.SalesOrderID=SD.SalesOrderID
) As TotalOrders
FROM Sales.SalesOrderHeader SH


SELECT * FROM Production.Product
WHERE ProductID IN 
(
SELECT TOP 5  ProductID
FROM Sales.SalesOrderDetail
--GROUP BY ProductID,LineTotal
ORDER BY LineTotal DESC
)

/*
DML Opearations With Sub Queries
*/
/*
Syntax:
	INSERT INTO <TableName>
	SELECT <ColumnNamea>,<Column2>....ext
	FROM <TABLE_NAME>
	WHERE Operator [Value]
   (SELECT COLUMN_NAME
   FROM TABLE_NAME)
   [ WHERE) ]
*/

CREATE TABLE Employee_Stage
(
EMPID INT,
EMPName VARCHAR(100),
Salary money
)

CREATE TABLE Employee_Main
(
EMPID INT,
EMPName VARCHAR(100),
Salary money,
InsertedDate DATETIME,
UPdatedDate DATETIME
)

SELECT * FROM Employee_Main
SELECT * FROM Employee_Stage

INSERT INTO Employee_Stage(EMPID,EMPName,Salary)
VALUES(1,'Vinayaka',54000)
INSERT INTO Employee_Stage(EMPID,EMPName,Salary)
VALUES(2,'SriKanth',64000)
INSERT INTO Employee_Stage(EMPID,EMPName,Salary)
VALUES(3,'Venu',68000)
INSERT INTO Employee_Stage(EMPID,EMPName,Salary)
VALUES(4,'Gopi',58000)
INSERT INTO Employee_Stage(EMPID,EMPName,Salary)
VALUES(5,'Hari',78000)

INSERT INTO Employee_Main(EMPID,EMPName,Salary,InsertedDate,UPdatedDate)
SELECT EMPID,EMPName,Salary,GETDATE(),NULL FROM Employee_Stage
WHERE EMPID NOT IN 
(
SELECT EMPID
FROM Employee_Main
)

/*
Syntax:
UPDATE table
SET column_name = new_value
[ WHERE OPERATOR [ VALUE ]
   (SELECT COLUMN_NAME
   FROM TABLE_NAME)
   [ WHERE) ]
*/

CREATE TABLE #ProductInvnetory
(
InventoryID INT IDENTITY(1,1),
ProductID INT,
StockOrderQty INT
)

CREATE TABLE #Slaes
(
SalesID INT IDENTITY(1,1),
ProductID INT,
SalesOrdQty INT
)

INSERT INTO #ProductInvnetory(ProductID,StockOrderQty)
VALUES(100,56),(101,104),(102,256)

INSERT INTO #Slaes(ProductID,SalesOrdQty)
VALUES(101,35),(102,67),(100,34)

SELECT * FROM #ProductInvnetory
SELECT * FROM #Slaes

UPDATE #ProductInvnetory 
SET StockOrderQty=StockOrderQty-
(
SELECT SUM(SalesOrdQty)
FROM #Slaes S
WHERE #ProductInvnetory.ProductID=S.ProductID
)

/*
 DELETE FROM TABLE_NAME
[ WHERE OPERATOR [ VALUE ]
   (SELECT COLUMN_NAME
   FROM TABLE_NAME)
   [ WHERE) ]
*/

SELECT * FROM Employee_Stage
SELECT * FROM Employee_Main

DELETE FROM Employee_Stage
WHERE EMPID=5

DELETE FROM Employee_Main
WHERE EMPID NOT IN 
(
SELECT EMPID FROM Employee_Stage
)