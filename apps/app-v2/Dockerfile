FROM node:22-alpine
WORKDIR /usr/src/app
COPY package*.json app.js server.js ./
RUN npm install
EXPOSE 4000
CMD ["node", "server.js"]