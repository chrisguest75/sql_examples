# SNOWFLAKE

Cheatsheet for Snowflake

## Regex

```sql
-- extract a guid from a path
SELECT 
REGEXP_SUBSTR(uri, '(\/[0-9a-f]{8}\-[0-9a-f]{4}\-[0-9a-f]{4}\-[0-9a-f]{4}\-[0-9a-f]{12})(\/)(.*)', 1,1,'e', 1) as resource_guid,
uri  
FROM MY_TABLE LIMIT 1000;
```

## Counting

```sql
-- count rows per day
SELECT date, COUNT(*) as row_count
FROM MY_TABLE
GROUP BY date
ORDER BY date;
```

## Resources

* REGEXP_SUBSTR [here](https://docs.snowflake.com/en/sql-reference/functions/regexp_substr)  
