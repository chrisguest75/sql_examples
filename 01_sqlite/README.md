# README

Demonstrate a basic `sqlite` example

TODO:

* Generate a set of SBOM from list of docker images
* Import the data from the SBOM into SQLlite
* Create queries that allow me to search for particular components. 

## Prerequisites

```sh
brew info sqlite

brew install sqlite

sqlite3 --version

# install path and show brew sqlite compile options
brew --cellar sqlite  
cat $(brew --cellar sqlite)/3.38.3/.brew/sqlite.rb
```

## Cli Tool

```sh
sqlite3

.help
```

## SBOM example

```sh
sqlite3 ./sbom.db
.dbinfo
.read ./sbom_schema.sql
.tables
.schema
```

### Load data (csv)

```sh
# generate sbom data
./sbom_generate.sh

# load data into db
./sbom_load.sh
```

### Exit

```sh
# exit sqlite
.quit
```

## Resources

* https://sqlite.org/index.html
* SQLite Tutorial https://www.sqlitetutorial.net/
* Common Format and MIME Type for Comma-Separated Values (CSV) Files [here](https://datatracker.ietf.org/doc/html/rfc4180
https://www.sqlitetutorial.net/sqlite-import-csv/)



https://stackoverflow.com/questions/46407770/how-to-convert-a-json-file-to-an-sqlite-database

https://zetcode.com/db/sqlite/tool/

https://www.sqlite.org/foreignkeys.html



https://stackoverflow.com/questions/9692319/how-can-i-insert-values-into-a-table-using-a-subquery-with-more-than-one-result

https://www.apimirror.com/sqlite/JSON




