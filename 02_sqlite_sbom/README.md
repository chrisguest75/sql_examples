# README

Demonstrate building an SBOM db in sqlite  

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

* Common Format and MIME Type for Comma-Separated Values (CSV) Files [here](https://datatracker.ietf.org/doc/html/rfc4180
https://www.sqlitetutorial.net/sqlite-import-csv/)
* SQL INSERT [here](https://www.sqlite.org/lang_insert.html)
