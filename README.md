# msbi
Microsoft Business Intelligence Stack 

![Microsoft Business Intelligence Stack](https://csharpcorner-mindcrackerinc.netdna-ssl.com/UploadFile/a9d961/introduction-to-microsoft-business-intelligence-msbi/Images/model%20of%20a%20MSBI%20Project.jpg)

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
- Views(stored select statement are queried like tables and do not accept parameters
- Stored Procedures are predefined function executed as a batch 

## Data Warehousing
- separates analysis workload from transaction 
- Datawarehouse BI Architecture: Integration Service, Analysis Service amd Reporting Services


#### Business Intelligence:
- Implementing datawarehouse on any business to provide the analysis and decision making solution using some set of tools

#### Microsoft Business Intelligence (MSBI):
- Microsoft introduced SQL Server to implement data warehouse

##### Book: [The Language of SQL by Larry Rockoff](https://www.amazon.com/Language-SQL-Learning-Larry-Rockoff/dp/0134658256) 
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
- 
