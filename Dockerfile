FROM marklee77/slapd:latest
MAINTAINER Mark Stillwell <mark@stillwell.me>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get -y install \
        fusiondirectory \
        fusiondirectory-plugin-addressbook \
        fusiondirectory-plugin-alias \
        fusiondirectory-plugin-alias-schema \
        fusiondirectory-plugin-apache2 \
        fusiondirectory-plugin-apache2-schema \
        fusiondirectory-plugin-applications \
        fusiondirectory-plugin-applications-schema \
        fusiondirectory-plugin-argonaut \
        fusiondirectory-plugin-argonaut-schema \
        fusiondirectory-plugin-asterisk \
        fusiondirectory-plugin-asterisk-schema \
        fusiondirectory-plugin-autofs \
        fusiondirectory-plugin-autofs-schema \
        fusiondirectory-plugin-certificates \
        fusiondirectory-plugin-database-connector \
        fusiondirectory-plugin-debconf \
        fusiondirectory-plugin-debconf-schema \
        fusiondirectory-plugin-dhcp \
        fusiondirectory-plugin-dhcp-schema \
        fusiondirectory-plugin-dns \
        fusiondirectory-plugin-dns-schema \
        fusiondirectory-plugin-dovecot \
        fusiondirectory-plugin-dovecot-schema \
        fusiondirectory-plugin-dsa \
        fusiondirectory-plugin-dsa-schema \
        fusiondirectory-plugin-ejbca \
        fusiondirectory-plugin-ejbca-schema \
        fusiondirectory-plugin-fai \
        fusiondirectory-plugin-fai-schema \
        fusiondirectory-plugin-fax \
        fusiondirectory-plugin-fax-schema \
        fusiondirectory-plugin-freeradius \
        fusiondirectory-plugin-freeradius-schema \
        fusiondirectory-plugin-fusioninventory \
        fusiondirectory-plugin-fusioninventory-schema \
        fusiondirectory-plugin-gpg \
        fusiondirectory-plugin-gpg-schema \
        fusiondirectory-plugin-ipmi \
        fusiondirectory-plugin-ipmi-schema \
        fusiondirectory-plugin-kolab \
        fusiondirectory-plugin-kolab-schema \
        fusiondirectory-plugin-ldapdump \
        fusiondirectory-plugin-ldapmanager \
        fusiondirectory-plugin-mail \
        fusiondirectory-plugin-mail-schema \
        fusiondirectory-plugin-nagios \
        fusiondirectory-plugin-nagios-schema \
        fusiondirectory-plugin-netgroups \
        fusiondirectory-plugin-netgroups-schema \
        fusiondirectory-plugin-openstack-compute \
        fusiondirectory-plugin-openstack-compute-schema \
        fusiondirectory-plugin-opsi \
        fusiondirectory-plugin-opsi-schema \
        fusiondirectory-plugin-personal \
        fusiondirectory-plugin-personal-schema \
        fusiondirectory-plugin-ppolicy \
        fusiondirectory-plugin-ppolicy-schema \
        fusiondirectory-plugin-puppet \
        fusiondirectory-plugin-puppet-schema \
        fusiondirectory-plugin-pureftpd \
        fusiondirectory-plugin-pureftpd-schema \
        fusiondirectory-plugin-quota \
        fusiondirectory-plugin-quota-schema \
        fusiondirectory-plugin-repository \
        fusiondirectory-plugin-repository-schema \
        fusiondirectory-plugin-rsyslog \
        fusiondirectory-plugin-samba \
        fusiondirectory-plugin-samba-schema \
        fusiondirectory-plugin-sogo \
        fusiondirectory-plugin-sogo-schema \
        fusiondirectory-plugin-squid \
        fusiondirectory-plugin-squid-schema \
        fusiondirectory-plugin-ssh \
        fusiondirectory-plugin-ssh-schema \
        fusiondirectory-plugin-sudo \
        fusiondirectory-plugin-sudo-schema \
        fusiondirectory-plugin-supann \
        fusiondirectory-plugin-supann-schema \
        fusiondirectory-plugin-sympa \
        fusiondirectory-plugin-sympa-schema \
        fusiondirectory-plugin-systems \
        fusiondirectory-plugin-systems-schema \
        fusiondirectory-plugin-weblink \
        fusiondirectory-plugin-weblink-schema \
        fusiondirectory-plugin-webservice \
        fusiondirectory-plugin-webservice-schema \
        fusiondirectory-schema \
        fusiondirectory-smarty3-acl-render \
        fusiondirectory-webservice-shell \
        libapache2-mod-php \
        php-mbstring \
        php-mdb2 && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/*

RUN ln -s /usr/sbin/fusiondirectory-insert-schema /etc/ldap/dbinit.d/

COPY apache2.sh /etc/service/apache2/run

EXPOSE 80
