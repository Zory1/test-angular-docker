FROM node:13.3.0 AS compile-image
WORKDIR /usr/src/app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build --prod

FROM nginx
COPY docker/nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=compile-image /usr/src/app/dist/test-angular-docker /usr/share/nginx/html