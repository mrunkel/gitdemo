FROM php:7.2

RUN apt-get update \
    && apt-get install -y gnupg libcurl4-openssl-dev sudo git libxslt-dev zlib1g-dev graphviz zip libmcrypt-dev libicu-dev g++ libpcre3-dev libgd-dev \
        libfreetype6-dev sqlite curl build-essential unzip gcc make autoconf libc-dev pkg-config libmemcached-dev \
    && apt-get clean \
    && docker-php-ext-install soap \
    && docker-php-ext-install zip \
    && docker-php-ext-install xsl \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install gettext \
    && docker-php-ext-install curl \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install json \
    && docker-php-ext-install intl \
    && docker-php-ext-install opcache \
    && pecl install memcached \
    && docker-php-ext-enable memcached \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && pecl install --nodeps mcrypt-snapshot \
    && docker-php-ext-enable mcrypt \
    && mkdir -p /tmp-libsodium/libsodium \
    && cd /tmp-libsodium/libsodium \
    && curl -L https://download.libsodium.org/libsodium/releases/libsodium-1.0.16.tar.gz -o libsodium-1.0.16.tar.gz \
    && tar xfvz libsodium-1.0.16.tar.gz \
    && cd /tmp-libsodium/libsodium/libsodium-1.0.16/ \
    && ./configure \
    && make \
    && make check \
    && make install \
    && mv src/libsodium /usr/local/ \
    && rm -Rf /tmp-libsodium/ \
    && docker-php-ext-install sodium \
    && docker-php-ext-enable sodium

RUN echo "memory_limit = -1;" > $PHP_INI_DIR/conf.d/memory_limit.ini

ENV COMPOSER_ALLOW_SUPERUSER=1

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash && apt-get install -y nodejs && apt-get clean
RUN curl -SL -o/usr/local/bin/phpcb https://github.com/mayflower/PHP_CodeBrowser/releases/download/2.0/phpcb-2.0.phar \
    && chmod +x /usr/local/bin/phpcb
RUN curl -SL -o/usr/local/bin/phpcpd https://phar.phpunit.de/phpcpd.phar \
    && chmod +x /usr/local/bin/phpcpd
RUN curl -SL -o/usr/local/bin/phpcs https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar \
    && chmod +x /usr/local/bin/phpcs
RUN curl -SL -o/usr/local/bin/phpcbf https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar \
    && chmod +x /usr/local/bin/phpcbf
RUN curl -sL -o/usr/local/bin/phpdox http://phpdox.de/releases/phpdox.phar \
    && chmod +x /usr/local/bin/phpdox
RUN curl -sL -o/usr/local/bin/phploc http://phar.phpunit.de/phploc.phar \
    && chmod +x /usr/local/bin/phploc
