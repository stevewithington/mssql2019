/*
** Example Restore
** <https://docs.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver15&tabs=ssms>
** <https://github.com/microsoft/sql-server-samples/tree/master/samples/databases>
*/

SET NOCOUNT ON
GO

USE master
GO

PRINT 'Executing `restore.sql` ...'

/*
  AdventureWorks2019
*/
IF DB_ID('AdventureWorks2019') IS NOT NULL
  PRINT 'AdventureWorks2019 exists'
ELSE
  BEGIN 
    PRINT 'Restoring AdventureWorks2019 ...'

    RESTORE DATABASE AdventureWorks2019
    FROM DISK = N'/var/opt/mssql/backup/AdventureWorks2019.bak'
    --FROM URL = 'https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorks2019.bak'
    WITH 
      MOVE N'AdventureWorks2019'
        TO N'/var/opt/mssql/data/AdventureWorks2019.mdf',
      MOVE N'AdventureWorks2019_log'
        TO N'/var/opt/mssql/data/AdventureWorks2019_log.mdf',
      FILE = 1,
      NOUNLOAD,
      STATS = 5
      ;
    
    PRINT 'AdventureWorks2019 restored!'
  END
GO

PRINT '`restore.sql` fin.'