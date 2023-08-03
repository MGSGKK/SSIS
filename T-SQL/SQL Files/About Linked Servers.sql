/*
Linked Servers
*/

SELECT * FROM [SQLB14].dbo.EMP

SELECT * FROM [KIRANKUMARG\MSSQL_B13].[AdventureWorksDW2019].[dbo].[DimDate]

SELECT * FROM OPENQUERY([KIRANKUMARG\MSSQL_B13],'SELECT * FROM [AdventureWorksDW2019].[dbo].[DimDate]' )


exec sp_linkedservers

select * from sys.servers