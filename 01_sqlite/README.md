# README

Demonstrate a basic `sqlite` example

TODO:

* Generate a set of SBOM from list of docker images
* Import the data from the SBOM into SQLlite
* Create queries that allow me to search for particular components. 



## Example

```sh
brew info sqlite

brew install sqlite
```

```sh
sqlite3

.help
```

```sh
sqlite3 ./test.db
.read ./schema.sql
.tables

.dbinfo
```

```sh
./generate.sh

sqlite3 ./test.db

.import ./sbom/ubuntu20.04.csv images

select * from images;
```

## Resources

* https://sqlite.org/index.html
* SQLite Tutorial https://www.sqlitetutorial.net/

https://www.sqlitetutorial.net/sqlite-import-csv/
