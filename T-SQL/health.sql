CREATE TABLE DimDepartment(
DepartmentId int primary key,
DepartmentName nvarchar(50)
)

CREATE TABLE DimClaim(
ClaimId int primary key,
PrimaryPayerId int,
ServiceDate date,
ProviderId int,
ServiceDepartmentId int foreign key references DimDepartment(DepartmentId)
)

CREATE TABLE Dim_Date(
Date date primary key,
DateKey int,
Month int,
MonthName nvarchar(50),
MonthName_Short nvarchar(50),
Quarter int,
Year int,
YearMonth nvarchar(50),
FirstDateOfMonth date,
LastDateOfMonth date
)

Create Table DimPayer(
PayerId int primary key,
PayerName nvarchar(50),
FinancialClass nvarchar(50)
)

CREATE TABLE Fact_Transaction (
TransactionId int primary key,
ClaimId int foreign key references DimClaim(ClaimId),
PostDate date foreign key references Dim_Date(Date),
TransactionPayerId int foreign key references DimPayer(PayerId),
TransactionType nvarchar(50),
Amount int
)

SELECT TOP 2 * FROM DIM_DATE
SELECT TOP 2 * FROM DIMCLAIM
SELECT TOP 2 * FROM DIMDEPARTMENT
SELECT TOP 2 * FROM DIMPAYER
SELECT TOP 2 * FROM Fact_Transaction

/*
 1.	Create a visual that shows the following metrics by Facility (DEPARTMENTNAME) with a drill down to view the same metrics by the transaction FINANCIALCLASS: 
	a.	Total Charges: Sum of transaction amount for transaction type CHARGE
	b.	Total Payments: Sum of transaction amount for transaction type PAYMENT
	c.	Realization Rate: Total Payments as a percent of Total Charges; this represents what share of charges Alteon has been able to collect
*/

SELECT DepartmentName, FinancialClass, TransactionType,amount
FROM DimDepartment d
INNER JOIN DimClaim c ON c.ServiceDepartmentId=d.DepartmentId
INNER JOIN Fact_Transaction t ON t.ClaimId=c.ClaimId
INNER JOIN DimPayer p ON p.PayerId=t.TransactionPayerId
--WHERE TransactionType='CHARGE' or PAYMENT

--simplified
SELECT DepartmentName, FinancialClass, TransactionType,amount
FROM DimDepartment d,DimClaim c, Fact_Transaction t,DimPayer p
WHERE
c.ServiceDepartmentId=d.DepartmentId AND
t.ClaimId=c.ClaimId AND
p.PayerId=t.TransactionPayerId

/*
2.From the total payments collected, leadership wants to understand how quickly they are collecting those payments. 
Create a visual that shows by facility what percent of total payments collected were posted in each month by (POSTDATE).
*/
SELECT DepartmentName, PostDate,MonthName,amount
FROM Fact_Transaction t,DimDepartment d,DimClaim c,Dim_Date da
WHERE da.date=t.PostDate AND
c.ServiceDepartmentId=d.DepartmentId AND
t.ClaimId=c.ClaimId AND
TransactionType='PAYMENT'
/*
3.	The “financial class mix” of a facility represents the distribution of the services provided (represented as Total Charges) by Financial Class.
The mix is important context because it is more difficult collect payment from uninsured (SELF-PAY) patients 
than it is from insurance companies. Create a visual to show the financial class mix by Facility. 
*/
SELECT distinct DepartmentName, FinancialClass,SUM(amount) OVER(Partition by financialClass,DepartmentName) AS total
FROM DimDepartment d
INNER JOIN DimClaim c ON c.ServiceDepartmentId=d.DepartmentId
INNER JOIN Fact_Transaction t ON t.ClaimId=c.ClaimId
INNER JOIN DimPayer p ON p.PayerId=t.TransactionPayerId
WHERE TransactionType='CHARGE' 
GROUP BY FinancialClass, amount, departmentname

/*4.	Create a visual to identify the 10 payers (PAYERNAME) who have the lowest realization rates across all facilities.
*/

-- CTE with variables 
DECLARE @type varchar(50)
DECLARE @name varchar(50)

WITH transacDept AS(
SELECT distinct PayerName, DepartmentName,TransactionType, SUM(Amount) OVER(PARTITION BY DepartmentName,financialClass) AS sumCharges
FROM DimDepartment d
INNER JOIN DimClaim c ON c.ServiceDepartmentId=d.DepartmentId
INNER JOIN Fact_Transaction t ON t.ClaimId=c.ClaimId
INNER JOIN DimPayer p ON p.PayerId=t.TransactionPayerId
WHERE TransactionType=@type AND DepartMentName=@Name
)
Select TOP 10 PayerName, DepartmentName,TransactionType, sumCharges,
RANK() OVER(ORDER BY sumCharges DESC) AS sumCharge
FROM 
TransacDept

-- CTE -- eg with charge and Oprah Memorial --
WITH CHARGES AS(
SELECT distinct PayerName,DepartmentName,TransactionType, SUM(Amount) OVER(PARTITION BY DepartmentName,financialClass) AS sumCharges
FROM DimDepartment d
INNER JOIN DimClaim c ON c.ServiceDepartmentId=d.DepartmentId
INNER JOIN Fact_Transaction t ON t.ClaimId=c.ClaimId
INNER JOIN DimPayer p ON p.PayerId=t.TransactionPayerId
WHERE TransactionType='CHARGE'  AND DepartMentName='Oprah Memorial'
)
Select TOP 10 PayerName, DepartmentName,TransactionType, sumCharges,
RANK() OVER(ORDER BY sumCharges DESC) AS sumCharge
FROM 
CHARGES

-- for drop down --
select distinct Transactiontype from Fact_Transaction
WHERE TransactionType IN('CHARGE', 'PAYMENT')

-- for filter
select departmentName from DimDepartment