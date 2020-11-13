FROM nginx:1.19-alpine

COPY ./infra/docker/web/default.conf /etc/nginx/conf.d/default.conf
COPY ./public /var/www/html

EXPOSE 80
