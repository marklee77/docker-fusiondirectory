FROM marklee77/slapd:latest
MAINTAINER Mark Stillwell <mark@stillwell.me>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get -y install \
        fusiondirectory \
        fusiondirectory-schema && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/*

RUN ln -s /usr/sbin/fusiondirectory-insert-schema /etc/ldap/dbinit.d/

COPY apache2.sh /etc/service/apache2/run

EXPOSE 80
