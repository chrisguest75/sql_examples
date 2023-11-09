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
TBLPROPERTIES ('skip.header.line.count' = '1')
