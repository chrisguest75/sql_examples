# README

Demonstrate using prisma with sqlite.  

## Reason


## Prerequisites

```sh
code --install-extension Prisma.prisma
code --install-extension alexcvzz.vscode-sqlite
```

## Start

```sh
nvm use
npm install

npm run start:dev

# seeddb with 10  
npm run start:dev -- --seed --count 10 

# clean db
npm run start:dev -- --clean 
```

## Created

```sh
npm install @ngneat/falso 
npm install @prisma/client

npx prisma

npx prisma init --datasource-provider sqlite
```

## Resources

* How to Build a Node.js Database using Prisma and SQLite [here](https://www.freecodecamp.org/news/build-nodejs-database-using-prisma-orm/)  
* NodeJS ESXXXX support [here](https://node.green/)  
* ES2021 Features with simple examples [here](https://dev.to/carlillo/es2021-features-with-simple-examples-27d3)  
* falso [here](https://netbasal.com/generate-fake-data-in-the-browser-and-node-js-using-falso-3998d2bcbaaf)
* falso getting started [here](https://ngneat.github.io/falso/docs/getting-started/)
* falso examples [here](https://ngneat.github.io/falso/docs/general/#randboolean)


https://www.danilucaci.com/blog/reset-and-seed-prisma-database
https://flaviocopes.com/prisma-clear-database/
