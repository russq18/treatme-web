#Stage 1
FROM node:17-alpine3.15 as builder
WORKDIR /app
ENV PORT=4567
COPY package.json .
COPY package-lock.json .
RUN npm install
COPY . .
RUN npm run build


#Stage 2
FROM nginx:1.19.0
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=builder /app/build .
EXPOSE 4567
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]