# ALB LOGS ANALYSIS

Demonstrate a ALB Log Database with partitioning on date.  

NOTE:

* The partition key is a string not a date.
* Using `NOW` in the key ensures it will grow.  

## Create Tables

Create a date partitioned external table for ALB logs.  This uses the storage paths of the logs files to partition the data.  

```sql
CREATE EXTERNAL TABLE IF NOT EXISTS service_alb_logs (
            type string,
            time string,
            elb string,
            client_ip string,
            client_port int,
            target_ip string,
            target_port int,
            request_processing_time double,
            target_processing_time double,
            response_processing_time double,
            elb_status_code int,
            target_status_code string,
            received_bytes bigint,
            sent_bytes bigint,
            request_verb string,
            request_url string,
            request_proto string,
            user_agent string,
            ssl_cipher string,
            ssl_protocol string,
            target_group_arn string,
            trace_id string,
            domain_name string,
            chosen_cert_arn string,
            matched_rule_priority string,
            request_creation_time string,
            actions_executed string,
            redirect_url string,
            lambda_error_reason string,
            target_port_list string,
            target_status_code_list string,
            classification string,
            classification_reason string
            )
            PARTITIONED BY
            (
             day STRING
            )
            ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.RegexSerDe'
            WITH SERDEPROPERTIES (
            'serialization.format' = '1',
            'input.regex' = 
        '([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*):([0-9]*) ([^ ]*)[:-]([0-9]*) ([-.0-9]*) ([-.0-9]*) ([-.0-9]*) (|[-0-9]*) (-|[-0-9]*) ([-0-9]*) ([-0-9]*) \"([^ ]*) (.*) (- |[^ ]*)\" \"([^\"]*)\" ([A-Z0-9-_]+) ([A-Za-z0-9.-]*) ([^ ]*) \"([^\"]*)\" \"([^\"]*)\" \"([^\"]*)\" ([-.0-9]*) ([^ ]*) \"([^\"]*)\" \"([^\"]*)\" \"([^ ]*)\" \"([^\s]+?)\" \"([^\s]+)\" \"([^ ]*)\" \"([^ ]*)\"')
            LOCATION 's3://service-logs/elasticloadbalancing/us-east-1/'
            TBLPROPERTIES
            (
             "projection.enabled" = "true",
             "projection.day.type" = "date",
             "projection.day.range" = "2022/01/01,NOW",
             "projection.day.format" = "yyyy/MM/dd",
             "projection.day.interval" = "1",
             "projection.day.interval.unit" = "DAYS",
             "storage.location.template" = "s3://service-logs/elasticloadbalancing/us-east-1/${day}"
            )
```

## Resources

* Improve Amazon Athena query performance using AWS Glue Data Catalog partition indexes [here](https://aws.amazon.com/blogs/big-data/improve-amazon-athena-query-performance-using-aws-glue-data-catalog-partition-indexes/)
* AWS Glue partition indexing and filtering [here](https://docs.aws.amazon.com/athena/latest/ug/glue-best-practices.html#glue-best-practices-partition-index)
* How do I analyze my Amazon S3 server access logs using Athena? [here](https://repost.aws/knowledge-center/analyze-logs-athena)
* How do I analyze my Application Load Balancer access logs using Amazon Athena? [here](https://repost.aws/knowledge-center/athena-analyze-access-logs)
* Querying Application Load Balancer logs [here](https://docs.aws.amazon.com/athena/latest/ug/application-load-balancer-logs.html)  
* Fast Cloudfront log queries using AWS Athena and Serverless [here](https://medium.com/compass-true-north/fast-cloudfront-log-queries-using-aws-athena-and-serverless-ef117393c5a6)  