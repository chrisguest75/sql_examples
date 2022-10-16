# README

Demonstrate how to pull `vscode` sqlite DB to query and modify it.  

`vscode` has he ability to disable extensions by workspace.  For my work repos I'd like to be able to disable `GitHub.copilot` across all those workspace automatically.  

NOTES:

* Although sqlite supports JSON type it doesn't seem to offer functions to work with it easily.  
* SQLite does not support DECLARE to create variables.  

TODO:  

* disable extensions per workspace only

## Show extensions

```sh
code --show-versions --list-extensions

# extensions folders 
ls ~/.vscode/extensions

# GitHub.copilot
```

## Disable extension

```bash
# react_examples (end with '$' means we only want parent directory)
export PROJECT=react_examples$
# get workspace directory
export DBPATH=$(dirname "$(find $HOME/Library/Application\ Support/Code/User/workspaceStorage -iname "workspace.json" -exec jq --arg filename {} -c '. | {"folder": .folder, "filename": $filename}' {} \; | jq -s '.' | jq --arg project "${PROJECT}" '.[] | select(.folder != null) | select(.folder | test(".*\( $project )"))' | jq -s -r '.[].filename' | tail -n 1)")

export DBFILE="${DBPATH}/state.vscdb"
echo "${DBPATH}"
echo "${DBFILE}"
# create the extensionsIdentifiers/disabled value that will disable copilot.  
# we filter out existing disabled copilot and re-add it to list.  Mix of sql and jq to add to modify json document.  
sqlite3 "${DBFILE}" 'SELECT IFNULL(b.value, "[]") FROM (SELECT "extensionsIdentifiers/disabled" as keyname) as A LEFT OUTER JOIN ItemTable as B ON a.keyname=b.key;' | jq --arg id "github.copilot" --arg guid "23c4aeee-f844-43cd-b53e-1113e483f1a6" '[.[] | del(select(.id==$id)) | select(. != null)] | . += [{"id": $id, "uuid": $guid}]' > ./disabled.json
cat ./disabled.json
# replace existing disabled extenstions json doc
sqlite3 "${DBFILE}" 'REPLACE INTO ItemTable (key, value)
VALUES("extensionsIdentifiers/disabled", readfile("./disabled.json"));'
# show new list of disabled extensions
sqlite3 "${DBFILE}" 'SELECT value FROM ItemTable WHERE "key" = "extensionsIdentifiers/disabled";' | jq .
```


## Config

User Configuration for GitHub.copilot  

```bash
cat $HOME/Library/Application\ Support/Code/User/settings.json
```

```js
"github.copilot.enable": {
    "*": false,
    "yaml": true,
    "plaintext": false,
    "markdown": false,
    "typescript": false,
    "dockerfile": true
},
```

```bash
cat $HOME/Library/Application\ Support/Code/User/globalStorage/storage.json | jq .
```

## Find workspaces

NOTE: Sometimes we have two directories for the same workspace.  

```bash
# find the workspace configs for a project
# find all
export PROJECT=
# find root folder for clone
export PROJECT=react_examples$
# find parent folder for a set of clones
export PROJECT=/scratch/
# add -print if you want to debug
find $HOME/Library/Application\ Support/Code/User/workspaceStorage -iname "workspace.json" -exec jq --arg filename {} -c '. | {"folder": .folder, "filename": $filename}' {} \; | jq -s '.' | jq --arg project "${PROJECT}" '.[] | select(.folder != null) | select(.folder | test(".*\( $project )"))' | jq -s .
```

## Backup state

Backup the vsode state files.  We have a global one and one for each workspace.  

```bash
# backup global
mkdir -p ./out/global
cp "$HOME/Library/Application Support/Code/User/globalStorage/state.vscdb" ./out/global

# copy a workspaces db
mkdir -p ./out/react_examples
cp -r "/Users/${USER}/Library/Application Support/Code/User/workspaceStorage/b1fb23da175992912e0827db535659f7/" ./out/react_examples
```

## Query DB

```bash
# global state
export DBFILE=./out/global/state.vscdb
sqlite3 ${DBFILE} 'SELECT "key", value FROM ItemTable WHERE "key" LIKE "%copilot%";'

sqlite3 ${DBFILE} 'SELECT value FROM ItemTable WHERE "value" LIKE "%copilot%";' | jq .

# workspace examples
export DBFILE=./out/react_examples/state.vscdb
sqlite3 ${DBFILE} 'SELECT "key", value FROM ItemTable WHERE "key" LIKE "%copilot%";'

sqlite3 ${DBFILE} 'SELECT value FROM ItemTable WHERE "value" LIKE "%copilot%";' | jq .

sqlite3 ${DBFILE} 'SELECT "key", value FROM ItemTable WHERE "value" LIKE "%copilot%";' 

# find disabled extensions
sqlite3 ${DBFILE} 'SELECT "key", value FROM ItemTable WHERE "key" = "extensionsIdentifiers/disabled";' 

sqlite3 ${DBFILE} 'SELECT value FROM ItemTable WHERE "key" = "extensionsIdentifiers/disabled";' | jq .
```

## List workspaces and disabled extensions

```bash
# get full list of disabled extensions
find $HOME/Library/Application\ Support/Code/User/workspaceStorage -iname "state.vscdb" -print -exec sqlite3 {} 'SELECT "key", value FROM ItemTable WHERE "key" = "extensionsIdentifiers/disabled";' \; 

# find workspaces with disabled extension
find $HOME/Library/Application\ Support/Code/User/workspaceStorage -iname "state.vscdb" -print -exec sqlite3 {} 'select extensions.value 
  from ItemTable, json_each( ItemTable.value, "$" ) as extensions
 where ItemTable.key = "extensionsIdentifiers/disabled" and json_extract( extensions.value, "$.id" ) = "github.copilot"' \;

# single file check 
sqlite3 ${DBFILE} 'select count(extensions.value) 
  from ItemTable, json_each( ItemTable.value, "$" ) as extensions
 where ItemTable.key = "extensionsIdentifiers/disabled" and json_extract( extensions.value, "$.id" ) = "github.copilot"'

# filter id and add it back in 
# NOTE: does not work if row is not found
sqlite3 ${DBFILE} 'SELECT value FROM ItemTable WHERE "key" = "extensionsIdentifiers/disabled";' | jq --arg id "github.copilot" --arg guid "23c4aeee-f844-43cd-b53e-1113e483f1a6" '[.[] | del(select(.id==$id)) | select(. != null)] | . += [{"id": $id, "uuid": $guid}]' > ./disabled.json


sqlite3 ${DBFILE} 'REPLACE INTO ItemTable (key, value)
VALUES("extensionsIdentifiers/disabled2", readfile("./disabled.json"));'

sqlite3 ${DBFILE} 'REPLACE INTO ItemTable (key, value)
VALUES("extensionsIdentifiers/disabled2", "[]");'
sqlite3 ${DBFILE} 'SELECT value FROM ItemTable WHERE "key" = "extensionsIdentifiers/disabled2";' | jq .
sqlite3 ${DBFILE} 'DELETE FROM ItemTable WHERE "key" = "extensionsIdentifiers/disabled2";';


sqlite3 ${DBFILE} 'SELECT value FROM ItemTable WHERE "key" = "extensionsIdentifiers/disabled2";' | sed 's/^$/\[\]/' | jq --arg id "github.copilot" --arg guid "23c4aeee-f844-43cd-b53e-1113e483f1a6" '[.[] | del(select(.id==$id)) | select(. != null)] | . += [{"id": $id, "uuid": $guid}]' > ./disabled.json


echo "" | jq --null-input 'if . == null then [] else . end | .'
echo "{}" | jq --null-input 'if . == null then [] else . end | .'
echo "[]" | jq --null-input 'if . == null then [] else . end | .'
echo '{"ff":"ff"}' | jq --null-input 'if . == null then [] else . end | .'

echo "" | sed 's/^$/\[\]/' | jq 'if . == null then [] else . end | .'
echo "{}" | sed 's/^$/\[\]/' | jq 'if . == null then ["d"] else . end | .'
echo "[]" | sed 's/^$/\[\]/' | jq 'if . == null then ["d"] else . end | .'
echo '{"ff":"ff"}' | sed 's/^$/\[\]/' | jq 'if . == null then ["d"] else . end | .'


sqlite3 ${DBFILE} 'SELECT IFNULL(b.value, "[]") FROM (SELECT "extensionsIdentifiers/disabled" as keyname) as A LEFT OUTER JOIN ItemTable as B ON a.keyname=b.key;' 
sqlite3 ${DBFILE} 'SELECT IFNULL(b.value, "[]") FROM (SELECT "extensionsIdentifiers/disabled2" as keyname) as A LEFT OUTER JOIN ItemTable as B ON a.keyname=b.key;' 
sqlite3 ${DBFILE} 'SELECT IFNULL(b.value, "[]") FROM (SELECT "extensionsIdentifiers/disabled3" as keyname) as A LEFT OUTER JOIN ItemTable as B ON a.keyname=b.key;' 
```

## Resources

* https://code.visualstudio.com/docs/editor/extension-marketplace
* https://stackoverflow.com/questions/69706490/where-does-vscode-store-the-enabled-disabled-state-for-extensions
* https://www.sqlite.org/json1.html
* https://stackoverflow.com/questions/58519714/how-to-extract-properly-when-sqlite-json-has-value-as-an-array
* https://www.sqlitetutorial.net/sqlite-delete/
