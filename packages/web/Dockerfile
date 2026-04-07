FROM node:22-alpine

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install

COPY src/ ./src/
COPY next.config.ts ./
COPY tsconfig.json ./
COPY next-env.d.ts ./

EXPOSE 3001

CMD ["npm", "run", "dev"]
