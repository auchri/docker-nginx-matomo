FROM richarvey/nginx-php-fpm

MAINTAINER auchri <auer.chrisi@gmx.net>

ARG PIWIK_VERSION 2.16.2
ARG GEOIP_PATH /var/www/html/misc/
ARG GEOIP_FILE ${GEOIP_PATH}GeoIPCity.dat
ARG GEOIP_FILE_NAME_GZ GeoLiteCity.dat.gz

RUN apk add --no-cache bash \
   unzip

ADD robots.txt /var/www/html/robots.txt

RUN cd /var/www/html && \
    wget http://builds.piwik.org/piwik-${PIWIK_VERSION}.tar.gz && \
    tar -xzf piwik-${PIWIK_VERSION}.tar.gz && \
    rm piwik-${PIWIK_VERSION}.tar.gz && \
    mv piwik/* . && \
    rm -r piwik && \
    chown -Rf nginx:nginx . && \
    chmod -Rf 0755 .

RUN sed -i -e 's/;always_populate_raw_post_data = -1/always_populate_raw_post_data = -1/g' /etc/php5/php.ini
RUN sed -i -e 's/;always_populate_raw_post_data = -1/always_populate_raw_post_data = -1/g' /etc/php5/conf.d/php.ini

RUN mkdir -p ${GEOIP_PATH} && \
    wget http://geolite.maxmind.com/download/geoip/database/${GEOIP_FILE_NAME_GZ} && \
    gunzip -c ${GEOIP_FILE_NAME_GZ} > ${GEOIP_FILE} && \
    chown -R nginx:nginx ${GEOIP_PATH} && \
    rm -f ${GEOIP_FILE_NAME_GZ}

EXPOSE 443 80
