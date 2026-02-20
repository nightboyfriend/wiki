
FROM node:20-bullseye-slim

RUN apt-get update && apt-get install -y --no-install-recommends git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/wiki

COPY package*.json ./

RUN npm install --production --legacy-peer-deps \
    && npm cache clean --force

COPY . .

RUN mkdir -p /var/wiki/data && chown -R node:node /var/wiki
USER node

EXPOSE 3000

CMD ["node", "server"]