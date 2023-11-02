# S3 IMPORT

Importing CSV data from an Athena export.  

REF: [12_athena/README.md](../../12_athena/README.md)  

## Prepare the data

```sh
export AWS_PROFILE=myprofile
export AWS_REGION=us-east-1
export ATHENA_S3_PATH='s3://myresultsbucket'

read -d '' sqlquery << EOF
SELECT * FROM MY_TABLE;
EOF
echo $sqlquery

# execute athena query
QUERY_ID=$(aws --no-cli-pager athena start-query-execution --query-string "$sqlquery" --result-configuration "OutputLocation=$ATHENA_S3_PATH" | jq -r '.QueryExecutionId')
echo $QUERY_ID

# check query status
aws --no-cli-pager athena get-query-execution --query-execution-id "$QUERY_ID"

# pull data data
aws --no-cli-pager s3 cp "$ATHENA_S3_PATH/$QUERY_ID.csv" ./csv

# test data
cat ./csv/${QUERY_ID}.csv | more

# copy up to snowflake bucket
aws --no-cli-pager s3 cp ./csv/${QUERY_ID}.csv s3://snowflakeimport/files/${QUERY_ID}.csv
```

## Import the data

Use the queries in [01_import.sql](./01_import.sql)  

## Resources

