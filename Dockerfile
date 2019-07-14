# Create Apache & PHP 7.3 & Alpine Container.
FROM php:7.3.6-zts-alpine3.9

RUN apk update \
    && apk add --no-cache apache2-ssl=2.4.39-r0 \
    php7-apache2=7.2.19-r0 \
    php7-json=7.2.19-r0 \
    php7-curl=7.2.19-r0 \
    php7-mbstring=7.2.19-r0 \
    libpng-dev=1.6.37-r0 \
    libjpeg=8-r6 \
    libxml2-dev=2.9.9-r1 \
    autoconf=2.69-r2 \
    g++=8.3.0-r0 \
    imagemagick-dev=7.0.8.44-r0 \
    libtool=2.4.6-r5 \
    make=4.2.1-r2 \
    pcre-dev=8.42-r1 \
    php7-pecl-apcu=5.1.16-r0 \
    php7-pecl-imagick=3.4.3-r9 \
    php7-gd=7.2.19-r0 \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && rm -rf /tmp/* /var/cache/apk/*


# COPY PHP Modules.
COPY ./src /var/www/html/

# Set httpd
COPY ./config/httpd.conf /etc/apache2/httpd.conf
COPY ./config/ca /etc/apache2/ca
COPY ./config/kakunin-virtual-host.conf /etc/apache2/kakunin-virtual-host.conf

# Set php.ini
COPY ./config/php.ini /usr/local/etc/php.ini-development
COPY ./config/php.ini /usr/local/etc/php.ini-production

# Install Composer
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_NO_INTERACTION 1

WORKDIR /usr/local/bin
RUN curl -sS https://getcomposer.org/installer | php

EXPOSE 443
EXPOSE 80

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]