# SQLITE

Cheatsheet for Sqlite

## CSV Example

```sh
# trying to load csv
mkdir -p ./data

# create some example data
cat << EOF > ./data/ubuntu20.04.csv
"Name","Type"
"ubuntu:20.04","container"
"ubuntu:22.04","container"
EOF

# load the data into the db
sqlite3 ./data/csv.db
.mode ascii
.separator "," "\n"
.import ./data/ubuntu20.04.csv images
select * from images;
drop table images;
.quit
```

## JSON Example

```sh
# trying to load json
mkdir -p ./data

# create some example data
cat << EOF > ./data/ubuntuimages.json
[
  {
    "name": "ubuntu:20.04",
    "type": "container"
  },
  {
    "name": "ubuntu:22.04",
    "type": "container"
  }
]
EOF

sqlite3 ./data/json.db
# load the json
CREATE TABLE sboms (filename NVARCHAR(128) NOT NULL, filetext JSON);
.schema 
INSERT INTO sboms (filename, filetext) VALUES ('./data/ubuntuimages.json', readfile('./data/ubuntuimages.json')); 
select * from sboms;

# pull out row 0
select json_extract(filetext, '$[0].name') as name, json_extract(filetext, '$[0].type') as type from sboms;

# iterate over json array
select json_extract(value, '$.name') as name, json_extract(value, '$.type') as type from sboms s, json_each(json_extract(s.filetext, '$'));

drop table sboms;
.quit
```

## Resources

* JSON Functions And Operators [here](https://www.sqlite.org/json1.html)
* Compiling SQLite for use with Python Applications [here](https://charlesleifer.com/blog/compiling-sqlite-for-use-with-python-applications/)
* How do I iterate over an array in a nested json object in sqlite? [here](https://stackoverflow.com/questions/67814988/how-do-i-iterate-over-an-array-in-a-nested-json-object-in-sqlite)
* Common Format and MIME Type for Comma-Separated Values (CSV) Files [here](https://datatracker.ietf.org/doc/html/rfc4180
https://www.sqlitetutorial.net/sqlite-import-csv/)
