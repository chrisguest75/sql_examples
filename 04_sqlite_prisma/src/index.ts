import { logger } from './logger'
import * as dotenv from 'dotenv'
import * as fs from 'fs'
import minimist from 'minimist'
import { PrismaClient } from '@prisma/client'
import {
  randNumber,
  randTextRange,
  randEmail,
  randUser,
} from '@ngneat/falso'

const prisma = new PrismaClient()

/*
Clean the database
 */
async function clean(args: minimist.ParsedArgs) {
  logger.info(`Cleaning tweets`)
  await prisma.tweet.deleteMany({})
  logger.info(`Cleaning users`)
  await prisma.user.deleteMany({})

  return new Promise((resolve, reject) => {
    resolve('Complete')
  })
}

/*
Initilize the database
 */
async function seed(args: minimist.ParsedArgs) {
  logger.info(`Initializing DB`)

  const count = Number.parseInt(args['count'])
  if (count <= 0) {
    logger.warn('File count is not set')
  } else {
    logger.info(`Writing ${count} records`)
  }
  for (let i = 0; i < count; i++) {
    // We create a new user
    const newUser = await prisma.user.create({
      data: {
        email: randEmail(),
        username: randUser().username,
      },
    })

    logger.info(`NewUser:${newUser}`)

    const tweets = randNumber({ min: 1, max: 6 })
    for (let tweet = 0; tweet < tweets; tweet++) {
      const firstTweet = await prisma.tweet.create({
        data: {
          text: randTextRange({ min: 10, max: 100 }),
          userId: newUser.id,
        },
      })

      logger.info(`Tweet ${tweet}:${firstTweet}`)
    }
  }

  return new Promise((resolve, reject) => {
    resolve('Complete')
  })
}

/*
async function query(args: minimist.ParsedArgs) {
  return new Promise((resolve, reject) => {
    logger.info(`Querying DB`)
    // We fetch the new user again (by its unique email address)
    // and we ask to fetch its tweets at the same time
    const newUserWithTweets = await prisma.user.findUnique({
      where: {
        email: 'hello@herewecode.io',
      },
      include: { tweets: true },
    })
  
    logger.info(`Tweets:${newUserWithTweets}`)
      resolve('Complete')
  })

  return true
}
*/
/*
main
*/
// eslint-disable-next-line @typescript-eslint/no-unused-vars
export async function main(args: minimist.ParsedArgs) {
  logger.trace('TRACE - level message')
  logger.debug('DEBUG - level message')
  logger.info('INFO - level message')
  logger.warn('WARN - level message')
  logger.error('ERROR - level message')
  logger.fatal('FATAL - level message')

  if (args['clean']) {
    await clean(args)
  }

  if (args['seed']) {
    await seed(args)
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
  string: ['count'],
  boolean: ['verbose', 'seed', 'clean', 'query'],
  default: { count: '3', seed: false, clean: false, query: false },
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
