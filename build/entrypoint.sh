#!/bin/bash

# Start the script to create the DB and user
#/usr/build/configure-db.sh &
/usr/build/import.sh &

# Start SQL Server
# NOTE: this must be the last (right-most) command
/opt/mssql/bin/sqlservr