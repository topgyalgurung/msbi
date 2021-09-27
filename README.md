# MSBI
Microsoft Business Intelligence Stack 

![Microsoft Business Intelligence Stack](https://csharpcorner-mindcrackerinc.netdna-ssl.com/UploadFile/a9d961/introduction-to-microsoft-business-intelligence-msbi/Images/model%20of%20a%20MSBI%20Project.jpg)

#### Business Intelligence:
- Implementing datawarehouse on any business to provide the analysis and decision making solution using some set of tools

#### Microsoft Business Intelligence (MSBI):
- Microsoft introduced SQL Server to implement data warehouse

##### Book: [The Language of SQL by Larry Rockoff](https://www.amazon.com/Language-SQL-Learning-Larry-Rockoff/dp/0134658256) 

## Topics
- Data Modeling (Relational and tools)
- SQL, SQL Server and T-SQL 
- SQL Server Management Studio (SSMS) & management
- Data Warehouse
- SSIS, SSRS, SSAS
- Power BI 

# Terminology
- Online Transactional Processing (OLTP) - handles real time data, normalized
- Online Analytical Processing (OLAP) - analyze metrics in diff dimensions like time, geography, product (aggregations), denormalized 
- Views(stored select statement in database are queried like tables and do not accept parameters
- Stored Procedures are predefined function executed as a batch, multiple statements saved into single object and to use parameters in conjunction with SQL statements  
- Common Table Expressions(CTE) simplifies complex queries and enable recursion
    - with UNION ALL can make CTE recursive to formulate a final result 
- UPSERT - fusion of UPDATE and INSERT 
- data log process: allows DBAs to recover databases in the event of system crashes
- Trigger is special type of stored procedure automatically runs when an event occurs in database server 
- Indexing: Clustered vs non-clustered index
- Ad hoc reporting: model of BI, reports are created and shared on the fly
- KPIs: to measure if the goals are accomplished, contains a value to be measured, a goal or a trend

## Data Warehousing
- separates analysis workload from transaction 
- Datawarehouse BI Architecture: Integration Service, Analysis Service amd Reporting Services
- Facts are constructed with foreign keys; contain measures ( e.g quantity, price)
    - Centralized table is facts and surronding table is dimensins.
    1. Star Schema: denormalized less join gives best query performance, quick data retrieval but requires huge storage
    2. SnowFlake Schema: more joins normalized requires less storage but performance is low
- [Kimball Methodology](https://www.kimballgroup.com/data-warehouse-business-intelligence-resources/kimball-techniques/dw-bi-lifecycle-method/)- most popular methodoloy

#### Data Marts: 
- subset of a datawarehouse oriented to a specific business line which contains summarized data collected for analysis on specific section within organization. e.g sales department

### Dimension Loading:
- full loading (load data from OLTP to Stagin)
- incremental loading (between staging and data warehouse) 
- slowly changing dimensions(type 1(no history), type 2(full history), type 3(latest update to changed history)
- date dimension

##### ETL:
- E xtract files from Sources: databases, csv, xml, flat file 
- T ransform, calculate, aggregate, data conversion, pivot, merge, joins
- L oad into database(destination),csv
###### General Steps for ETL Process
    1. Define Structure of source data
    2. Define structure of destination data
    3. map elements of source data to destination
    4. define transformation
    5. schedule execution
    6. then logs generated

#### Program flow of Project
- Control Flow + Data Flow(ETL) 

|T-SQL |MySQL |Oracle
|------|------|------|
|(+) for concatenation|CONCAT()| \|\| 
|GETDATE |NOW | CURRENT_DATE 
|DATEPART |DATE_FORMAT | no function 
| DATEDIFF(datepart,start,end) |DATEDIFF(end,start) | no such function
| ISNULL()  | IFNULL() | NULL
|TOP | LIMIT | ROWNUM 
|PI() |PI() |no such function

#### SSIS:
- data transformation solutions (transform data from one place to another )
- for data migration tasks 
- platform for data integration and workflow applications 

-----

#### Three main environment, Software Development Life Cycle (SDLC)
1. Development (dev): environment on your computer connected to local or dummy database
2. Stage (qa): code on a server, database migration will be tested and configuration changes
3. Production: final code of all updates and testing

#### Cloud Products:
- Amazon Redshift vs Azure SQL Data warehouse vs Google BigQuery




