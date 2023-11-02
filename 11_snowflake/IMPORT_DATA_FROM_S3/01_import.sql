
-- List the files in the stage
LIST @database_name.schema_name.stage_name;


CREATE TABLE database_name.schema_name.table_name (
  field1 STRING,
  field2 STRING
);

COPY INTO database_name.schema_name.table_name (
  field1,
  field2
)
FROM '@stage_name/files/filename.csv'
FILE_FORMAT = (
  TYPE = CSV
  SKIP_HEADER = 1
  FIELD_OPTIONALLY_ENCLOSED_BY = '"'
)
ON_ERROR = CONTINUE; 

SELECT * FROM database_name.schema_name.table_name LIMIT 10;

SELECT COUNT(1) FROM database_name.schema_name.table_name;




