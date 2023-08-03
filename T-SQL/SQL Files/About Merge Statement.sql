/*
Merge Statement
*/



INSERT INTO Sales_Stg(SalesID,SaleDate,SaleAmount,ProductName)
VALUES(1,'2022-01-28',16500,'Mobiles')
INSERT INTO Sales_Stg(SalesID,SaleDate,SaleAmount,ProductName)
VALUES(2,'2022-02-03',28700,'TV')
INSERT INTO Sales_Stg(SalesID,SaleDate,SaleAmount,ProductName)
VALUES(3,'2022-03-15',26500,'TV')
INSERT INTO Sales_Stg(SalesID,SaleDate,SaleAmount,ProductName)
VALUES(4,'2022-03-17',18950,'Mobile')

INSERT INTO Sales_Stg(SalesID,SaleDate,SaleAmount,ProductName)
VALUES(5,'2022-03-31',26540,'Fridge')

SELECT * FROM Sales_Stg
SELECT * FROM Sales

INSERT INTO Sales_Stg(SalesID,SaleDate,SaleAmount,ProductName)
VALUES(6,'2022-04-05',18746,'Mobile')

INSERT INTO Sales_Stg(SalesID,SaleDate,SaleAmount,ProductName)
VALUES(7,'2022-04-15',18746,'Mobile')
UPDATE Sales_Stg
set SaleAmount=23500
WHERE SalesID=3
DELETE FROM Sales_Stg
WHERE SalesID=4


MERGE INTO Sales M
USING Sales_Stg S ON M.SalesID=S.SalesID
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

