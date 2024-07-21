FROM node:18

WORKDIR /app

package.json package-lock.json /app/

COPY . /app

RUN npm install

RUN npm run build

EXPOSE 3000
