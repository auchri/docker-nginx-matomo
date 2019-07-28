FROM richarvey/nginx-php-fpm:1.5.3

LABEL maintainer="auchri <auer.chrisi@gmx.net>"

ARG MATOMO_VERSION=3.10.0
ARG WEBROOT=/var/www/html
ARG MATOMO_PATH=${WEBROOT}
ARG GEOIP_PATH=${MATOMO_PATH}/misc/
ARG GEOIP_FILE=${GEOIP_PATH}GeoIPCity.dat
ARG GEOIP_FILE_NAME_GZ=GeoLiteCity.dat.gz

ENV SKIP_COMPOSER=1

RUN apk add --no-cache bash \
   unzip

ADD robots.txt ${WEBROOT}/robots.txt

RUN mkdir -p ${MATOMO_PATH} && cd ${MATOMO_PATH} && \
    wget https://builds.matomo.org/matomo-${MATOMO_VERSION}.tar.gz && \
    tar -xzf matomo-${MATOMO_VERSION}.tar.gz && \
    rm matomo-${MATOMO_VERSION}.tar.gz && \
    rm *.html && \
    mv matomo/* . && \
    rm -r matomo && \
    chmod -Rf 0755 .

#RUN mkdir -p ${GEOIP_PATH} && \
#    wget https://geolite.maxmind.com/download/geoip/database/${GEOIP_FILE_NAME_GZ} && \
#    gunzip -c ${GEOIP_FILE_NAME_GZ} > ${GEOIP_FILE} && \
#    rm -f ${GEOIP_FILE_NAME_GZ}

EXPOSE 80
