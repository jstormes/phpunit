# This is a convenience container for local workstation development
#
#
FROM php
MAINTAINER James Stormes <jstormes@stormes.net>

RUN apt-get update \
    && apt-get install -y net-tools curl wget git zip unzip mariadb-client joe gnupg2 \
    && wget https://getcomposer.org/installer \
    && php installer \
    && mv composer.phar /usr/local/bin/composer \
    && composer global require phpunit/phpunit \
        phpunit/dbunit \
        phing/phing \
        sebastian/phpcpd \
        phploc/phploc \
        phpmd/phpmd \
        squizlabs/php_codesniffer \
    && yes | pecl install xdebug \
       && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
       && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
       && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini


WORKDIR /opt/project

ENTRYPOINT ["/root/.composer/vendor/bin/phpunit"]
