#!/usr/bin/env bash

mkdir -p ./data
DBFILE=./data/basic.db
rm ${DBFILE}

echo "** Create DB **"
sqlite3 ${DBFILE} ".read ./schema.sql"

echo "** Load DB **"
sqlite3 ${DBFILE} "INSERT INTO person (PersonId, FirstName, LastName) VALUES(?, 'chris', 'guest');" 
sqlite3 ${DBFILE} "INSERT INTO person (PersonId, FirstName, LastName) VALUES(?, 'sam', 'smith');" 

echo "** Show DB **"
sqlite3 ${DBFILE} -header -column "select * from person"


