FROM richarvey/nginx-php-fpm

MAINTAINER auchri <auer.chrisi@gmx.net>

ENV PIWIK_VERSION latest

RUN cd /var/www/html && \
    wget http://builds.piwik.org/piwik-${PIWIK_VERSION}.tar.gz && \
    tar -xzf piwik-${PIWIK_VERSION}.tar.gz && \
    rm piwik-${PIWIK_VERSION}.tar.gz && \
    mv piwik/* . && \
    rm -r piwik && \
    chown -R nginx:nginx . && \
    chmod 0770 tmp && \
    chmod 0770 config && \
    chmod 0600 config/*

RUN sed -i -e 's/;always_populate_raw_post_data = -1/always_populate_raw_post_data = -1/g' /etc/php5/php.ini
RUN sed -i -e 's/;always_populate_raw_post_data = -1/always_populate_raw_post_data = -1/g' /etc/php5/conf.d/php.ini

EXPOSE 443 80
