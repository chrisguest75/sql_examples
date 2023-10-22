# ATHENA

Amazon Athena is an interactive query service offered by Amazon Web Services (AWS). It allows you to analyze and query data stored in Amazon S3 (Simple Storage Service) using SQL (Structured Query Language) without the need for setting up and managing complex data warehouses or databases. Athena is part of AWS's serverless analytics offerings, which means you don't need to provision or manage any infrastructure; you only pay for the queries you run.  

Here are some key features and components of Amazon Athena:

* Serverless and Managed: Athena is a serverless service, which means AWS manages the underlying infrastructure, such as clusters or servers. You don't need to worry about provisioning, scaling, or maintaining these resources.  

* Querying Data in S3: Athena is specifically designed for querying data stored in Amazon S3, making it a powerful tool for organizations that store large amounts of data in S3 buckets.  

* SQL-Based Queries: You can use standard SQL queries to analyze your data in S3. This makes it accessible to users who are already familiar with SQL.  

* Schema-on-Read: Athena uses a schema-on-read approach, which means you can run queries on your data without having to define a rigid schema upfront. Athena infers the schema from your data's structure, such as in CSV, JSON, Parquet, or other supported formats.  

* Integration with AWS Glue: You can use AWS Glue, a fully managed extract, transform, and load (ETL) service, to create and manage the metadata for your data stored in S3. This metadata can be used to improve query performance in Athena.  

* Data Catalog: Athena can use the AWS Glue Data Catalog or an external Hive metastore as a data catalog, allowing you to maintain a centralized metadata store for your data.  

* Query Performance: Athena uses a distributed and parallelized query execution engine to provide fast query performance, even for large datasets.  

* Result Sets and Output: Query results can be saved to S3, downloaded, or integrated with other AWS services for further analysis or visualization.  

* Integration with BI Tools: You can connect popular business intelligence (BI) tools like Tableau, Amazon QuickSight, or others to Athena for data visualization and reporting.  

Amazon Athena is a valuable tool for data analysts, data engineers, and anyone who needs to perform ad-hoc SQL queries on data stored in Amazon S3, without the complexity of managing a traditional database or data warehouse. It's particularly well-suited for organizations that prefer a pay-as-you-go pricing model and want to leverage their existing data in S3 for analytics and insights.  

## Cheatsheet

TODO:

* discover the s3 output bucket location from the cli

### Creating tables from outputs

```sql
-- slice some data into a new table.
CREATE TABLE service_alb_logs_2022_10_02
    WITH (format = 'PARQUET')
    AS SELECT * FROM service_alb_logs WHERE day = '2022/10/02';

SELECT DISTINCT client_ip FROM service_alb_logs_2022_10_02 
```

## Resources

* Using AWS Athena from AWS CLI and bash. [here](https://frankcontrepois.com/post/20210211-tech-athenafrombash/)
* How to emulate temporary tables in Athena [here](https://mikulskibartosz.name/temporary-tables-in-athena)