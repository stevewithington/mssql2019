#!/bin/bash

# Start the script to create the DB and user
/usr/build/setup.sh &

# Start SQL Server
# NOTE: this must be the last (right-most) command
/opt/mssql/bin/sqlservr