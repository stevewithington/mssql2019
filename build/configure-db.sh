#!/bin/bash

HR="===================================================================================================="

echo "$HR
Setting up MSSQL ...
$HR"

# Give SQL Server a few seconds to warm up
sleep 15;

# -------------------------------------------------------------------------------------------------------
#	Initialize MSSQL
#
# Wait 60 seconds for MSSQL to start up to avoid calls to `sqlcmd` throwing errors.
# We're checking `system` and `user` databases `STATE` field.
# When `state` returns `0` it means they're `online`
#
#			0 = ONLINE
#			1 = RESTORING
#			2 = RECOVERING
#			3 = RECOVERY_PENDING
#			4 = SUSPECT
#			5 = EMERGENCY
#			6 = OFFLINE
#			7 = COPYING
#			10 = OFFLINE_SECONDARY
#
# https://docs.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-databases-transact-sql?view=sql-server-2017
# https://docs.microsoft.com/en-us/sql/tools/sqlcmd-utility?view=sql-server-ver15
# -------------------------------------------------------------------------------------------------------

echo "$HR
Initializing configuration scripts ...
$HR"

SCMD="/opt/mssql-tools/bin/sqlcmd -U sa -P $SA_PASSWORD"

function init() {
	local dbstate=1
	local statesum=1
	local i=0

	while [[ $i -lt 60 && $statesum -ne 0 ]]; do
		sleep 1
		i=$i+1
		dbstate=$($SCMD -h -1 -t 1 -Q "SET NOCOUNT ON; SELECT SUM(state) FROM sys.databases")
		statesum=$?
	done

	echo "$statesum"
}

STATESUM="$(init)"

if [ $STATESUM -ne 0 ]; then 
	echo "$HR
	STATESUM: $STATESUM
	MSSQL is not completely online yet. Aborting remaining configuration load scripts. Check logs!"
	exit 1
fi

# -------------------------------------------------------------------------------------------------------
#	Script Examples
# -------------------------------------------------------------------------------------------------------

echo "$HR
Loading build scripts ...
$HR"

# Example of restoring a DB from a backup file
RESTORE=$($SCMD -S 127.0.0.1 -i /usr/build/restore.sql)

# Example of a custom script
#SETUP=$($SCMD -S 127.0.0.1 -i /usr/build/demo.sql);

echo "$HR
MSSQL is ready!"
