
--  Assignment -- SQL5 RANKING_ProductSalesReportTasks.sql
-- Topgyal Gurung 

--2) Display bottom 10 states based on sales------------------
   select top 10 [State or Province],Sales, 
	    rank() over(order by Sales asc) rank
	from ProductSales 

--1)Display top 10 states based on sales for the year 2010
SELECT TOP 10 [State or Province], Sales,
	RANK() OVER (ORDER BY Sales ASC) rank
	FROM ProductSales WHERE year([Order Date])=2012

    SELECT TOP 10 [State or Province],[Sales],year([Order Date]) year,
	       RANK() OVER(order by Sales desc) rank
	from ProductSales where year([Order Date]) in  (2009,2010)


--4)Display top 10 products by discount for the year 2013  -- HW --
SELECT TOP 10 [Product Name], Discount, year([Order Date]) year,
RANK() OVER (ORDER BY DISCOUNT DESC) rank_by_disc
FROM ProductSales WHERE year([Order Date])=2013;

--Display top 3 customers in each state based on sales --USING DERIVED TABLE
   select RS.[State or Province],RS.[Customer Name],RS.Rno
   from (   select [State or Province],[Customer Name],
          rank() over(Partition by [State or Province] order by [Sales] desc) as 'Rno'
   from ProductSales) RS where Rno<=3

 --Display the top 5 customers in each state based on sales -- HW --
 SELECT RS.[State or Province], RS.[Customer Name], RS.Rno
	FROM (
		SELECT [State or Province], [Customer Name],
		RANK() OVER (PARTITION BY [State or Province] ORDER BY [Sales] desc) as 'Rno'
		FROM ProductSales
		) RS
		WHERE Rno<=5

-- HW--
--3)Display top 10 customers in each state for different year on the home office customer segment -- HW --

SELECT [Customer Name], [State or Province], [Customer Segment],[Order Date]
FROM ProductSales;
Select distinct [Customer Segment] from ProductSales;
select count( distinct [State or Province]) from ProductSales;
SELECT distinct year([Order date]) from ProductSales;

---
	SELECT RS.[Customer Name], RS.[State or Province],  RS.year,RS.[Customer Segment],RS.Rno, rs.Sales FROM(
		SELECT [State or Province],[Customer Name],  YEAR([Order Date]) year, [Customer Segment], [Sales],
		RANK() OVER (PARTITION BY [Customer Segment],[State or Province],year([Order Date]) ORDER BY [Sales] desc) as 'Rno'
		FROM ProductSales) RS
	WHERE Rno<=10 AND [Customer Segment]='Home office'
---
--6)Display top 10 customers in each Customer Segment for the year 2010 in each state under usa
	select RS.[Customer Segment],RS.[State or Province],RS.[Customer Name],RS.Rno,RS.Sales,RS.[Year]
	from (	select  [State or Province],[Customer Segment],[Customer Name],year([Order Date]) as 'Year',Sales,
	              rank() over(partition by [Customer Segment],[State or Province] order by Sales desc) as 'Rno'
    from ProductSales
	Where year([Order Date]) = 2010) RS
    where Rno < =10

-- HW --
--7)display the small size top 10 customers based on the order quantity- - hw --
-- small size ? -- customer segment?
SELECT DISTINCT [Customer Segment] from ProductSales;

	SELECT TOP 10 [Customer Name],[Customer Segment],[Quantity ordered new],
	RANK() over (order by [Quantity ordered new ] DESC) rno
	FROM ProductSales WHERE [Customer Segment] in ('home office','small business','consumer')

--hw--
--8)display the least 10 items based on the shipping cost for the year 2013 in jan june---HW--
SELECT TOP 10 [Product Name], [Shipping Cost],month([order date])month,year([Order Date]) year,
	DENSE_RANK() OVER(ORDER BY [Shipping Cost] asc) 'rno'  --RANK()
	FROM ProductSales 
	WHERE YEAR([Order date])=2013 AND MONTH([Order date]) in (1,6);

--HW--
--9)display the technology wise least 10 items based on sales for the corporate customer segment---HW-
SELECT RN.[Product Name],RN.[Sales], RN.[Customer Segment], RN.[Product Category]
FROM (
SELECT [Product Name],[Sales],[Customer Segment],[Product Category],
	RANK() OVER(PARTITION BY [Customer Segment] ORDER BY SALES ASC)'rno'
	FROM ProductSales
	WHERE [Product Category]='Technology' AND [Customer Segment]='corporate') RN
	WHERE rno<=10;

--10)display the top 10 items in the office machines product SUB-category based on the 
--product based margine
SELECT TOP 10 [Product Sub-Category], [Product Base Margin],
RANK() OVER(ORDER BY [Product Base Margin] DESC) 'rno'
FROM ProductSales
WHERE [Product Sub-Category]='office machines'

-----------------------------------------------
--1)Display the top 10 states  based on sales for East region for the year 2010 and 2012
SELECT TOP 10 [State or Province], Sales, Region, [Order date], 
RANK() OVER(Order by Sales Desc) as 'rno'
from [dbo].ProductSales
where year([Order date]) in (2010,2012) and region='east'

--hw--
--2)Display the least 5 states  based on profits for the year 2010 and 2011-----HW----------
	SELECT TOP 5 [State or Province],[Profit], year([Order Date]) year,
	RANK() OVER(PARTITION BY [State or Province] ORDER BY Profit ASC) 
	FROM ProductSales 
	WHERE year([Order Date]) in (2010,2011);

--hw --
--1)Display the top 10 states  based on sales for south region for the year 2010 and 2012-----
	SELECT TOP 10 [State or Province], [Sales] AS [south Sales], year([Order Date]) year,
	RANK() OVER(PARTITION BY [State or Province] ORDER BY Sales DESC) 'Rno'
	FROM ProductSales
	WHERE year([Order Date]) in (2010,2012) AND Region= 'South'

--  COMBINED SETS: UNION INTERSECT EXCEPT --

--1)Display the top 10 states  based on sales for south region for the year 2010 and 2012-----
Select TOP 10 [State or Province], Sales, Region, year([Order Date]), RANK() OVER(Order By Sales DESC) AS RNO
FROM [dbo].[ProductSales]
WHERE year([Order Date])= 2010 AND  Region='South' 
UNION 
Select TOP 10 [State or Province], Sales, Region, year([Order Date]), RANK() OVER(Order By Sales DESC) AS RNO
FROM [dbo].[ProductSales]
WHERE year([Order Date])= 2012 AND  Region='South'
Order by year([Order Date])


--2)Display the least 5 states  based on profits for the year 2010 and 2011---
Select TOP 5 [State or Province],  Profit, year([Order Date]),  RANK() OVER(Order By Profit DESC) AS RNO
FROM [dbo].[ProductSales]
WHERE year([Order Date])= '2010'
UNION
Select TOP 5 [State or Province],  Profit, year([Order Date]),  RANK() OVER(Order By Profit DESC) AS RNO
FROM [dbo].[ProductSales]
WHERE year([Order Date])= '2011'
Order by year([Order Date])

--3)Display state wise  top 10 products based on shipping cost for the year 2010,2011,2012 
SELECT RS.[State or Province],RS.[Product Name],RS.[Shipping Cost],RS.year,RS.RNO 
FROM(
	SELECT [State or Province],[Product Name],[Shipping Cost],year([Order Date]) as 'year',
    Rank() over(partition by [State or Province],year([Order Date]) order by [Shipping Cost] desc) RNO 
	from ProductSales 
    where year([Order Date]) in (2010,2011,2012)) RS
WHERE RNO<=10


Select TOP 10 [State or Province],  [Shipping Cost], [Order Date],  RANK() OVER(Order By [Shipping Cost] DESC) AS RNO
FROM ProductSales
WHERE [Order Date] = '2010'
UNION
Select TOP 10 [State or Province],  [Shipping Cost], [Order Date],  RANK() OVER(Order By [Shipping Cost] DESC) AS RNO
FROM ProductSales
WHERE [Order Date] = '2011'
UNION
Select TOP 10 [State or Province],  [Shipping Cost], [Order Date],  RANK() OVER(Order By [Shipping Cost] DESC) AS RNO
FROM ProductSales
WHERE [Order Date] = '2012'

-- SECTION C --
--Display the sales contribution of frequently ordered items in which each item is ordered  at least for 20 times-
SELECT [Product Name], [Quantity ordered new], [Sales]
from ProductSales
WHERE [Quantity Ordered new]>=20
ORDER BY [Product Name] ASC;
