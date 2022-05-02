# README

Demonstrate a basic `sqlite` example

TODO:

* pragma https://www.sqlite.org/pragma.html
* 
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
.read ./schema.sql
.tables
.schema
```

## script example

```sh
./load.sh
```

### Exit

```sh
# exit sqlite
.quit
```

## Resources

* https://sqlite.org/index.html
* SQLite Tutorial https://www.sqlitetutorial.net/




https://zetcode.com/db/sqlite/tool/

https://www.sqlite.org/foreignkeys.html



https://stackoverflow.com/questions/9692319/how-can-i-insert-values-into-a-table-using-a-subquery-with-more-than-one-result

https://www.apimirror.com/sqlite/JSON




