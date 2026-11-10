FROM wordpress:7.1.4-php8.4-apache

COPY docker/php/uploads.ini \
    /usr/local/etc/php/conf.d/uploads.ini