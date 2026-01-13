FROM node:18-slim

WORKDIR /usr/src/app

COPY .output ./.output
COPY package.json ./

ARG SERVER_ENV=prod
ENV SERVER_ENV=${SERVER_ENV}
CMD npm run server-$SERVER_ENV