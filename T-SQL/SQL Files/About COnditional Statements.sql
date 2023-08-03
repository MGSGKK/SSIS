/*
Conditional Statments
*/

DECLARE @Num INT=10

IF (@Num=10)
BEGIN
	SELECT 'True'
END
ELSE
BEGIN
	SELECT 'False'
END


DECLARE @SQLStementType NVARCHAR(100)
SET @SQLStementType='AS'

IF(@SQLStementType='SH')
BEGIN
	SELECT * FROM Sales.SalesOrderHeader
END
ELSE
BEGIN
	SELECT * FROM Sales.SalesOrderDetail
END

IF OBJECT_ID('EMP','U') IS NULL
BEGIN
	CREATE TABLE EMP
	(
	EMPID INT
	)
END
ELSE
BEGIN
	PRINT 'Table is Exist '
END

--IIF

SELECT OrderQty,UnitPrice,IIF( OrderQty>10 AND UnitPrice>5000,'High','Low') AS Ranking
FROM Sales.SalesOrderDetail

SELECT SalesOrderNumber,PurchaseOrderNumber,TotalDue,IIF(TotalDue>=5000,'Good Sale','Bad Sale')
FROM Sales.SalesOrderHeader

SELECT SalesOrderNumber,PurchaseOrderNumber,TotalDue,SubTotal,IIF(TotalDue>=5000 AND SubTotal>4500,'Good Sale','Bad Sale')
FROM Sales.SalesOrderHeader

SELECT SalesOrderNumber,PurchaseOrderNumber,TotalDue,SubTotal
,IIF(TotalDue>=25000,'Good Sale',IIF(TotalDue<25000 AND TotalDue>=10000,'Medium Sale','Bad Sale'))
FROM Sales.SalesOrderHeader

--CASE
SELECT SalesOrderNumber,PurchaseOrderNumber,TotalDue,SubTotal
,CASE WHEN TotalDue>=25000
	 THEN 'Good Sale'
	 WHEN TotalDue<25000 AND TotalDue>=10000
	 THEN 'Medium Sale'
	 ELSE 
	 'BadSale'
	 END
FROM Sales.SalesOrderHeader

---WHILE Loop
	DECLARE @count INT;
	SET @count = 1;
		
	WHILE @count<= 5
	BEGIN
	PRINT @count
	SET @count = @count + 1;
	END;
	
	DECLARE @Counter INT 
	SET @Counter=1
	WHILE ( @Counter <= 10)
	BEGIN
		PRINT 'The counter value is = ' + CONVERT(VARCHAR,@Counter)
		SET @Counter  = @Counter  + 1
	END

A-Z

SELECT ASCII('A')--65

SELECT ASCII('Z')--90


DECLARE @StartNum INT =65,@EndNum INT=90

WHILE @StartNum<=@EndNum
BEGIN
	PRINT CHAR(@StartNum)
	SET @StartNum=@StartNum+1
END

CREATE TABLE Test
(
ID INT Identity(1,1),
Names VARCHAR(100)
)

INSERT INTO Test(Names)
VALUES('A'),('B'),('C'),('D'),('E'),('F')

SELECT * FROM Test

DELETE FROM Test
WHERE ID=2

	DECLARE @MInValue INT,@MaxValue INT

	SELECT @MInValue=MIN(ID),@MaxValue=MAX(ID) FROM Test
	
	IF OBJECT_ID('tempdb..#MissingIDSeq','U') IS NOT NULL
	DROP TABLE #MissingIDSeq
		create table #MissingIDSeq
		(
			id int
		)
	
		WHIle @MInValue<@MaxValue
		BEGIN
		INSERT INTO #MissingIDSeq
		VALUES(@MInValue)
		SET @MInValue=@MInValue+1
		END

		SELECT A.id
			FROM #MissingIDSeq AS A
			LEFT JOIN Test AS B ON A.id=B.ID
		WHERE B.ID IS NULL

