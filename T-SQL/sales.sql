/****** Script for SelectTopNRows command from SSMS  ******/

--SalesOrderDetail, SalesTerritory, SalesOrderHeader

  SELECT TOP (2) [BusinessEntityID]
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [AdventureWorks2008R2].[Person].[Person]

     SELECT TOP (2) [BusinessEntityID]
      ,[NationalIDNumber]
      ,[JobTitle]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [AdventureWorks2008R2].[HumanResources].[Employee]

    SELECT TOP (1) [BusinessEntityID]
      ,[TerritoryID]
      ,[SalesYTD]
      ,[SalesLastYear]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [AdventureWorks2008R2].[Sales].[SalesPerson]

   SELECT TOP (2) [SalesOrderID]
      ,[RevisionNumber]
      ,[SalesOrderNumber]
      ,[PurchaseOrderNumber]
      ,[AccountNumber]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[TerritoryID]
      ,[SubTotal]
      ,[TotalDue]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [AdventureWorks2008R2].[Sales].[SalesOrderHeader]

SELECT TOP (2) [SalesOrderID]
      ,[SalesOrderDetailID]
      ,[OrderQty]
      ,[ProductID]
      ,[UnitPrice]
      ,[UnitPriceDiscount]
      ,[LineTotal]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [AdventureWorks2008R2].[Sales].[SalesOrderDetail]

/*
   SELECT TOP (5) [TerritoryID]
      ,[Name]
      ,[CountryRegionCode]
      ,[Group]
      ,[SalesYTD]
      ,[SalesLastYear]
      ,[CostYTD]
      ,[CostLastYear]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [AdventureWorks2008R2].[Sales].[SalesTerritory]
*/
 -- CHECK IF soh.SalesPersonID=sa.BusinessEntityID
 SELECT top 5 lastname,firstname,sa.BusinessEntityID, SalesPersonID
 FROM Person.Person pe
  INNER JOIN Sales.SalesPerson sa ON sa.BusinessEntityID=pe.BusinessEntityID
 INNER JOIN Sales.SalesOrderHeader soh ON soh.SalesPersonID=sa.BusinessEntityID

 SELECT top 5 lastname,firstname, em.JobTitle,sa.SalesLastYear, sa.SalesYTD,soh.SubTotal,sod.linetotal
 FROM Person.Person pe
 INNER JOIN HumanResources.Employee em ON Em.BusinessEntityID=pe.BusinessEntityID
 INNER JOIN Sales.SalesPerson sa ON sa.BusinessEntityID=pe.BusinessEntityID
 INNER JOIN Sales.SalesOrderHeader soh ON soh.SalesPersonID=sa.BusinessEntityID
 INNER JOIN Sales.SalesOrderDetail sod ON sod.SalesOrderID=soh.SalesOrderID
 WHERE lastname='mitchell'

-- more joins not needed
 SELECT top 5 lastname AS [Last Name],firstname AS [First Name], SUM(linetotal) AS sumtotal
  FROM Person.Person pe
 INNER JOIN HumanResources.Employee em ON Em.BusinessEntityID=pe.BusinessEntityID
 INNER JOIN Sales.SalesPerson sa ON sa.BusinessEntityID=pe.BusinessEntityID
 INNER JOIN Sales.SalesOrderHeader soh ON soh.SalesPersonID=sa.BusinessEntityID
 INNER JOIN Sales.SalesOrderDetail sod ON sod.SalesOrderID=soh.SalesOrderID
 Group by firstname,lastname
 ORDER BY sumtotal desc

  -- CHECK IF soh.SalesPersonID=sa.BusinessEntityID
 SELECT top 5 lastname,firstname,sa.BusinessEntityID, SalesPersonID
 FROM Person.Person pe
  INNER JOIN Sales.SalesPerson sa ON sa.BusinessEntityID=pe.BusinessEntityID
 INNER JOIN Sales.SalesOrderHeader soh ON soh.SalesPersonID=sa.BusinessEntityID
 
 SELECT top 5 lastname AS [Last Name],firstname AS [First Name], SUM(linetotal) as sumtotal
  FROM Person.Person pe
   INNER JOIN Sales.SalesOrderHeader soh ON soh.SalesPersonID=pe.BusinessEntityID
   INNER JOIN Sales.SalesOrderDetail sod ON sod.SalesOrderID=soh.SalesOrderID
    Group by firstname,lastname
 ORDER BY sumtotal desc

