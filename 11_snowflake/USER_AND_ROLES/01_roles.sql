-- WALKTHROUGH
SELECT CURRENT_USER(), CURRENT_ROLE(), CURRENT_ACCOUNT(), CURRENT_WAREHOUSE(), CURRENT_DATABASE(), CURRENT_SCHEMA(), CURRENT_SESSION();

-- https://docs.snowflake.com/en/sql-reference/sql/show-users
SHOW USERS; 

SHOW SCHEMAS;

SHOW ROLES;

-- Show my grants
-- https://docs.snowflake.com/en/sql-reference/sql/show-grants.html
SHOW GRANTS; 

-- Show grants for a specific user
SHOW GRANTS ON USER username;

-- Show grants on a stage
SHOW GRANTS ON STAGE databasename.schema.stage_name;


SHOW GRANTS ON SCHEMA databasename.schema;


DESCRIBE USER username;

GRANT USAGE ON STAGE databasename.schema.stage_name TO role_name;

