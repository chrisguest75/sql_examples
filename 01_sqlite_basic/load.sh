#!/usr/bin/env bash

mkdir -p ./data
DBFILE=./data/basic.db
rm ${DBFILE}

echo "** Create DB **"
sqlite3 ${DBFILE} ".read ./schema.sql"

echo "** Load DB **"
sqlite3 ${DBFILE} "INSERT INTO person (PersonId, FirstName, LastName) VALUES(?, 'chris', 'guest');" 
sqlite3 ${DBFILE} "INSERT INTO person (PersonId, FirstName, LastName) VALUES(?, 'sam', 'smith');" 
sqlite3 ${DBFILE} "INSERT INTO person (PersonId, FirstName, LastName) VALUES(?, 'doctor', 'who');" 

echo "** Modified DB **"
sleep 1
sqlite3 ${DBFILE} "UPDATE person SET FirstName='peter', Modified=current_timestamp WHERE FirstName='sam' AND LastName='smith'" 

echo "** Show DB **"
sqlite3 ${DBFILE} -header -column "select * from person"


