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
.schema

.dbinfo
```

## Load data (csv)

```sh
./generate.sh

sqlite3 ./test.db
```

```sh
# trying to load csv
.mode ascii
.separator "," "\n"
.import ./sbom/ubuntu20.04.csv images
.import ./sbom/ubuntu20.04_components.csv components
.import ./sbom/ubuntu22.04.csv images

select * from images;

drop table images;
```

## Load data (json)

```sh

INSERT INTO images SELECT json_extract(value, '$.name'), json_extract(value, '$.type') FROM json_each(readfile('./sbom/ubuntu20.04_images.json'));

```



```sh
# exit sqlite
.quit
```

## Resources

* https://sqlite.org/index.html
* SQLite Tutorial https://www.sqlitetutorial.net/

https://www.sqlitetutorial.net/sqlite-import-csv/

Common Format and MIME Type for Comma-Separated Values (CSV) Files https://datatracker.ietf.org/doc/html/rfc4180

https://stackoverflow.com/questions/46407770/how-to-convert-a-json-file-to-an-sqlite-database

https://zetcode.com/db/sqlite/tool/

https://www.sqlite.org/foreignkeys.html

