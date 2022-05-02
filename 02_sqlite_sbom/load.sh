#!/usr/bin/env bash

mkdir -p ./data
DBFILE=./data/sbom.db
rm ${DBFILE}

echo "** Create DB **"
sqlite3 ${DBFILE} ".read ./schema.sql"

echo "** Load SBOMs **"
for sbomfile in ./data/*.json; 
do
    echo "$sbomfile"
    sqlite3 ${DBFILE} "INSERT INTO sboms (filename, filetext) VALUES ('$sbomfile', readfile('$sbomfile'));" 
    #sqlite3 ${DBFILE} -header -column " \
    #select filename, length(filetext) from sboms where filename = '$sbomfile' \
    #"
done
sqlite3 ${DBFILE} -header -column "select filename, length(filetext) from sboms"


echo "** Load DB **"
sqlite3 ${DBFILE} " \
INSERT INTO images (ImageId, Name, Type) SELECT null, json_extract(filetext, '$.metadata.component.name') as name, json_extract(filetext, '$.metadata.component.type') as type from sboms; \
    " 
sqlite3 ${DBFILE} " \
INSERT INTO components (ComponentId, Name, Type, Version) SELECT null, json_extract(value, '$.name') as name, json_extract(value, '$.type') as type, json_extract(value, '$.version') as version from sboms s, json_each(json_extract(s.filetext, '$.components'));\
    " 

#echo "** ubuntu20.04 **"
#sqlite3 ${DBFILE} "INSERT INTO images SELECT rowid, json_extract(value, '$.name'), json_extract(value, '$.type') FROM json_each(readfile('./data/ubuntu20.04_images.json'))" 
#sqlite3 ${DBFILE} "INSERT INTO components SELECT rowid, json_extract(value, '$.type'), json_extract(value, '$.name'), json_extract(value, '$.version') FROM json_each(readfile('./data/ubuntu20.04_components.json'))" 
#echo "** ubuntu22.04 **"
#sqlite3 ${DBFILE} "INSERT INTO images SELECT rowid, json_extract(value, '$.name'), json_extract(value, '$.type') FROM json_each(readfile('./data/ubuntu22.04_images.json'))" 
#sqlite3 ${DBFILE} "INSERT INTO components SELECT rowid, json_extract(value, '$.type'), json_extract(value, '$.name'), json_extract(value, '$.version') FROM json_each(readfile('./data/ubuntu22.04_components.json'))" 

echo "** Test **"
#sqlite3 ${DBFILE} 'INSERT INTO images (ImageId, Name, Type) VALUES (?, "test", "test");'


echo "** Show DB **"
sqlite3 ${DBFILE} -header -column "select * from images;"
sqlite3 ${DBFILE} -header -column "select * from components;"



