# Create Apache & PHP 7.3 & Alpine Container.
FROM alpine:3.10.1

RUN apk update \
    && apk add --no-cache \
    # PHPライブラリ管理ツール
    composer=1.8.6-r0 \
    # Cで書かれた画像処理ライブラリ(公的書類画像処理に必要)
    imagemagick=7.0.8.58-r0 \
    # gdでpngをサポートする為に必要
    libpng=1.6.37-r1 \
    # gdでjpegをサポートする為に必要
    libjpeg=8-r6 \
    # PCRE関数(正規表現処理に必要)
    pcre=8.43-r0 \
    # PHP, Apache
    php7-apache2=7.3.11-r0 \
    # curl(APIリクエストに必要)
    php7-curl=7.3.11-r0 \
    # 画像リサイズに必須(画像upload時にgetimagesize()で使用)
    php7-gd=7.3.11-r0 \
    # ImageMagickをPHPから操作する為の拡張モジュール
    php7-pecl-imagick=3.4.4-r1 \
    # デバッグ用拡張モジュール
    php7-pecl-xdebug=2.7.2-r1 \
    # PEARモジュール(composer管理のライブラリが依存)
    php7-pear=7.3.11-r0 \
    # XML用拡張モジュール(composer管理のライブラリが依存)
    php7-simplexml=7.3.11-r0 \
    # composer(PHP package manager.)
    composer=1.8.6-r0 \
  && rm -rf /tmp/* /var/cache/apk/*


# COPY PHP Modules.
COPY ./src /var/www/html/

# Set httpd
COPY ./config/httpd.conf /etc/apache2/httpd.conf
COPY ./config/ca /etc/apache2/ca
COPY ./config/virtual-host.conf /etc/apache2/virtual-host.conf

# Set php.ini
COPY ./config/php.ini /etc/php7/php.ini

# Install Composer
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_NO_INTERACTION 1

EXPOSE 80

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]