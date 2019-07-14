# Create Apache & PHP 5.6 Container.
FROM amazonlinux:2018.03.0.20190212

# PHP 5.6
RUN yum -y install \
    php56-devel \
    php56-gd.x86_64 \
    php56-mbstring.x86_64 \
    php56-mysqlnd \
    php56-opcache \
    php56-pdo \
    php56-pecl-apcu \
    php56-pecl-imagick.x86_64 \
    uuid-php56 \
    libxml2 \
    libjpeg \
    libpng \
    vim 

# Apache(httpd.2.4)
RUN yum -y install httpd24 mod24_ssl

# COPY PHP Modules.
COPY ./src /var/www/html/

# Set httpd
COPY ./config/httpd.conf /etc/httpd/conf/httpd.conf
COPY ./config/ca /etc/httpd/conf/ca
COPY ./config/virtual-host.conf /etc/httpd/conf/virtual-host.conf

# Set php.ini
COPY ./config/php.ini /etc/php-5.6.ini

# Install Composer
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_NO_INTERACTION 1

WORKDIR /usr/local/bin
RUN curl -sS https://getcomposer.org/installer | php

EXPOSE 443
EXPOSE 80
EXPOSE 8000

CMD /usr/sbin/httpd -D FOREGROUND
