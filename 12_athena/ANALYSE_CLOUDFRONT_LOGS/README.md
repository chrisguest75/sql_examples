# CLOUDFRONT LOG ANALYSIS

Create an external table for CloudFront logs.  

Here are the fields typically included in a CloudFront log entry:

* Date: The date on which the request was received, in the format YYYY-MM-DD.
* Time: The time when the request was received, in the format HH:MM:SS.
* EdgeLocation: The edge location that served the request. This is typically an abbreviated city code.
* BytesSent: The number of bytes that CloudFront sent to the user as a response to the request.
* IPAddress: The IP address of the viewer that made the request.
* Operation: The specific operation, such as a GET or POST request.
* DomainName: The domain name of the request.
* URI: The requested URI.
* Status: The HTTP status code returned by CloudFront.
* Referrer: The value of the HTTP referer header, if present. This indicates the URL of the webpage that referred the user to the requested object.
* UserAgent: The value of the HTTP User-Agent header, which typically contains information about the user's browser, operating system, and device.
* Querystring: The query string portion of the requested URI, if any.
* Cookie: The value of the HTTP cookie header, if any.
* ResultType: This indicates the type of result – a hit, miss, error, etc.
* RequestID: A unique identifier for the request.
* HostHeader: The value of the HTTP Host header. This is the domain name of the request.
* Protocol: The protocol used for the request, such as HTTP or HTTPS.
* BytesReceived: The number of bytes received from the viewer in the form of a request.
* TimeTaken: The amount of time taken to serve the request, usually in milliseconds.
* XForwardedFor: The IP address of the client as seen by CloudFront, in cases where the request goes through a proxy or load balancer.
* SSLProtocol: The SSL/TLS protocol used for the request, if applicable.
* SSLCipher: The SSL/TLS cipher used for the request, if applicable.
* EdgeResponseResultType: This indicates whether the response was served from the edge cache or if it was a miss.
* ContentType: The value of the HTTP Content-Type header, indicating the type of content served.

## Create Tables

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
