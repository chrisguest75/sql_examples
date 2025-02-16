# POSTGRES

Create an example postgres based DB.  

TODO:

* Get pgadmin to already have a server connection https://www.pgadmin.org/docs/pgadmin4/latest/import_export_servers.html#importing-servers
* Mermaid diagrams for DB
* Generate events

## Start

```sh
just start

just shell postgres
just shell pgadmin
```

## pgAdmin

* Navigate to [http://0.0.0.0:5050](http://0.0.0.0:5050)
* Login PGADMIN_MAIL & PGADMIN_PW
* Add a connection to `postgres:5432`
* db: pools
* With username:dbuser

## Create DB

```sh
just nix

# connect from local
just pgcli
```

### Schema

```sh
just shell

# connect
psql -U dbuser -d pools

# list dbs
\l 

# pool
psql -U dbuser -d pools -f /scratch/schema/tbl_pool.sql

# status
psql -U dbuser -d pools -f /scratch/schema/tbl_status.sql

# tasks
psql -U dbuser -d pools -f /scratch/schema/tbl_tasks.sql

# load data
psql -U dbuser -d pools -f /scratch/schema/load_tbl_pool.sql
psql -U dbuser -d pools -f /scratch/schema/load_tbl_status.sql
```

## Perform Operations

```sh
just shell postgres "./compose.env" 

# install envsubst
apt update && apt install gettext-base

psql -U dbuser -d pools -f /scratch/schema/actions/show_pools.sql
psql -U dbuser -d pools -f /scratch/schema/actions/show_status.sql

# simulate launching tasks
export STATUS_ID=1
export POOL_ID=2
export CONTAINER_ID=$(head /dev/urandom | tr -dc a-f0-9 | head -c 40)
psql -U dbuser -d pools -c "$(envsubst </scratch/schema/actions/launch_task.template.sql)"

psql -U dbuser -d pools -f /scratch/schema/actions/show_tasks.sql

# launched to ready
psql -U dbuser -d pools -c "$(envsubst </scratch/schema/actions/task_ready.template.sql)"



# assign a work load
export POOL_ID=1
export WORK_ID="work_$(head /dev/urandom | tr -dc a-f0-9 | head -c 20)"
psql -U dbuser -d pools -c "$(envsubst </scratch/schema/actions/assign_workload.template.sql)"

psql -U dbuser -d pools -f /scratch/schema/actions/show_tasks.sql

# capacity by pool
psql -U dbuser -d pools -f /scratch/schema/actions/capacity_by_pool.sql


# expire tasks
psql -U dbuser -d pools -c "$(envsubst </scratch/schema/actions/workload_expired.template.sql)"
```

## Stop

```sh
just stop
```

## Resources

* Postgres Docs [here](https://www.postgresql.org/docs/)
* How to Use the Postgres Docker Official Image [here](https://www.docker.com/blog/how-to-use-the-postgres-docker-official-image/)
* pgAdmin is the most popular and feature rich Open Source administration and development platform for PostgreSQL, the most advanced Open Source database in the world. [here](https://www.pgadmin.org/)
* awesome-compose/postgresql-pgadmin repo [here](https://github.com/docker/awesome-compose/tree/master/postgresql-pgadmin)
* https://tomcam.github.io/postgres/
* https://www.geeksforgeeks.org/how-to-persist-data-in-a-dockerized-postgres-database-using-volumes/
* https://www.pgadmin.org/docs/
* https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Welcome.html
* https://www.pgcli.com/
