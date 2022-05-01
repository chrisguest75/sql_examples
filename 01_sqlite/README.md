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
# generate data
./sbom_generate.sh
```

```sh
# trying to load csv
.mode ascii
.separator "," "\n"
.import ./sbom/ubuntu20.04.csv images
.import ./sbom/ubuntu20.04_components.csv components

select * from images;

drop table images;
```

## Load data (json)

```sh

INSERT INTO images SELECT json_extract(value, '$.name'), json_extract(value, '$.type') FROM json_each(readfile('./sbom/ubuntu20.04_images.json'));

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

