
# FROM node:18-alpine
# WORKDIR /treatme-web/
# COPY public/ /treatme-web/public
# COPY src/ /treatme-web/src
# COPY package.json /treatme-web/
# COPY package-lock.json .
# RUN npm install
# #RUN npm run build
# CMD ["npm", "start"]

# build environment
FROM node:lts-alpine as builder
WORKDIR /treatme-web
ENV PATH /treatme-web/node_modules/.bin:$PATH
COPY package.json ./
COPY package-lock.json ./
RUN npm ci --silent
RUN npm install react-scripts@3.4.1 -g --silent
COPY . ./
RUN npm run build

# production environment
FROM nginx:stable-alpine
COPY --from=builder /treatme-web/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]   