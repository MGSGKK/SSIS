/*
Windows Analytics Functions
*/

--Aggregate Windows Analytics Functions

;WITH CTE_GetAggratgeData
AS
(
SELECT OrderDate,SUM(TotalDue) AS TotalSale
FROM Sales.SalesOrderHeader
GROUP BY OrderDate
)
SELECT OrderDate,TotalSale,SUM(TotalSale) OVER (ORDER BY OrderDate ASC) As RunninTotal
FROM CTE_GetAggratgeData



SELECT OrderDate,TotalDue,SUM(TotalDue)OVER(PARTITION BY OrderDate ORDER BY TotalDue DESC) As RunningTotal
FROM Sales.SalesOrderHeader
--GROUP BY OrderDate

;WITH CTE_GetAggratgeData
AS
(
SELECT OrderDate,TotalDue
FROM Sales.SalesOrderHeader
--GROUP BY OrderDate
)
SELECT OrderDate,TotalDue,MAX(TotalDue) OVER (PARTITION BY OrderDate ORDER BY OrderDate ASC) As MaxRunningSale
FROM CTE_GetAggratgeData

;WITH CTE_GetAggratgeData
AS
(
SELECT OrderDate,TotalDue
FROM Sales.SalesOrderHeader
--GROUP BY OrderDate
)
SELECT OrderDate,TotalDue,MIN(TotalDue) OVER (PARTITION BY OrderDate ORDER BY OrderDate ASC) As MinRunningSale
FROM CTE_GetAggratgeData

;WITH CTE_GetAggratgeData
AS
(
SELECT OrderDate,TotalDue
FROM Sales.SalesOrderHeader
--GROUP BY OrderDate
)
SELECT OrderDate,TotalDue,AVG(TotalDue) OVER (PARTITION BY OrderDate ORDER BY OrderDate ASC) As MinRunningSale
FROM CTE_GetAggratgeData


SELECT ProductID,COUNT(SalesOrderID) OVER(PARTITION BY ProductID ORDER BY ProductID ) As NOofOrders
FROM Sales.SalesOrderDetail

--RankIng Window Functions

CREATE TABLE #Test
(
ID INT 
)

INSERT INTO #Test(ID)
VALUES(2),(2),(3),(3),(4),(2),(5),(6)

SELECT * FROM #Test

SELECT *,ROW_NUMBER()OVER(ORDER BY ID) As WithOutPartitionbyROwNumber
		,ROW_NUMBER()OVER(PARTITION BY ID ORDER BY ID) As WithPartitionbyROwNumber
		,RANK() OVER(ORDER BY ID) As WithOutPartitionbyRank
		,RANK() OVER(PARTITION BY ID ORDER BY ID) As WithPartitionbyRank
		,DENSE_RANK() OVER(ORDER BY ID) As WithOutPartitionbyDense
		,DENSE_RANK() OVER(PARTITION BY ID ORDER BY ID) As WithPartitionbyDense
		,NTILE(3) OVER(ORDER BY ID) As WithOutPartitionByNTILE
		,NTILE(2) OVER(PARTITION BY ID ORDER BY ID) As WithPartitionbyNTILE

FROM #Test


SELECT ID,COUNT(*) FROM #Test
GROUP BY ID
HAVING COUNT(*)>1

SELECT *,ROW_NUMBER()OVER(PARTITION BY ID ORDER BY ID) As Rnk FROM #Test

;WITH CTE_DeleteDup
AS
(
SELECT *,ROW_NUMBER()OVER(PARTITION BY ID ORDER BY ID) As Rnk FROM #Test
)
DELETE FROM CTE_DeleteDup
WHERE Rnk>1


SELECT * FROM #Test

;WITH CTE_GetAllSales
AS
(
SELECT  ST.Name As RegionName,SD.ProductID,SUM(SH.TotalDue) As TotDue,SUM(SD.OrderQty) As TotOrders
FROM Sales.SalesOrderDetail SD
JOIN Sales.SalesOrderHeader SH ON SD.SalesOrderID=SH.SalesOrderID
JOIN Sales.SalesTerritory ST ON SH.TerritoryID=ST.TerritoryID
GROUP BY ST.Name,SD.ProductID
)
,CTE_GetTopNSalesByRegion
AS
(
SELECT *,DENSE_RANK() OVER(PARTITION BY RegionName ORDER BY TotDue DESC) As Rnk
FROM CTE_GetAllSales
)
SELECT * FROM CTE_GetTopNSalesByRegion
WHERE Rnk<=5

/*
VALUE FUNCTIONS
*/

SELECT YEAR(OrderDate) As OrderedYear,SUM(TotalDue) As TotSlaes
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate)
ORDER BY 1

SELECT YEAR(OrderDate) As OrderedYear,SUM(TotalDue) As TotSlaes,LAG(SUM(TotalDue),1) OVER(ORDER BY YEAR(OrderDate)) As PreviousYearSale
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate)

SELECT YEAR(OrderDate) As OrderedYear,SUM(TotalDue) As TotSlaes,LAG(SUM(TotalDue),1) OVER(ORDER BY YEAR(OrderDate)) As PreviousYearSale
,SUM(TotalDue)-LAG(SUM(TotalDue),1) OVER(ORDER BY YEAR(OrderDate)) As SaleDiff
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate)


;WITH CTE_YearWise
AS
(
SELECT YEAR(OrderDate) As OrderedYear,SUM(TotalDue) As TotSlae
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate)
)
,CTE_PreviousYearSale
AS
(
SELECT *,LAG(TotSlae,1)OVER(ORDER BY  OrderedYear) As PreviousYearSales
FROM CTE_YearWise
)
SELECT *,(TotSlae-PreviousYearSales) As Diff FROM CTE_PreviousYearSale


/*
LEAD
*/
;WITH CTE_YearWise
AS
(
SELECT YEAR(OrderDate) As OrderedYear,SUM(TotalDue) As TotSlae
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate)
)
SELECT *,LEAD(TotSlae,1)OVER(ORDER BY  OrderedYear) As PrecedingYearSales
FROM CTE_YearWise

;WITH CTE_YearWise
AS
(
SELECT YEAR(OrderDate) As OrderedYear,SUM(TotalDue) As TotSlae
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate)
)
SELECT *,LEAD(TotSlae,2)OVER(ORDER BY  OrderedYear) As PrecedingYearSales
FROM CTE_YearWise


;WITH CTE_YearWise
AS
(
SELECT YEAR(OrderDate) As OrderedYear,SUM(TotalDue) As TotSlae
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate)
)
,CTE_PreviousYearSale
AS
(
SELECT *,LEAD(TotSlae,1)OVER(ORDER BY  OrderedYear) As PreviousYearSales
FROM CTE_YearWise
)
SELECT *,(TotSlae-PreviousYearSales) As Diff FROM CTE_PreviousYearSale


/*
FIRST_VALUE
*/
;WITH CTE_YearMonthWiseSales
AS
(
SELECT YEAR(OrderDate) As OrderedYear,MONTH(OrderDate) As OrderedMonth,SUM(TotalDue) As TotSlae
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate),MONTH(OrderDate)
)
SELECT *,FIRST_VALUE(TotSlae)OVER(ORDER BY TotSlae) FROM CTE_YearMonthWiseSales


;WITH CTE_YearMonthWiseSales
AS
(
SELECT YEAR(OrderDate) As OrderedYear,MONTH(OrderDate) As OrderedMonth,SUM(TotalDue) As TotSlae
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate),MONTH(OrderDate)
)
SELECT *,FIRST_VALUE(TotSlae)OVER(PARTITION BY OrderedYear ORDER BY OrderedMonth) FROM CTE_YearMonthWiseSales


/*
LAST_VALUE
*/

;WITH CTE_YearMonthWiseSales
AS
(
SELECT YEAR(OrderDate) As OrderedYear,MONTH(OrderDate) As OrderedMonth,SUM(TotalDue) As TotSlae
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate),MONTH(OrderDate)
)
SELECT *,LAST_VALUE(TotSlae)OVER(PARTITION BY OrderedYear ORDER BY OrderedMonth DESC) FROM CTE_YearMonthWiseSales

