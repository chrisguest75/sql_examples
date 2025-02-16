# POSTGRES

Create an example postgres based DB.  

TODO:

* Get pgadmin to already have a server connection https://www.pgadmin.org/docs/pgadmin4/latest/import_export_servers.html#importing-servers
* Generate events

## Start

```sh
just start

# load db
just db-create-schema
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

### Connect

```sh
just shell postgres "./compose.env" 
just shell pgadmin

# install envsubst
apt update && apt install gettext-base

# connect
psql -U dbuser -d pools

# list dbs
\l 
```

## Perform Operations

```sh
# show tables
just db-show pools
just db-show status
just db-show tasks

# simulate launching tasks
just db-launch 1

# launched to ready
just db-ready 1

# assign a work load
just db-assign 1

# capacity by pool
just db-capacity

# expire tasks
just db-complete 1
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
