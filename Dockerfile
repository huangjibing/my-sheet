FROM node:18-alpine AS builder

WORKDIR /app

RUN apk add --no-cache python3 make g++

ENV CI=true
ENV NUXT_TELEMETRY_DISABLED=1
ENV NODE_OPTIONS=--max-old-space-size=4096
ENV MODE=production

COPY package.json package-lock.json ./

RUN npm install --legacy-peer-deps --ignore-scripts
RUN npx nuxt prepare

COPY . .
RUN npm run build

FROM node:18-alpine
WORKDIR /app

COPY --from=builder /app/.output ./.output

ENV NODE_ENV=production
EXPOSE 3000

CMD ["node", ".output/server/index.mjs"]
