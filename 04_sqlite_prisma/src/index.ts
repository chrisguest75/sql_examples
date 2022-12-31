import { logger } from './logger'
import * as dotenv from 'dotenv'
import * as fs from 'fs'
import minimist from 'minimist'
import { PrismaClient } from '@prisma/client'
import { randNumber, randTextRange, randEmail, randUser } from '@ngneat/falso'
import { Pokemon } from '../types/pokemon'
import { Conversion } from '../src/conversion'

const prisma = new PrismaClient({ log: ['query'] })

const PokemonTypes = [
  'Bug',
  'Dark',
  'Dragon',
  'Electric',
  'Fairy',
  'Fighting',
  'Fire',
  'Flying',
  'Ghost',
  'Grass',
  'Ground',
  'Ice',
  'Poison',
  'Psychic',
  'Rock',
  'Steel',
  'Water',
]

/*
Clean the database
 */
async function clean(args: minimist.ParsedArgs) {
  logger.info(`Cleaning pokemon`)
  await prisma.pokemon.deleteMany({})

  logger.info(`Cleaning pokemonTypes`)
  await prisma.pokemonType.deleteMany({})

  logger.info(`Cleaning pokemonWeakenesses`)
  await prisma.pokemonWeakness.deleteMany({})

  // NOTE: it will fail deleting the user if there are tweets
  return new Promise((resolve, reject) => {
    resolve('Complete')
  })
}

/*
Initilize the database
 */
async function seed(args: minimist.ParsedArgs) {
  logger.info(`Initializing DB`)

  // load json file if specified
  if (args['file']) {
    const file = args['file']
    logger.info(`Loading file:${file}`)
    try {
      const pokedex = JSON.parse(fs.readFileSync(file, 'utf8'))

      // create pokemon
      await Promise.all(
        pokedex.pokemon.map(async (pokemon: Pokemon) => {
          const heightCm = Conversion.metresToCm(pokemon.height)
          const weightGrams = Conversion.kilosToGrams(pokemon.weight)
          let eggMetres = -1
          if (pokemon.egg !== 'Not in Eggs') {
            eggMetres = Conversion.distanceToMetres(pokemon.egg)
          }

          const record = await prisma.pokemon.create({
            data: {
              id: pokemon.id,
              version: pokemon.version,
              num: pokemon.num,
              name: pokemon.name,
              imageUrl: pokemon.img,
              heightCm: heightCm,
              weightGrams: weightGrams,
              candy: pokemon.candy,
              candy_count: pokemon.candy_count,
              eggMetres: eggMetres,
              spawn_chance: pokemon.spawn_chance,
              avg_spawns: pokemon.avg_spawns,
              spawn_time: pokemon.spawn_time,
            },
          })

          pokemon.type.map(async (type: string) => {
            const typerecord = await prisma.pokemonType.create({
              data: {
                name: type,
                pokemonId: pokemon.id,
              },
            })
            logger.info(`PokemonType`, JSON.stringify(typerecord))
          }),
            pokemon.weaknesses.map(async (weakness: string) => {
              const weaknessrecord = await prisma.pokemonWeakness.create({
                data: {
                  name: weakness,
                  pokemonId: pokemon.id,
                },
              })
              logger.info(`PokemonWeakeness`, JSON.stringify(weaknessrecord))
            }),
            logger.info(`Pokemon`, JSON.stringify(record))
        }),
      )
    } catch (e) {
      logger.error(e)
      return new Promise((resolve, reject) => {
        reject(e)
      })
    }
  }

  return new Promise((resolve, reject) => {
    resolve('Complete')
  })
}

async function query(args: minimist.ParsedArgs) {
  logger.info(`Querying DB`)

  return new Promise((resolve, reject) => {
    resolve('Complete')
  })
}

/*
main
*/
// eslint-disable-next-line @typescript-eslint/no-unused-vars
export async function main(args: minimist.ParsedArgs) {
  /*logger.trace('TRACE - level message')
  logger.debug('DEBUG - level message')
  logger.info('INFO - level message')
  logger.warn('WARN - level message')
  logger.error('ERROR - level message')
  logger.fatal('FATAL - level message')*/
  let processed = false

  if (args['clean']) {
    await clean(args)
    processed = true
  }

  if (args['seed']) {
    await seed(args)
    processed = true
  }

  if (args['query']) {
    await query(args)
    processed = true
  }

  if (!processed) {
    logger.warn('No command specified')
  }

  return new Promise((resolve, reject) => {
    resolve('Complete')
  })
}

process.on('exit', async () => {
  logger.warn('exit signal received')
})

process.on('uncaughtException', async (error: Error) => {
  logger.error(error)
  // for nice printing
  console.log(error)
  process.exit(1)
})

process.on('unhandledRejection', async (reason, promise) => {
  logger.error({
    promise: promise,
    reason: reason,
    msg: 'Unhandled Rejection',
  })
  console.log(reason)
  process.exit(1)
})

/*
Entrypoint
*/
// load config
dotenv.config()
logger.info(`Pino:${logger.version}`)
const args: minimist.ParsedArgs = minimist(process.argv.slice(2), {
  string: ['count', 'file'],
  boolean: ['verbose', 'seed', 'clean', 'query'],
  default: { count: '1', seed: false, clean: false, query: false },
})
//const m = promisify(main)
main(args)
  .then(() => {
    process.exit(0)
  })
  .catch((e) => {
    logger.error(e)
    process.exit(1)
  })
  .finally(async () => {
    await prisma.$disconnect()
  })
