## Builder 
FROM node:18-alpine3.14 as Builder

LABEL maintainer="hj.an@cardoc.kr"

WORKDIR /app
COPY . .
RUN yarn install
RUN yarn build

## Runner
FROM node:18-alpine3.14

WORKDIR /app
COPY ./package.json ./package.json
RUN yarn install --production
COPY --from=Builder /app/dist ./dist

CMD ["yarn", "start:prod"]

EXPOSE 3000
