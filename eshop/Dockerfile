FROM php:8.1 as php

RUN apt update -y
RUN apt install -y unzip libzip-dev libpq-dev libcurl4-gnutls-dev
RUN docker-php-ext-install zip curl pdo pdo_mysql

WORKDIR /var/www
COPY . .    

COPY --from=composer:2.4.4 /usr/bin/composer /usr/bin/composer

ENV PORT=8000
EXPOSE 8000
ENTRYPOINT [ "./entrypoint.sh"]