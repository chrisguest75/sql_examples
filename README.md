# SQL EXAMPLES

A reposistory to demonstrate some SQL examples

[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-%23FE5196?logo=conventionalcommits&logoColor=white)](https://conventionalcommits.org) [![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit)](https://github.com/pre-commit/pre-commit)  

[![Repository](https://skillicons.dev/icons?i=bash,linux)](https://skillicons.dev)

## Conventional Commits

NOTE: This repo has switched to [conventional commits](https://www.conventionalcommits.org/en/v1.0.0). It requires `pre-commit` and `commitizen` to help with controlling this.  

```sh
# install pre-commmit (prerequisite for commitizen)
brew install pre-commit
brew install commitizen
# conventional commits extension
code --install-extension vivaxy.vscode-conventional-commits

# install hooks
pre-commit install --hook-type commit-msg --hook-type pre-push
```

## 00 - cheatsheet

Cheatsheet for Sqlite  
Steps [README.md](./00_cheatsheet/README.md)  

## 01 - sqlite basic

Demonstrate a basic `sqlite` example  
Steps [README.md](./01_sqlite_basic/README.md)  

## 02 - sqlite sbom

Demonstrate building an SBOM db in sqlite  
Steps [README.md](./02_sqlite_sbom/README.md)  

## 04 - sqlite prisma

Demonstrate using prisma with sqlite.  
Steps [README.md](./04_sqlite_prisma/README.md)  

## 12 - aws athena

Amazon Athena is an interactive query service offered by Amazon Web Services (AWS).  
Steps [README.md](./12_athena/README.md)  

## Resources

* What Is SQLite? [here](https://sqlite.org/index.html)
* SQLite Tutorial [here](https://www.sqlitetutorial.net/)
* SQL:2003 [here](https://en.wikipedia.org/wiki/SQL:2003)
* SQL:2008 [here](https://en.wikipedia.org/wiki/SQL:2008)
* SQL:2011 [here](https://en.wikipedia.org/wiki/SQL:2011)
* SQL:2016 [here](https://en.wikipedia.org/wiki/SQL:2016)
* SQL:2023 [here](https://en.wikipedia.org/wiki/SQL:2023)
