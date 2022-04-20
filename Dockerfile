#build Vue project
FROM node:16-alpine AS build-stage
RUN npm install -g http-server
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

#Create nginx server
FROM nginx:1.21.6-alpine AS prod-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD [ "nginx", "-g","daemon off" ]