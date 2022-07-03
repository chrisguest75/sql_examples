# README

Demonstrate a basic `sqlite` example

TODO:

* pragma https://www.sqlite.org/pragma.html

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

## Person example

```sh
sqlite3 ./person.db
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

* The sqlite3 command line tool [here](https://zetcode.com/db/sqlite/tool/)
* SQLite Foreign Key Support [here](https://www.sqlite.org/foreignkeys.html)
* How can I insert values into a table, using a subquery with more than one result? [here](https://stackoverflow.com/questions/9692319/how-can-i-insert-values-into-a-table-using-a-subquery-with-more-than-one-result)
* JSON Functions And Operators [here](https://www.sqlite.org/json1.html)
