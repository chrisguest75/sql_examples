# SNOWFLAKE

Snowflake is a cloud-based data warehousing platform that allows organizations to store and analyze large volumes of data in a scalable and efficient manner. Snowflake provides a SQL-based interface for users to query and manipulate data stored in the platform.

```sh
# vscode extension
code --install-extension snowflake.snowflake-vsc

# snowsql cli tool
brew install --cask snowflake-snowsql
```

## SNOWSQL

```sh
# log in
snowsql -a account.region -u user -p password

!exit
```

### Exporting CSV

```sh
export SNOWSQL_USER=myname
export SNOWSQL_PWD=
export SNOWSQL_ACCOUNT=account.region
export SNOWSQL_ROLE=myrole
export SNOWSQL_DATABASE=mydb
export SNOWSQL_SCHEMA=myschema
export SNOWSQL_WAREHOUSE=mywarehouse

# freefrom query
snowsql -o log_level=DEBUG -o output_format=csv -o timing=false -o friendly=false -q "SELECT * FROM database.schema.table LIMIT 100"

# exporting csv data
snowsql -o log_level=DEBUG -o output_format=csv -o timing=false -o friendly=false -f ./queries/myquery.sql
```

## Resources

* Snowflake’s new VSCode plugin is here! [here](https://medium.com/snowflake/snowflakes-new-vscode-plugin-is-here-c1e4f3a55a01)  
* SnowSQL (CLI Client) [here](https://docs.snowflake.com/en/user-guide/snowsql)  
* Exporting Snowflake Query Results CSV [here](https://medium.com/akava/exporting-snowflake-query-results-abb013a2d29b)  
