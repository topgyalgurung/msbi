
sp_help employee
sp_helpindex employee

-- to get list of all tables with column names with data type name
SELECT T.Name                   AS TableName,
       Schema_name(T.schema_id) AS SchemaName,
       C.Name                   AS ColumnName,
       Ty.Name                  AS ColumnDataType,
       C.is_nullable            AS IsNullAble,
       C.is_identity            AS IsIdentity 
FROM   sys.tables T
       INNER JOIN sys.columns C
               ON T.OBJECT_ID = C
			   
--below query can be used to get all blocked processes with blocking SPIDs using SYSprocesses
SELECT spid,
       blocked                   AS BlockingSPID,
       (SELECT CRI.TEXT
        FROM   sysprocesses st
               CROSS apply sys.Dm_exec_sql_text(sql_handle) CRI
        WHERE  spid = s.blocked) AS BlockingQuery,
       PROGRAM_NAME,
       nt_userName,
       loginame,
       DB_NAME(s.dbid)           AS DatabaseName,
       CR.TEXT                   AS Query
FROM   sysprocesses s
       CROSS apply sys.Dm_exec_sql_text(sql_handle) CR
WHERE  blocked <> 0
       INNER JOIN sys.types Ty
               ON C.system_type_id = Ty.system_type_id 
WHERE  T.is_ms_shipped = 0 
ORDER  BY T.name

--Get Row Count Of All The Tables In SQL Server Database
SELECT OBJECT_NAME(id) AS TableName,
       rowcnt          AS [RowCount]
FROM   sysindexes s
       INNER JOIN sys.tables t
               ON s.id = t.OBJECT_ID
WHERE  s.indid IN ( 0, 1, 255 )
       AND is_ms_shipped = 0

--get Table Names with Record Count in SQL Server Database
SELECT DISTINCT t.name AS TableName,
                i.rows AS RecordCnt 
FROM   sysindexes i
       INNER JOIN sys.tables t
               ON i.id = t.OBJECT_ID 
WHERE  t.is_ms_shipped = 0  
ORDER BY t.name
