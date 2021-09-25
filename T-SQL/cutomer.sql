/****** Script for SelectTopNRows command from SSMS  ******/

-- CUSTOMER, STORE, 
SELECT TOP (5) [CustomerID]
      ,[PersonID]
      ,[StoreID]
      ,[TerritoryID]
      ,[AccountNumber]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [AdventureWorks2008R2].[Sales].[Customer]

  SELECT TOP (100) [BusinessEntityID]
      ,[Name]
      ,[SalesPersonID]
      ,[Demographics]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [AdventureWorks2008R2].[Sales].[Store]

