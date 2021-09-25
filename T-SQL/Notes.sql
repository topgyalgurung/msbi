CREATE DATABASE topgyalDB;
USE topgyalDB;

-- TOPICS --
-- BASIC DDL, DML 								
-- SUBQUERY 
-- table variable 

-- day one --

CREATE TABLE Dept_master(   -- create table
did int primary key,
dname varchar(15) not null
)

CREATE TABLE Emp_trans(
empid int primary key,
empname varchar(15) not null,
empage int check(empage>=25 and empage<=50),
[location] varchar(15) default 'atlanta',
dlno varchar(15) unique,
did int foreign key references dept_master(did)
)

/*
ALTER TABLE table_name add column_name datatype -- add column
DROP TABLE table_name		--delete table
UPDATE table_name set column_name=value  WHERE primary_key_name=value


*/

CREATE TABLE customer( id int primary key, name varchar(16), phn int)
CREATE TABLE Employee(id int IDENTITY(1,1) primary key , name varchar(16)) --auto-increment
INSERT INTO Customer values(1,'topgyal',3479359179) -- arithmetic overflow int upto 9 digit

select * from Customer
truncate table Customer;    -- empty table

-- alter column data type
ALTER table customer alter column phn varchar(10)

--insert into table
INSERT INTO customer values(1, 'topgyal','3479359179')
INSERT INTO Customer (id, phn) values (2,'3479992221')

update customer set name='sonam' where id=2;

--SQL4, sql5.docx

select * into customer_backup from customer --create table in runtime
-- insert into require that table already exist
select * from customer_backup

-- merge command can perform insertions, updates and deletions in a single statement
CREATE TABLE master_table (pid int, sales int, status varchar(6));
CREATE TABLE delta_table(pid int, sales int, status varchar(6));

INSERT INTO master_table values (1,12,'CURR');
INSERT INTO master_table values (2,13,'NEW');
insert into delta_table values(2,24,'CURR'); 
INSERT INTO delta_table values (3,0,'OBS');

SELECT *FROM master_table
SELECT * FROM delta_table

SELECT m.pid, m.sales, m.status from master_table m
LEFT OUTER JOIN delta_table e 
ON m.pid=e.pid

-- unions
select pid, sales from master_table
UNION 
SELECT pid,sales from delta_table
ORDER BY pid


MERGE INTO master_table m USING delta_table d
	ON (m.pid=d.pid)
	WHEN matched THEN UPDATE set m.sales=m.sales+d.sales,
		 m.status=d.status
		 --delete where m.status='OBS'
	WHEN NOT MATCHED THEN
		INSERT VALUES (d.pid,d.sales,'NEW');
	

								
-- SUBQUERY --
-- Who has the second highest balance in the bank?
SELECT empname from emp WHERE Sal=(
SELECT TOP 1 Sal FROM (SELECT DISTINCT TOP 2 Sal FROM Emp ORDER BY Sal DESC)a
ORDER BY Sal)

-- who has the 4th highest balance in the bank?
SELECT Name FROM Acct_master WHERE CBalance=(
	SELECT MIN(Balance) FROM Acct_master
	WHERE CBalance IN ( SELECT DISTINCT TOP 4 CBalance FROM ACCT_MASTER	
		ORDER BY CBalance DESC)

-- ISNULL()
SELECT ISNULL(partyLoc,'chen') FROM Employee

--COALESCE() save lot of if or case decision logic
SELECT partyName, COALESCE(partyName, null,1) AS CurrentPrice FROM Party

-- find duplicate records by using GROUP BY
SELECT FirstName, LastName, COUNT(*) AS RecordCnt
FROM dbo.Customer GROUP BY FirstName, LastName
HAVING COUNT(*)>1

-- find duplicate records using CTE
WITH CTE AS (
	SELECT FirstName, LastName, 
	ROW_NUMBER() OVER(PARTITION BY FirstName, LastName ORDER BY (SELECT 1)) AS Rn 
	FROM dbo.Customer)
	SELECT * FROM CTE WHERE Rn>1

--user defined error messages
RAISERRO('Cannot INSERT WHERE salaray>1000');

--TABLESAMPLE to extract sample of rows randomly based on % of rows
select * from sales TABLESAMPLE(100 rows)

-- data copy from one table to another
SELECT INTO vs INSERT INTO SELECT

GETDATE VS SYSDATETIME

-- to get list of triggers in the database
SELECT * FROM sys.objects where type='tr'

-- march 13. Friday
--CAST and CONVERT() Functions

declare @bal float
set @bal=500.50

print 'Balance is: '+ CONVERT(varchar(20),@bal)

select getdate()
select convert(varchar(20),getdate())
select convert(varchar(20),getdate(),1)
select convert(varchar(20),getdate(),2)

--CAST --
print 'Balance is: ' +cast(@bal as varchar(25))

-- table variable --
declare @Sample table 
( EmpId int primary key,
  EmpName char(10),
  EmpSal  float,
  EmpTax float
)
insert into @Sample values (10, 'topgyal')
insert into @Sample values(11,'ram')
select * from @Sample   -- HAVE TO Run all together

--loading into table variable from extracting data from Employee table
insert into @Sample(EmpId,EmpName,EmpSal,EmpTax)
SELECT EmpId,EmpName, EmpSalary, (5*EmpSalary)/100 AS 'EmpTax' FROM Employee

SELECT *INTO DestEmp FROM @Sample --DestEmp table
SELECRT * FROM DestEmp

--TEMPORARY TABLE -- tempdb
CREATE TABLE #Sample
( EmpId int primary key,
  EmpName char(10),
  EmpSal  float,
  EmpTax float
)
insert into #Sample(EmpId,EmpName,EmpSal,EmpTax)
SELECT EmpId,EmpName, EmpSalary, (5*EmpSalary)/100 AS 'EmpTax' FROM Employee

SELECT *INTO DestEmp FROM #Sample --DestEmp table
SELECRT * FROM DestEmp

-- TRY CATCH -- handling errors
--INSIDE stored procedure 
-- Step 1: Create Procedure
CREATE PROCEDURE TryCatchTest07
begin

AS 
BEGIN TRY
	select 1/0
END TRY
BEGIN CATCH
	SELECT
	ERROR_NUMBER() AS ErrorNumber,
	ERROR_SEVERITY() AS ErrorSeverity,
	ERROR_STATE() AS ErrorState,
	ERROR_PROCEDURE() AS ErrorProcedure,
	ERROR_LINE() AS ErrorLine,
	ERROR_MESSAGE() AS ErrorMessage
END CATCH
END

--step 2: execute procedure
EXECUTE TryCatchTest07

-- create simple store procedure  
CREATE Procedure DisEmp( @Continent varchar(15))
AS
BEGIN
SELECT * FROM Employee
WHERE Continent=@Continent
END
-- call the procedure
EXECUTE DisEmp 'asia' -- passing parameter

/*a) user defined store procedure
b) system defined store procedure */

sp_help DimCustomer

sp_helptext procedurename -- to get code of procedure

--input and output

--CALL STORED PROCEDURE
DECLARE @Balance MONEY
EXEC GetBalance 5, @Balance OUT
PRINT @Balance


-- T-SQL Variable

-- local varibale
DECLARE @name varchar(15)
SET @name='topgyal'
print @name

-- global variable
print @@version
print @@servername

-- conditional statement
declare @age int
set @age=25
if(@age>=18 and @age<60)
	begin
		print 'candidate is eligible'
	end
else
	begin
		print 'candidate is not eligible'
	end

-- load even numbers into database table in between 1 and 100

create table evenload(
	num int
	)
declare @number int
set @number=1
while(@number<=100)
	insert into evenload values (@number)
	if(@Number %2=0)
		begin 
			print @number
			set @number=@number+1
		end
	else
		begin
			set @number=@number+1
		end

select count(*) from employee
select sum([rows]) from sys.partitions where object_id=object_id('employee')


