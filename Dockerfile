FROM marklee77/slapd:jessie
MAINTAINER Mark Stillwell <mark@stillwell.me>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-key adv --keyserver pool.sks-keyservers.net --recv-key D744D55EACDA69FF && \
    echo "deb http://repos.fusiondirectory.org/fusiondirectory-current/debian-jessie jessie main" > \
         /etc/apt/sources.list.d/fusiondirectory.list && \
    echo "deb http://repos.fusiondirectory.org/fusiondirectory-extra/debian-jessie jessie main" >> \
         /etc/apt/sources.list.d/fusiondirectory.list

RUN apt-get update && \
    apt-get -y install --no-install-recommends \
        fusiondirectory \
        fusiondirectory-plugin-alias \
        fusiondirectory-plugin-alias-schema \
        fusiondirectory-plugin-applications \
        fusiondirectory-plugin-applications-schema \
        fusiondirectory-plugin-argonaut \
        fusiondirectory-plugin-argonaut-schema \
        fusiondirectory-plugin-audit \
        fusiondirectory-plugin-audit-schema \
        fusiondirectory-plugin-autofs \
        fusiondirectory-plugin-autofs-schema \
        fusiondirectory-plugin-certificates \
        fusiondirectory-plugin-community \
        fusiondirectory-plugin-community-schema \
        fusiondirectory-plugin-cyrus \
        fusiondirectory-plugin-cyrus-schema \
        fusiondirectory-plugin-debconf \
        fusiondirectory-plugin-debconf-schema \
        fusiondirectory-plugin-developers \
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
        fusiondirectory-plugin-freeradius \
        fusiondirectory-plugin-freeradius-schema \
        fusiondirectory-plugin-fusioninventory \
        fusiondirectory-plugin-fusioninventory-schema \
        fusiondirectory-plugin-gpg \
        fusiondirectory-plugin-gpg-schema \
        fusiondirectory-plugin-ipmi \
        fusiondirectory-plugin-ipmi-schema \
        fusiondirectory-plugin-ldapdump \
        fusiondirectory-plugin-ldapmanager \
        fusiondirectory-plugin-mail \
        fusiondirectory-plugin-mail-schema \
        fusiondirectory-plugin-mixedgroups \
        fusiondirectory-plugin-nagios \
        fusiondirectory-plugin-nagios-schema \
        fusiondirectory-plugin-netgroups \
        fusiondirectory-plugin-netgroups-schema \
        fusiondirectory-plugin-newsletter \
        fusiondirectory-plugin-newsletter-schema \
        fusiondirectory-plugin-opsi \
        fusiondirectory-plugin-opsi-schema \
        fusiondirectory-plugin-personal \
        fusiondirectory-plugin-personal-schema \
        fusiondirectory-plugin-postfix \
        fusiondirectory-plugin-postfix-schema \
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
        fusiondirectory-plugin-samba \
        fusiondirectory-plugin-samba-schema \
        fusiondirectory-plugin-sogo \
        fusiondirectory-plugin-sogo-schema \
        fusiondirectory-plugin-spamassassin \
        fusiondirectory-plugin-spamassassin-schema \
        fusiondirectory-plugin-squid \
        fusiondirectory-plugin-squid-schema \
        fusiondirectory-plugin-ssh \
        fusiondirectory-plugin-ssh-schema \
        fusiondirectory-plugin-subcontracting \
        fusiondirectory-plugin-subcontracting-schema \
        fusiondirectory-plugin-sudo \
        fusiondirectory-plugin-sudo-schema \
        fusiondirectory-plugin-supann \
        fusiondirectory-plugin-supann-schema \
        fusiondirectory-plugin-sympa \
        fusiondirectory-plugin-sympa-schema \
        fusiondirectory-plugin-systems \
        fusiondirectory-plugin-systems-schema \
        fusiondirectory-plugin-user-reminder \
        fusiondirectory-plugin-user-reminder-schema \
        fusiondirectory-plugin-weblink \
        fusiondirectory-plugin-weblink-schema \
        fusiondirectory-plugin-webservice \
        fusiondirectory-plugin-webservice-schema \
        fusiondirectory-schema \
        fusiondirectory-smarty3-acl-render \
        fusiondirectory-theme-oxygen \
        fusiondirectory-webservice-shell \
        libapache2-mod-php5 \
        php-mdb2 && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/*

COPY root/etc/ldap/dbinit.d/10-fusiondirectory /etc/ldap/dbinit.d/
RUN chmod 0755 /etc/ldap/dbinit.d/10-fusiondirectory
COPY root/etc/supervisor/conf.d/apache2.conf /etc/supervisor/conf.d/
RUN chmod 0644 /etc/supervisor/conf.d/apache2.conf

EXPOSE 80
