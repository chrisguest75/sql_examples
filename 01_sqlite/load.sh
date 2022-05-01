#!/usr/bin/env bash

rm ./test.db

echo "** Create DB **"
sqlite3 ./test.db ".read ./schema.sql"

echo "** Load DB **"
sqlite3 ./test.db "INSERT INTO images SELECT json_extract(value, '$.name'), json_extract(value, '$.type') FROM json_each(readfile('./sbom/ubuntu20.04_images.json'))" 
sqlite3 ./test.db "INSERT INTO components SELECT json_extract(value, '$.type'), json_extract(value, '$.name'), json_extract(value, '$.version') FROM json_each(readfile('./sbom/ubuntu20.04_components.json'))" 

echo "** Show DB **"
sqlite3 ./test.db -header -column "select * from images"
sqlite3 ./test.db -header -column "select * from components"