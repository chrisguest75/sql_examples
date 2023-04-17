# AIVEN POSTGRES

Demonstrate using Aiven to create a free hosted DB.  

TODO:

* CreateDB (terraform, cli?)
* Create schema
* Load schema
* Should I write this in prisma?  

NOTES:

* psycopg2-binary - https://www.psycopg.org/docs/install.html

## Tooling

```sh
brew install aiven-client

avn --help

brew info dbeaver-community 
```

## Create Schema

Use `schema.sql`  

## Load Schema

```sh
pipenv run python ./createdb.py
```

## Drop

Use `drop.sql`  

## Start

```sh
# install
pyenv install

pipenv run lint
pipenv run test

pipenv shell

pipenv run start:default --test
```

## Created

```sh
# install
pipenv install --dev flake8 flake8-bugbear flake8-2020 black
pipenv install --dev pytest 

pipenv install pyyaml python-json-logger
```


## Resource

* https://docs.aiven.io/docs/tools/cli
* https://docs.aiven.io/docs/products/postgresql/howto/migrate-aiven-db-migrate
* https://docs.aiven.io/docs/products/postgresql/reference/list-of-extensions