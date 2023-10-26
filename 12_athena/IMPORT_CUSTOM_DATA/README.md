# IMPORTING CUSTOM DATA

Importing data from custom sources.  

NOTES:

* It took a while to work out that `_id` needed escaping.  
* Always copy your data into a subkey as it will not accept single files in location.  

DEMONSTRATES:

* Export from mongo
* Copy to S3
* Add table in athena
* Aggregate

## Export

```sh
# try with limit to test connection
mongoexport -u "myuser" -p "mypassword" mongodb+srv://myserver/mydb --collection mycollection --readPreference=secondary --type=csv --fields "_id,field1,field2,field3,field4,field5" --query '{"_id":{"$ne":0}}' --out ./exports/mycollection.csv --limit 1
```

## Copy to S3

```sh
export AWS_PROFILE=myprofile
export AWS_REGION=us-east-1

aws --no-cli-pager s3 cp ./simple.csv s3://myimportbucket/import/simple/simple.csv
```

## Add to Athena

Types; DATE, BIGINT, INT, FLOAT.

```sql
CREATE EXTERNAL TABLE my_simple_data (
    `_id` string,
    field1 string,
    field2 string,
    field3 string,
    field4 string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
WITH SERDEPROPERTIES (
 'serialization.format' = ',',
 'field.delim' = ','
)
LOCATION 's3://myimportbucketimport/simple'
TBLPROPERTIES ( 'skip.header.line.count'='1' )
```

## Manipulate

```sh
SELECT * FROM my_simple_data;
```

## Resources
