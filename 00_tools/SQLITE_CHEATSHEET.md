# SQLITE

Cheatsheet for Sqlite

## CSV Example

```sh
# trying to load csv
mkdir ./data

cat << EOF > ./data/ubuntu20.04.csv
"Name","Type"
"ubuntu:20.04","container"
EOF

sqlite3 ./data/csv.db
.mode ascii
.separator "," "\n"
.import ./data/ubuntu20.04.csv images
select * from images;
drop table images;
.quit
```

## Resources
