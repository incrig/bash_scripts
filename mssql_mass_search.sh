#!/bin/bash

serverName="localhost" # replace with the name of your SQL Server instance
username="myusername" # replace with your SQL Server username
password="mypassword" # replace with your SQL Server password
databasePattern="mydatabase%" # replace with the pattern for the database names you want to query
query="SELECT * FROM mytable" # replace with the query you want to run

# Loop through each database on the server whose name matches the pattern
for database in $(/opt/mssql-tools/bin/sqlcmd -S $serverName -U $username -P $password -h -1 -W -Q "SELECT name FROM sys.databases WHERE name LIKE '$databasePattern'") ; do
    # Run the query and get the results
    results=$(/opt/mssql-tools/bin/sqlcmd -S $serverName -U $username -P $password -h -1 -W -d $database -Q "$query")

    # Print the results
    echo "Results from $database:"
    echo "$results"
done
