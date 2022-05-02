#!/usr/bin/env bash

DBFILE=./testresults.db
rm ${DBFILE}

echo "** Create DB **"
sqlite3 ${DBFILE} ".read ./testresults_schema.sql"

echo "** Load DB **"
sqlite3 ${DBFILE} "INSERT INTO run (RunId, Name) VALUES(?, 'name1');" 
sqlite3 ${DBFILE} "INSERT INTO run (RunId, Name) VALUES(?, 'name2');" 
sqlite3 ${DBFILE} "INSERT INTO run (RunId, Name) VALUES(?, 'name3');" 
sqlite3 ${DBFILE} "INSERT INTO run (RunId, Name) VALUES(?, 'name4');" 

echo "** Show DB **"
sqlite3 ${DBFILE} -header -column "select * from run"


