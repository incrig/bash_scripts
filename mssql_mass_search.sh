# Script to run a mass select on multiple databases on single MSSQL server
#!/bin/bash

sqlbin="/usr/bin/sqlcmd" # location of mssql binary
serverName="localhost" # replace with the name of your SQL Server instance
username="myusername" # replace with your SQL Server username
password="mypassword" # replace with your SQL Server password
databasePattern="mydatabase%" # replace with the pattern for the database names you want to query
query="set nocount on; SELECT 1;" # replace with the query you want to run

export SQLCMDPASSWORD # Needed since -P is obsolete and pass cant be used inline

# Loop through each database on the server whose name matches the pattern
databases=$($sqlbin -S $serverName -U $username --headers="-1" -W -Q "set nocount on; SELECT name FROM sys.databases WHERE name LIKE '$databasePattern'")
echo "Existing databases:"
for database in ${databases[@]}; do echo $database; done
echo ""

for database in $databases ; do
    # Run the query and get the results
    results=$($sqlbin -S $serverName -U $username --headers="-1" -W -d $database -Q "$query")
    # Print the results
    echo "Results from $database:"
    echo "$results"
    echo ""
done
