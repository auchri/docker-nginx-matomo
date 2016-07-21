FROM richarvey/nginx-php-fpm

MAINTAINER auchri <auer.chrisi@gmx.net>

ENV PIWIK_VERSION 2.16.1
ENV GEOIP_FILE_NAME GeoLiteCity.dat
ENV GEOIP_FILE_NAME_GZ ${GEOIP_FILE_NAME}.gz

RUN apk add --no-cache bash \
   unzip

ADD robots.txt /var/www/html/robots.txt

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

RUN wget http://geolite.maxmind.com/download/geoip/database/${GEOIP_FILE_NAME_GZ} && \
    gunzip -c ${GEOIP_FILE_NAME_GZ} > /var/www/html/misc/${GEOIP_FILE_NAME} && \
    chown nginx:nginx /var/www/html/misc/${GEOIP_FILE_NAME} && \
    rm -f ${GEOIP_FILE_NAME_GZ}

EXPOSE 443 80
