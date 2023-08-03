/*
Cursors
*/

--Static Curosrs

--SELECT PurchaseOrderNumber,CreditCardApprovalCode,TerritoryID,TotalDue
--FROM Sales.SalesOrderHeader

DECLARE @PurchaseOrderNumber NVARCHAR(1000),@CreditCardApprovalCode NVARCHAR(1000),@TerritoryID INT,@TotalDue MONEY

DECLARE SalesInformation CURSOR FOR 
SELECT PurchaseOrderNumber,CreditCardApprovalCode,TerritoryID,TotalDue
FROM Sales.SalesOrderHeader

OPEN SalesInformation

FETCH NEXT FROM SalesInformation
INTO @PurchaseOrderNumber,@CreditCardApprovalCode,@TerritoryID,@TotalDue

WHILE @@FETCH_STATUS=0
BEGIN
	PRINT @PurchaseOrderNumber + '  '+ @CreditCardApprovalCode + '  ' +CONVERT(VARCHAR(100),@TerritoryID)+' '+CONVERT(VARCHAR(100),@TotalDue)
	FETCH NEXT FROM SalesInformation
	INTO @PurchaseOrderNumber,@CreditCardApprovalCode,@TerritoryID,@TotalDue
END
CLOSE SalesInformation
DEALLOCATE SalesInformation


/*
Dynamic Cursor
*/
DROP TABLE Employee
CREATE TABLE Employee
(
EMPID INT PRIMARY KEY,
EMPName VARCHAR(100),
Salary INT,
Address VARCHAR(200)
)

INSERT INTO Employee
VALUES(1,'Bala',12000,'Sattenapalli')
INSERT INTO Employee
VALUES(2,'Bhavani',25000,'Vijayawada')
INSERT INTO Employee
VALUES(3,'Dharma',22000,'Gunutr')
INSERT INTO Employee
VALUES(4,'Farid',22000,'Repalle')
INSERT INTO Employee
VALUES(5,'Durga',28000,'Nandigam')

SELECT * FROM Employee



DECLARE @ID INT ,@Name VARCHAR(100),@Salary MONEY

DECLARE Dy_Cursor_Employee CURSOR
DYNAMIC FOR 
SELECT EMPID,EMPName,Salary
FROM Employee
ORDER BY EMPID
OPEN Dy_Cursor_Employee
IF @@CURSOR_ROWS<0
BEGIN
	FETCH NEXT FROM Dy_Cursor_Employee INTO @ID,@Name,@Salary
	WHILE @@FETCH_STATUS=0
	BEGIN
	IF @Salary>10000
	UPDATE Employee
	SET Salary=Salary+(Salary*0.05)
	WHERE EMPID=@ID
	FETCH NEXT FROM Dy_Cursor_Employee INTO @ID,@Name,@Salary
	END
END
CLOSE Dy_Cursor_Employee
DEALLOCATE Dy_Cursor_Employee

SELECT * FROM Employee


/*
FOrward Only Cursor
*/

DECLARE @ID INT ,@Name VARCHAR(100)

DECLARE FW_Cursor_Employee CURSOR
FORWARD_ONLY FOR 
SELECT EMPID,EMPName
FROM Employee
ORDER BY EMPID
OPEN FW_Cursor_Employee
IF @@CURSOR_ROWS<0
BEGIN
	FETCH NEXT FROM FW_Cursor_Employee INTO @ID,@Name
	WHILE @@FETCH_STATUS=0
	BEGIN
	IF @Name='Bala'
	UPDATE Employee
	SET Salary=16000
	WHERE EMPID=@ID
	FETCH NEXT FROM FW_Cursor_Employee INTO @ID,@Name
	END
END
CLOSE FW_Cursor_Employee
DEALLOCATE FW_Cursor_Employee


/*
Key Driven
*/

DECLARE @ID INT ,@Name VARCHAR(100)

DECLARE FW_Cursor_Employee CURSOR
KEYSET FOR 
SELECT EMPID,EMPName
FROM Employee
ORDER BY EMPID
OPEN FW_Cursor_Employee
IF @@CURSOR_ROWS<0
BEGIN
	FETCH NEXT FROM FW_Cursor_Employee INTO @ID,@Name
	WHILE @@FETCH_STATUS=0
	BEGIN
	IF @Name='Bala'
	UPDATE Employee
	SET Salary=18000
	WHERE EMPID=@ID
	FETCH NEXT FROM FW_Cursor_Employee INTO @ID,@Name
	END
END
CLOSE FW_Cursor_Employee
DEALLOCATE FW_Cursor_Employee


DECLARE @PurchaseOrderNumber NVARCHAR(1000),@CreditCardApprovalCode NVARCHAR(1000),@TerritoryID INT,@TotalDue MONEY

DECLARE SalesInformation CURSOR FOR 
SELECT PurchaseOrderNumber,CreditCardApprovalCode,TerritoryID,TotalDue
FROM Sales.SalesOrderHeader

OPEN SalesInformation

FETCH NEXT FROM SalesInformation
INTO @PurchaseOrderNumber,@CreditCardApprovalCode,@TerritoryID,@TotalDue

WHILE @@FETCH_STATUS=0
BEGIN
	PRINT 'Purchase OrderNumber Is :' +@PurchaseOrderNumber + '  '+CHAR(10)+'CreditCardNumber Is: '+ @CreditCardApprovalCode + '  ' +CHAR(10)+'Region ID Is:'+CONVERT(VARCHAR(100),@TerritoryID)+CHAR(10)+'Total Sale Amount Is:'+' '+CONVERT(VARCHAR(100),@TotalDue)
	FETCH NEXT FROM SalesInformation
	INTO @PurchaseOrderNumber,@CreditCardApprovalCode,@TerritoryID,@TotalDue
END
CLOSE SalesInformation
DEALLOCATE SalesInformation