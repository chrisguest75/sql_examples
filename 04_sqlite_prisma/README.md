# README

Demonstrate using prisma with sqlite.  

## Reason

Prisma is an ORM for typescript that handles multiple SQL backends.  

NOTES:

* Using distroless image fails because the libraries are compiled in the first stage image.  
* The db is created during the image build.  

TODO:

* Add turn verbose on or not for logging.  
* Spawn time as seconds.
* React page to render queries
* Block level attributes

## Prerequisites

```sh
code --install-extension Prisma.prisma
code --install-extension alexcvzz.vscode-sqlite
```

## Start

```sh
nvm use
npm install

# run tests
npm run test

#
npm run start:dev

# seed with a file
npm run start:once -- --seed --file "./pokedex.json"     

# clean db
npx prisma migrate reset  
# or
npm run start:once -- --clean 
```

## Querying

```sh
# list available queries
npm run start:once -- --listQueries     

npm run start:once -- --query countPokemon  
npm run start:once -- --query heaviestWeight            
npm run start:once -- --query heaviestPokemon
npm run start:once -- --query tallestPokemon

npm run start:once -- --query findPokemon --name Snorlax
npm run start:once -- --query findPokemon --name Pidgeot
npm run start:once -- --query findPokemonMatch --name S

npm run start:once -- --query findPokemonInclude --name Pidgeot

npm run start:once -- --query listWeaknesses  

# THIS IS NOT WORKING CORRECTLY
npm run start:once -- --query findPokemonWithWeakness --weakness Psychic
```

## Docker

```sh
npm run docker:run -- ./src/index.js --listQueries  

npm run docker:run -- ./src/index.js --query findPokemon --name Snorlax

npm run docker:run -- ./src/index.js --query listWeaknesses
```

## Schema changes

```sh
# add a new field and create a new migration
npx prisma migrate dev --name add_liked 

# adding a type relationship and get prisma to add the correct syntax to the schema
npx prisma format        
```

## Created

```sh
npm install @prisma/client

npx prisma
# 
npx prisma init --datasource-provider sqlite
```

## Troubleshooting

```sh
# troubleshooting builder
npm run docker:build:builder            
docker run -it 04_sqlite_prisma /bin/bash  
```

## Resources

* How to Build a Node.js Database using Prisma and SQLite [here](https://www.freecodecamp.org/news/build-nodejs-database-using-prisma-orm/)  
* NodeJS ESXXXX support [here](https://node.green/)  
* ES2021 Features with simple examples [here](https://dev.to/carlillo/es2021-features-with-simple-examples-27d3)  
* falso [here](https://netbasal.com/generate-fake-data-in-the-browser-and-node-js-using-falso-3998d2bcbaaf)
* falso getting started [here](https://ngneat.github.io/falso/docs/getting-started/)
* falso examples [here](https://ngneat.github.io/falso/docs/general/#randboolean)
* Learn Prisma In 60 Minutes [here](https://www.youtube.com/watch?v=RebA5J-rlwg)
* Prisma, how to clear the database [here](https://flaviocopes.com/prisma-clear-database/)
* Concepts / Components / Prisma schema / Generators [here](https://www.prisma.io/docs/concepts/components/prisma-schema/generators)
* Concepts / Components / Prisma schema / Data model [here](https://www.prisma.io/docs/concepts/components/prisma-schema/data-model)
* Concepts / Components / Prisma Client / Relation queries [here](https://www.prisma.io/docs/concepts/components/prisma-client/relation-queries)
* How can I get the full object in Node.js's console.log(), rather than '[Object]'? [here](https://stackoverflow.com/questions/10729276/how-can-i-get-the-full-object-in-node-jss-console-log-rather-than-object)  
