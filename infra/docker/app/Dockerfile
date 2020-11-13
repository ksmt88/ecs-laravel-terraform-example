FROM php:7.4-fpm-alpine

RUN apk upgrade --update && \
  apk --no-cache add icu-dev autoconf make g++ gcc curl

# composer
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

# app
COPY . /var/www/html
WORKDIR /var/www/html
RUN composer install --optimize-autoloader --no-dev \
    && cp .env.example .env \
    && php artisan key:generate \
    && php artisan optimize \
    && chmod -R a+w storage/ bootstrap/cache
