# syntax=docker/dockerfile:1.4
FROM node:16.13.2-bullseye AS BUILDER
LABEL dockerfile.baseimage="node:16.13.2-bullseye" dockerfile.description="04_sqlite_prisma" dockerfile.stage="BUILDER"

WORKDIR /scratch

RUN curl -sf -o /bin/node-prune https://gobinaries.com/tj/node-prune && chmod +x /bin/node-prune && /bin/node-prune

COPY package.json package-lock.json ./
# https://docs.npmjs.com/cli/v7/commands/npm-ci
RUN npm ci

COPY tsconfig.json .prettierrc jest.config.js .eslintrc ./
COPY pokedex.json ./
COPY src ./src
COPY tests ./tests
COPY types ./types
COPY prisma/migrations ./prisma/migrations
COPY prisma/schema.prisma ./prisma/schema.prisma 
RUN npm run lint
RUN npm run test:coverage
RUN npm run build
RUN npm audit

COPY --chmod=755 <<EOF /scratch/prepare.sh
#!/usr/bin/env bash
export DATABASE_URL="file:./dev.db"
npm exec prisma migrate deploy     
npm exec prisma generate             
npm run start:once -- --seed --file "./pokedex.json" 
EOF
RUN /scratch/prepare.sh

RUN npm ci --only=production && npm cache clean --force

# prune the node_modules
#RUN /usr/local/bin/node-prune --verbose ./node_modules

#FROM gcr.io/distroless/nodejs:16 AS PRODUCTION
FROM node:16.13.2-bullseye AS PRODUCTION
LABEL dockerfile.baseimage="gcr.io/distroless/nodejs:16" dockerfile.description="04_sqlite_prisma" dockerfile.stage="PRODUCTION"

ENV NODE_ENV production

WORKDIR /work
ENV DATABASE_URL="file:./dev.db"
COPY --from=BUILDER /scratch/node_modules ./node_modules
COPY --from=BUILDER /scratch/build ./
COPY --from=BUILDER /scratch/prisma ./prisma

CMD ["/work/src/index.js"]