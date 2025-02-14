# POSTGRES

Create an example postgres based DB.  

TODO:

* Pass in data to sql script
* Get pgadmin to already have a server connection
* Automate creation of postgres db
* Store database in shared folder/volume.
* Mermaid diagrams for DB
* Generate events
* Test locking and isolation behaviour

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

psql -U dbuser -d pools -f /scratch/schema/actions/show_pools.sql
psql -U dbuser -d pools -f /scratch/schema/actions/show_status.sql

# simulate launching tasks
export STATUS_ID=2
export POOL_ID=2
export CONTAINER_ID=$(head /dev/urandom | tr -dc a-f0-9 | head -c 40)
psql -U dbuser -d pools -c "INSERT INTO public.tasks(\"pool_id\",\"container_id\",\"status_id\") VALUES (${POOL_ID}, '${CONTAINER_ID}', ${STATUS_ID});"



psql -U dbuser -d pools -f /scratch/schema/actions/show_tasks.sql

psql -U dbuser -d pools -f /scratch/schema/actions/capacity_by_pool.sql
```

## Stop

```sh
just stop
```

## Resources

* How to Use the Postgres Docker Official Image [here](https://www.docker.com/blog/how-to-use-the-postgres-docker-official-image/)
* pgAdmin is the most popular and feature rich Open Source administration and development platform for PostgreSQL, the most advanced Open Source database in the world. [here](https://www.pgadmin.org/)
* awesome-compose/postgresql-pgadmin repo [here](https://github.com/docker/awesome-compose/tree/master/postgresql-pgadmin)
* https://tomcam.github.io/postgres/