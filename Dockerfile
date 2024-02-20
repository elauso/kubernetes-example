FROM node:10-alpine

RUN mkdir -p /opt/app

WORKDIR /opt/app

COPY package.json .

RUN npm install

COPY app.js .

EXPOSE 3000

CMD [ "node", "app.js" ]