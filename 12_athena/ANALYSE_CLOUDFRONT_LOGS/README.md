# CLOUDFRONT LOG ANALYSIS

## Create Tables

Create a partitioned external table for CloudFront logs.  

```sql
CREATE EXTERNAL TABLE IF NOT EXISTS cloudfront_access_logs (
  `date` DATE,
  time STRING,
  location STRING,
  bytes BIGINT,
  request_ip STRING,
  method STRING,
  host STRING,
  uri STRING,
  status INT,
  referrer STRING,
  user_agent STRING,
  query_string STRING,
  cookie STRING,
  result_type STRING,
  request_id STRING,
  host_header STRING,
  request_protocol STRING,
  request_bytes BIGINT,
  time_taken FLOAT,
  xforwarded_for STRING,
  ssl_protocol STRING,
  ssl_cipher STRING,
  response_result_type STRING,
  http_version STRING,
  fle_status STRING,
  fle_encrypted_fields INT,
  c_port INT,
  time_to_first_byte FLOAT,
  x_edge_detailed_result_type STRING,
  sc_content_type STRING,
  sc_content_len BIGINT,
  sc_range_start BIGINT,
  sc_range_end BIGINT
)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY '\t'
LOCATION 's3://service-logs/myservice.com/'
TBLPROPERTIES ( 'skip.header.line.count'='2' )
```

## Extract data

```sql
-- Get a months worth of data and extract a path from the uri
SELECT REGEXP_EXTRACT(uri, '(.*)([0-9a-f]{24})(\/)(.*)', 2) as routeid, *
FROM cloudfront_access_logs WHERE date BETWEEN cast('2022-10-01' as date) AND cast('2022-11-01' as date)
```

## Resources

* Querying Amazon CloudFront logs [here](https://docs.aws.amazon.com/athena/latest/ug/cloudfront-logs.html)
* How do I analyze my Amazon S3 server access logs using Athena? [here](https://repost.aws/knowledge-center/analyze-logs-athena)
