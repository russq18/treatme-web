# FROM node:lts-alpine
# WORKDIR /usr/src/app
# COPY package*.json ./
# RUN npm install
# EXPOSE 3000

# CMD ["npm", "start"]
FROM node:lts-alpine as build
WORKDIR /usr/src/app
COPY . /usr/src/app
RUN npm ci
RUN npm run build
