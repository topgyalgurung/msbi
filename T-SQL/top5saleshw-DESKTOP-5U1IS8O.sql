 USE [dbo].[AdventureWorks2008R2]
 -- topgyal Gurung
 -- practice for test --
 -- query notes ---
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
 
 SELECT top 5 lastname AS [Last Name],firstname AS [First Name], SUM(linetotal) as SalesAmount
  FROM Person.Person pe
   INNER JOIN Sales.SalesOrderHeader soh ON soh.SalesPersonID=pe.BusinessEntityID
   INNER JOIN Sales.SalesOrderDetail sod ON sod.SalesOrderID=soh.SalesOrderID
  -- WHERE       (PC.ProductCategoryID = 1 AND (PS.ProductSubcategoryID =2)) 
--and soh.orderdate>'01/01/2003' and soh.orderdate<'12/31/2003'
    Group by firstname,lastname
 ORDER BY sumtotal desc

 ----------------------------------------------------------------------------------
 -- NOTES -- 
 -- from query example 

 SELECT TOP 5 PER.LastName, PER.FirstName, E.[BusinessEntityID], 
SUM(DET.LineTotal) AS SaleAmount
FROM 
[Sales].[SalesPerson] SP 
INNER JOIN [Sales].[SalesOrderHeader] SOH 
ON SP.[BusinessEntityID] = SOH.[SalesPersonID]
INNER JOIN Sales.SalesOrderDetail DET        
ON SOH.SalesOrderID = DET.SalesOrderID
INNER JOIN [Sales].[SalesTerritory] ST  
ON SP.[TerritoryID] = ST.[TerritoryID] 
INNER JOIN [HumanResources].[Employee] E 
ON SOH.[SalesPersonID] = E.[BusinessEntityID] 
INNER JOIN [Person].[Person] PER     
ON PER.[BusinessEntityID] = SP.[BusinessEntityID]
INNER JOIN Production.Product P 
ON DET.ProductID = P.ProductID 
INNER JOIN   Production.ProductSubcategory PS 
ON P.ProductSubcategoryID = PS.ProductSubcategoryID 
INNER JOIN  Production.ProductCategory PC 
ON PS.ProductCategoryID = PC.ProductCategoryID
WHERE       (PC.ProductCategoryID = 1 AND (PS.ProductSubcategoryID =2)) 
and soh.orderdate>'01/01/2005' and soh.orderdate<'12/31/2005'
 GROUP BY    PER.LastName, PER.FirstName, E.[BusinessEntityID]
ORDER BY    SUM(DET.LineTotal) DESC

-- Simplified query without Top5 -- FOR SALES PERSON NAMES

SELECT PER.LastName, PER.FirstName, E.BusinessEntityID, 
SUM(DET.LineTotal) AS SaleAmount
FROM 
Sales.SalesPerson SP,Sales.SalesOrderHeader SOH ,
Sales.SalesOrderDetail DET,Sales.SalesTerritory ST,
HumanResources.Employee E,Person.Person PER,
Production.Product P,Production.ProductSubcategory PS,
Production.ProductCategory PC 
WHERE

SP.BusinessEntityID = SOH.SalesPersonID AND
SOH.SalesOrderID = DET.SalesOrderID AND
SP.TerritoryID = ST.TerritoryID AND
SOH.SalesPersonID = E.BusinessEntityID AND
PER.BusinessEntityID = SP.BusinessEntityID AND
DET.ProductID = P.ProductID AND
P.ProductSubcategoryID = PS.ProductSubcategoryID  AND
PS.ProductCategoryID = PC.ProductCategoryID AND

PC.ProductCategoryID = 1 AND PS.ProductSubcategoryID =2 
and soh.orderdate>'01/01/2008' and soh.orderdate<'12/31/2008'
GROUP BY    PER.LastName, PER.FirstName, E.BusinessEntityID
ORDER BY    SUM(DET.LineTotal) DESC


--PC.ProductCategoryID = @PC AND PS.ProductSubcategoryID =@PSC
-- and soh.orderdate>@SD and soh.orderdate<@ED

SELECT top 5
    S.Name as Store, C.StoreID, COUNT(SOH.SalesOrderID) as NSalesOrders, 
SUM(DET.LineTotal) as SaleAmount 
FROM Sales.SalesOrderHeader SOH
    INNER JOIN [Sales].[Customer] C    ON C.[CustomerID] = SOH.[CustomerID]
    INNER JOIN [Sales].[Store] S ON C.StoreID = S.BusinessEntityID
    INNER JOIN Sales.SalesOrderDetail DET ON  DET.SalesOrderID = SOH.SalesOrderID
    INNER JOIN Production.Product P ON P.ProductID = DET.ProductID
    INNER JOIN Production.ProductSubcategory PS ON 
P.ProductSubcategoryID =  PS.ProductSubcategoryID 
WHERE C.StoreID IS NOT NULL
   AND PS.ProductCategoryID = 1
   AND PS.ProductSubcategoryID = 2
 and soh.orderdate>'01/01/2008' and soh.orderdate<'12/31/2008'
GROUP BY  S.Name, C.StoreID
ORDER BY    SUM(DET.LineTotal) DESC


--Simplified query without top5  -- FOR STORE --
SELECT S.Name as Store, C.StoreID, COUNT(SOH.SalesOrderID) as NSalesOrders, 
SUM(DET.LineTotal) as SaleAmount 
FROM Sales.SalesOrderHeader SOH,Sales.Customer C,Sales.Store S,
Sales.SalesOrderDetail DET,Production.Product P,Production.ProductSubcategory PS
where
C.CustomerID = SOH.CustomerID and
C.StoreID = S.BusinessEntityID and
DET.SalesOrderID = SOH.SalesOrderID and
P.ProductID = DET.ProductID and
P.ProductSubcategoryID =  PS.ProductSubcategoryID  and
 C.StoreID IS NOT NULL
   AND PS.ProductCategoryID = 1
   AND PS.ProductSubcategoryID = 2
 and soh.orderdate>'01/01/2003' and soh.orderdate<'12/31/2003'
GROUP BY  S.Name, C.StoreID
ORDER BY    SUM(DET.LineTotal) DESC

-- for drop down --
 SELECT DISTINCT TOP 5 PER.LastName, PER.FirstName, E.[BusinessEntityID],  PC.Name AS [Product Category], PS.Name AS[ Product Subcategory],FORMAT(P.SellStartDate,'mm/dd/yyyy') AS startdate,FORMAT(P.SellEndDate,'mm/dd/yyyy') AS endDate,
SUM(DET.LineTotal) AS SaleAmount
FROM 
[Sales].[SalesPerson] SP 
INNER JOIN [Sales].[SalesOrderHeader] SOH 
ON SP.[BusinessEntityID] = SOH.[SalesPersonID]
INNER JOIN Sales.SalesOrderDetail DET        
ON SOH.SalesOrderID = DET.SalesOrderID
INNER JOIN [Sales].[SalesTerritory] ST  
ON SP.[TerritoryID] = ST.[TerritoryID] 
INNER JOIN [HumanResources].[Employee] E 
ON SOH.[SalesPersonID] = E.[BusinessEntityID] 
INNER JOIN [Person].[Person] PER     
ON PER.[BusinessEntityID] = SP.[BusinessEntityID]
INNER JOIN Production.Product P 
ON DET.ProductID = P.ProductID 
INNER JOIN   Production.ProductSubcategory PS 
ON P.ProductSubcategoryID = PS.ProductSubcategoryID 
INNER JOIN  Production.ProductCategory PC 
ON PS.ProductCategoryID = PC.ProductCategoryID
WHERE       (PC.ProductCategoryID = 1 AND (PS.ProductSubcategoryID =2)) 
and soh.orderdate>='01/01/2005' and soh.orderdate<='12/31/2005'
 GROUP BY    PER.LastName, PER.FirstName, E.[BusinessEntityID],ps.name, pc.name,p.SellStartDate,p.SellEndDate
ORDER BY    SUM(DET.LineTotal) DESC


-- NOTES -- Second Highest Salary
--1) 
SELECT 
	 MAX(BaseRate) from [Sales].[dbo].[Employee]
  WHERE BaseRate<(
		SELECT MAX(Baserate) FROM  [Sales].[dbo].[Employee]
	)
-- 2) 
	WITH second_max AS(
	select baserate,
		DENSE_RANK() OVER(ORDER BY Baserate Desc) AS Rnk
	FROM [Sales].[dbo].[Employee]
	)
	SELECT Baserate from second_max 
	where rnk=2;
-- 3) 
	SELECT TOP 1 baserate
	FROM (
		SELECT DISTINCT TOP 2 BaseRate FROM employee
		ORDER BY Baserate Desc) a
	ORDER BY Baserate