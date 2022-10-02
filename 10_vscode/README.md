# README

Demonstrate how to pull `vscode` 

## Resources


code --list-extensions

https://code.visualstudio.com/docs/editor/extension-marketplace

ls ~/.vscode/extensions

code --show-versions --list-extensions

cat $HOME/Library/Application\ Support/Code/User/settings.json

cat $HOME/Library/Application\ Support/Code/User/globalStorage/storage.json

find $HOME/Library/Application\ Support/Code/User/workspaceStorage/ -name "*.json" -exec jq . {} \;

https://stackoverflow.com/questions/69706490/where-does-vscode-store-the-enabled-disabled-state-for-extensions