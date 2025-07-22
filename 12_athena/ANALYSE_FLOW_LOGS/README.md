# FLOW LOGS

```sql
CREATE EXTERNAL TABLE IF NOT EXISTS `vpc_flow_logs` (
  version int,
  account_id string,
  interface_id string,
  srcaddr string,
  dstaddr string,
  srcport int,
  dstport int,
  protocol bigint,
  packets bigint,
  bytes bigint,
  start bigint,
  `end` bigint,
  action string,
  log_status string,
  vpc_id string,
  subnet_id string,
  instance_id string,
  tcp_flags int,
  type string,
  pkt_srcaddr string,
  pkt_dstaddr string,
  region string,
  az_id string,
  sublocation_type string,
  sublocation_id string,
  pkt_src_aws_service string,
  pkt_dst_aws_service string,
  flow_direction string,
  traffic_path int
)
PARTITIONED BY (`date` date)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ' '
LOCATION 's3://DOC-EXAMPLE-BUCKET/prefix/AWSLogs/{account_id}/vpcflowlogs/{region_code}/'
TBLPROPERTIES ("skip.header.line.count"="1");
```

```sql
CREATE EXTERNAL TABLE `vpc_flow_logs`(
  `version` int COMMENT '',
  `account` string COMMENT '',
  `interfaceid` string COMMENT '',
  `sourceaddress` string COMMENT '',
  `destinationaddress` string COMMENT '',
  `sourceport` int COMMENT '',
  `destinationport` int COMMENT '',
  `protocol` int COMMENT '',
  `packets` int COMMENT '',
  `bytes` int COMMENT '',
  `starttime` int COMMENT '',
  `endtime` int COMMENT '',
  `action` string COMMENT '',
  `logstatus` string COMMENT '')
ROW FORMAT SERDE
  'org.apache.hadoop.hive.serde2.RegexSerDe'
WITH SERDEPROPERTIES (
  'input.regex'='^([^ ]+)\\s+([0-9]+)\\s+([^ ]+)\\s+([^ ]+)\\s+([^ ]+)\\s+([^ ]+)\\s+([^ ]+)\\s+([^ ]+)\\s+([^ ]+)\\s+([^ ]+)\\s+([0-9]+)\\s+([0-9]+)\\s+([^ ]+)\\s+([^ ]+)$')
STORED AS INPUTFORMAT
  'org.apache.hadoop.mapred.TextInputFormat'
OUTPUTFORMAT
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://firehose/'
TBLPROPERTIES (
  'transient_lastDdlTime'='1536236406')
```

## Resources

- https://docs.aws.amazon.com/athena/latest/ug/vpc-flow-logs.html
