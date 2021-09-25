--SQL7 

-- create procedure

-- one parameter
CREATE PROCEDURE uspEmpDetails @City nvarchar(30)
AS SELECT * FROM uk_employees
 where city=@city  -- or where city like @city +'%'
GO

exec uspempdetails @city='new york'

--good practice to pass in all parameter values if not pass NULL 
CREATE PROCEDURE uspempdetails @city nvarchar(30)=null -- ..

-- multiple parameters
CREATE PROCEDURE uspempdetails @city varchar(30)=NULL, @addressline1 varchar(60)=NULL
AS SELECT * from uk_employees where city=ISNULL(@CITY,city)

--pass parameter value back out from a stored procedure
-- specified using 'OUTPUT' or 'OUT'
create procedure uspempdetailscount @addresscount int OUTPUT --.. or OUT

--DELETE PROCEDURE
drop PROCEDURE procedure_name

--modify procedure
ALTER PROCEDURE ...

-- TRY CATCH -- error handling

--passing multiple values through single parameter in stored procedure helpful in ssrs report

alter procedure sampleEmployee(
@EmpId nvarchar(max)
)
AS BEGIN
DECLARE @sql varchar(max)
SET @EmpId=REPLACE(@EmpId,',',''',''')
SET @sql='SELECT EmpId, EmpName, EmpLoc.. FROM SampleEmp 
WHERE EmpId in (''' +@EmpId+''')'
exec(@sql)
end

EXEC SampleEmployee '6,7,8'

-- ASSIGNMENT -- 
-- 1) Create a procedure which returns EmpName, job, sale & deptName of a given employee number
CREATE PROCEDURE EmpNum1
(
@EmpNum int
)
AS BEGIN EmpId, EmpName, EmpSalary, Continent, Country, EmpLoc
From employee
where (EmpNum=@EmpNum)
END

EXEC EmpNum1 2

--  DATA RETRIEVAL Store Procedure

-- 2) Write a store procedure to display NA Employees
CREATE PROCEDURE ContinentEmp1
(
	@Continent varchar(100) -- input parameter
)
AS BEGIN
SELECT EmpId, EmpName, EmpSalary, Continent, Country, EmpLoc
From Employee 
WHERE (Continent=@ContineNt)
END

EXEC ContinentEmp1 'NORTH AMERICA'

-- PROCEDURE to insert rows into multiple tables(employees, phone)
-- DATA LOADING 
CREATE PROCEDURE insertData
(
	@empno int,
	@empname varchar(20),
	@job varchar(15),
	@phoneno char(10)
)
AS BEGIN
INSERT INTO employees(empno, empname,job) VALUES(@empnp,@empname,@job)
INSERT INTO phone(empno,phoneno) values (@empno,@phoneno)
END

EXECUTE insertData 149, 'topgyal','data scientist'

--recursive stored procedure
CREATE PROCEDURE [dbo].[fact](
	@Number Integer,
	@RetVal Integer OUTPUT)
AS
DECLARE @in integer,
DECLARE @Out integer
if @Number!=1
BEGIN 
SELECT @in=@Number -1
exec fact @in, @out output
end 
else
begin
select @RetVal=1
end
return
go

select * from acm

-- count(*)
SELECT rows from sysindexes where id=object_id('acm') and indid<2

-- delete duplicate rows in SQL Server using CTE and Row number
WITH CTE AS (
SELECT col1, col2 ,
ROW_NUMBER() OVER (PARTITION BY col1 ORDER BY col1) rn
FROM dbo.Table1
)
DELETE FROM CTE WHERE rn>1

-- indexes example
CREATE TABLE sales(
id int identity(1,1),
productcode varchar(20),
price float(53),
datetransaction datetime);

CREATE PROCEDURE insertintoSales
AS
SET NOCOUNT ON
BEGIN
DECLARE @pc varchar(20)='A12CB'
DECLARE @price int=50
DECLARE @count int=0
while @count<20
BEGIN
SET @pc=@pc+cast(@count as varchar(20))
set @price=@Price +@count
INSERT INTO sales values(@pc,@Price,getdate())
set @pc='A12CB'
SET @price=50
set @count+=1
end
end

exec insertintoSales

select * from sales

SET STATISTICS IO ON
SELECT * FROM Sales where id=1899

SELECT TOP 10 * FROM SALES

create clustered index cl_id on sales(id);

set statistics io on
select * from sales where productcode like 'A12CB908%' ORDER BY price

create nonclustered index nonci_pc on sales(productcode);

SET STATISTICS IO ON
select * from sales where productcode like 'A12CB908%' ORDER BY PRICE

DROP INDEX Sales.CL_ID;

SET STATISTICS IO ON
SELECT * FROM Sales where productcode like 'A12CB908%' ORDER BY Price

CREATE Index IX_sales_price ON sales (price ASC);

SP_HELPINDEX sales;

Drop index sales.nonci_pc;