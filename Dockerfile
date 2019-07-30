FROM node:10
RUN mkdir -p /usr/src/app/node_modules && chown -R node:node /usr/src/app
WORKDIR /usr/src/app
COPY package*.json ./
USER node
RUN npm install
COPY --chown=node:node . .
RUN chmod -R 755 .
EXPOSE 3000
CMD [ "npm" ,"start" ]
