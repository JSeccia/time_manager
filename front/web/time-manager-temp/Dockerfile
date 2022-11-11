FROM node:lts-alpine as build-stage
RUN mkdir /app
WORKDIR /app
COPY package*.json ./
COPY quasar.conf.js ./
COPY . .
RUN rm -rf node_modules
RUN npm install
RUN npm install -g @vue/cli
RUN npm install -g @quasar/cli
RUN quasar build

# étape de production
FROM nginx:stable-alpine as production-stage

COPY --from=build-stage /app/dist/spa /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
# COPY nginx.conf /etc/nginx/nginx.conf
CMD ["nginx", "-g", "daemon off;"]
