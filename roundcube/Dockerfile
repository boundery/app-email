ARG FROM_PREFIX

FROM ${FROM_PREFIX}python3

#XXX Switch to nginx.  May not be easy thanks for debian's deps.
RUN    apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y roundcube roundcube-sqlite3 \
    && sed -i 's|/var/www/html|/var/lib/roundcube|g' /etc/apache2/sites-enabled/000-default.conf \
    && rm -rf /var/lib/apt/lists/*

COPY config.inc.php /etc/roundcube/
COPY php.ini /etc/php/7.0/apache2/conf.d/99-local.ini
RUN    dpkg-reconfigure -f noninteractive roundcube-core \
    && cat /var/lib/dbconfig-common/sqlite3/roundcube/roundcube | gzip > /rcdb.gz \
    && rm /var/lib/dbconfig-common/sqlite3/roundcube/roundcube
COPY start.sh /

CMD ["bash", "/start.sh"]
