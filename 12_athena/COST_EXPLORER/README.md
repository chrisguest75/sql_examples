# BILLING

TODO:

- What is pro-forma in cost and usage reports?
- Create a report - set it up for athena.

## Queries

```sql
SELECT * FROM my_cur_report WHERE bill_billingperiodenddate >= '2022-07-01T00:00:00Z' AND bill_billingperiodenddate < '2022-08-01T00:00:00Z' LIMIT 100;

SELECT lineitem_operation, count(*)  FROM my_cur_report WHERE bill_billingperiodenddate >= '2022-07-01T00:00:00Z' AND bill_billingperiodenddate < '2022-08-01T00:00:00Z' GROUP BY lineitem_operation;

SELECT lineitem_resourceid, count(*)  FROM my_cur_report WHERE bill_billingperiodenddate >= '2023-10-01T00:00:00Z' AND bill_billingperiodenddate < '2023-11-01T00:00:00Z' GROUP BY lineitem_resourceid;

SELECT lineitem_resourceid, product_processorarchitecture, count(*)  FROM my_cur_report WHERE bill_billingperiodenddate >= '2023-10-01T00:00:00Z' AND bill_billingperiodenddate < '2023-11-01T00:00:00Z' GROUP BY lineitem_resourceid, product_processorarchitecture;
```

## Resources

- CUR - cost and usage reports https://docs.aws.amazon.com/cur/latest/userguide/cur-query-athena.html
- Cost and Usage Report - Running Amazon Athena queries
  https://docs.aws.amazon.com/cur/latest/userguide/cur-ate-run.html
- https://docs.aws.amazon.com/account-billing/
