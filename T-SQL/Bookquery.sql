USE topgyalDB;

-- THE LANGUAGE OF SQL BOOK --

select * from DimCity
select * from DimProperty

-- ch 3.calculated fields and aliases
with cte as (
SELECT cityname, p.propertyname FROM Dimcity d
INNER JOIN DimProperty p ON d.city_id=p.property_id
)
select concat(propertyname,' ',cityname),
cityname+ ' '+propertyname FROM cte WHERE cityname=' mumbai'

SELECT 5,cityname  FROM  DimCity

--ch 4. Using Functions
SELECT LEFT('SUNLIGHT',3) AS 'THE ANSWER'
SELECT RIGHT('SUNLIGHT',5) AS 'the answer'

SELECT SUBSTRING('TOPGYAL',4,4)  --SUBSTRING('str',start,end)
SELECT SUBSTRING('TOPGYAL',-6,2) 

SELECT LTRIM('   THE APPLE') AS 'apple'
SELECT RTRIM('President   ') 
SELECT RIGHT(RTRIM('George washington'),10) as 'trim'
SELECT RIGHT('George Washington',10)

SELECT UPPER('abraham lincoln') as 'to upper case',
LOWER('ABRAHAM LINCOLN') AS 'to lower'

SELECT GETDATE()
SELECT DATEPART(month,'5/6/2017')
SELECT DATEDIFF(day, '7/8/2017','9/7/2017')

 SELECT ROUND(328.323,2)
 SELECT ROUND(132.21, -2)
 SELECT ROUND(PI(),2)
 SELECT POWER(5,2) AS '5 Squared'
 SELECT POWER(25,.5) AS 'Square root'

 SELECT '2017-04-11' AS 'original date',
	 CAST('2017-04-11' AS DATETIME) AS 'Converted Date'

 -- SELECT ISNULL(Weight AS VARCHAR), 'UNKNOWN') AS null -- if weight contains null, change to unknown

 -- CH 5 Sorting Data
 
 --CH 6 SELECTION CRITERIA
 SELECT * from FactCustomer
 
 -- pattern matching
 /* 
 WHERE movietitle like '%LOVE%'
  '%love' -- end with love
 'love%' -- begin with love
  '% love % '
 WHERE firstName like '_ARY' --one char before
 ' J_N' 
 WHERE firstName LIKE '[CM]ARY'  -- beging with C or M and ends with ARY
 .. LIKE '[^CM]ARY' -- does not begin with C or M and ends with ARY

*/

-- CH 7 Boolean Logic
SELECT  cityname from DimCity where NOT(cityname='pune' OR city_id <>4) -- <> NOT
SELECT  cityname from DimCity where city_id BETWEEN 2 AND 5 
SELECT  city_id,cityname from DimCity where cityname NOT IN ('pune')

-- ch 8 CONDITIONAL LOGIC --

SELECT cityname,
CASE Cityname 
WHEN ' mumbai' THEN 'Capital'
ELSE 'not capital'
END AS 'yes/no' FROM DimCity
-- OR --
select cityname,
CASE when  cityname='mumbai' then 'capital'
ELSE 'not capital'
END AS 'yes/no' FROM DimCity
-- case IN order by & in WHERE 

-- SUMMARIZING DATA

-- Subtotals and Crosstabs
SELECT Category, subcategory,SUM(Category) as 'Quantity' 
FROM Inventory GROUP BY ROLLUP(Category, subcategory) ORDER BY Category, Subcategory