FROM richarvey/nginx-php-fpm

LABEL maintainer="auchri <auer.chrisi@gmx.net>"

ARG PIWIK_VERSION=3.1.1
ARG WEBROOT=/var/www/html
ARG PIWIK_PATH=/usr/piwik
ARG GEOIP_PATH=/usr/src/misc/
ARG GEOIP_FILE=${GEOIP_PATH}GeoIPCity.dat
ARG GEOIP_FILE_NAME_GZ=GeoLiteCity.dat.gz

RUN apk add --no-cache bash \
   unzip

ADD robots.txt ${WEBROOT}/robots.txt

RUN mkdir ${PIWIK_PATH} && cd ${PIWIK_PATH} && \
    wget https://builds.piwik.org/piwik-${PIWIK_VERSION}.tar.gz && \
    tar -xzf piwik-${PIWIK_VERSION}.tar.gz && \
    rm piwik-${PIWIK_VERSION}.tar.gz && \
    mv piwik/* . && \
    rm -r piwik && \
    chown -Rf nginx:nginx . && \
    chmod -Rf 0755 .

RUN mkdir -p ${GEOIP_PATH} && \
    wget https://geolite.maxmind.com/download/geoip/database/${GEOIP_FILE_NAME_GZ} && \
    gunzip -c ${GEOIP_FILE_NAME_GZ} > ${GEOIP_FILE} && \
    chown -R nginx:nginx ${GEOIP_PATH} && \
    rm -f ${GEOIP_FILE_NAME_GZ}
RUN cd /usr/src && \
    rm -rf php.tar.xz php.tar.xz.asc

VOLUME ${WEBROOT}
CMD cp -rf ${PIWIK_PATH}* ${WEBROOT}/ && /start.sh
EXPOSE 80
