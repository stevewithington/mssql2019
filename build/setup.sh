#!/bin/bash

HR="===================================================================================================="

echo "$HR
Running setup.sh ...
$HR"

# run the demo script to create the DB and the schema in the DB
# do this in a loop because the timing for when the SQL instance is ready is indeterminate
for i in {1..60};
do
    /opt/mssql-tools/bin/sqlcmd -S 127.0.0.1 -U sa -P $SA_PASSWORD -d master -i demo.sql
    if [ $? -eq 0 ]
    then
        echo "demo.sql completed"
        break
    else
        echo "not ready yet..."
        sleep 1
    fi
done

# import the CSV file
/opt/mssql-tools/bin/bcp DemoData.dbo.Products in "/usr/build/Products.csv" -c -t',' -S 127.0.0.1 -U sa -P $SA_PASSWORD

# Example of restoring a DB from a backup file
# Must have a backup file in the `backup` directory and modify the `restore.sql` file accordingly
#RESTORE=$($SCMD -S 127.0.0.1 -i /usr/build/restore.sql)

echo "$HR
setup.sh finished running
$HR"