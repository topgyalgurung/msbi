
-- INSERT MULTIPLE NULL VALUES INTO UNIQUE KEY COLUMN
CREATE UNIQUE NONCLUSTERED INDEX idx_mysql_notnull 
	ON myTable(mycolumn)
	WHERE myColumn IS NOT NULL;
	GO

-- RANKING FUNCTIONS --

--ROW_NUMBER()
-- rank() 
-- DENSE_RANK()
-- TOP N 

SELECT TOP 10 [product name], [shipping cost],
rank() over (order by [shipping cost] asc)
from 
productSales
where year([order date])=2013
AND month([order date]) in (1,6) 

--partition 

--derived table
select e.continent, e.EmpName,e.EmpSalary
from( select continent, empname, empsalary,
		rank() over(partition by continent order by empsalary desc) as 'rno'

--display top 10 customers in each customer segmentfor h
select rs.[customer segment], rs.[state or province]
from (
	select [state or province], [customer segment],
	rank() over(partition by [customer segment] order by sales
	from productsales
	where year([order date])=2010 rs

	)

--day 5 --
-- Derived Table --
CREATE TABLE Employee (
	eid int primary key,
	name varchar(25) not null,
	address varchar(30)
	);
	GO
CREATE TABLE Department(
	did int primary key,
	name varchar(16) not null,
	address varchar(30),
	empId int references Employee(eid) 
	);
	GO

Select * from Employee

-- display second highest salary
select top 1 *
( select top 2 * from Employee
	order by EmpSalary desc) e
ORDER BY EmpSalary asc

-- display continent wise top 3 employee details based on salaries
SELECT e.Continent, e.EmpName, e.EmpSalary
SELECT Continent, EmpName, EmpSalary,
RANK() OVER(PARTITION BY Continent ORDER BY EmpSalary DESC) 'rno'
FROM Employee ) e --alias key 

-- second highest salary

SELECT MAX(Salary) as salary FROM Employee
WHERE Salary <
(SELECT MAX(Salary) FROM Employee);

WITH CTE AS (
SELECT * DENSE_RANK() OVER (ORDER BY Salary DESC) AS Rnk
FROM Employees )
SELECT Name FROM CTE WHERE Rnk=2;

-- nested subquery
select * from result
where rollno IN (select rollno from student 
where courseid=1);

--correlated subquery
select name from student A
where 3 <(select count(*) from result B
where B.rollno=A.rollno);

--subquery
SELECT * FROM dbo.Emp e  
WHERE e.Id IN
(SELECT e2.Emp_Id from dbo.Employee e2); 

-- derived table
select * from (
select e.emp_id, e.employeeName
from employee e INNER JOIN project p
ON e.emp_id=p.project_id) tab
where tab.emp_id%2=1
