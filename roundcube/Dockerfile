ARG FROM_PREFIX

FROM ${FROM_PREFIX}python3

#XXX Switch to nginx.  May not be easy thanks for debian's deps.
#XXX --no-install-recommends?
RUN    apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y roundcube roundcube-sqlite3 \
    && rm -rf /var/lib/apt/lists/*

COPY config.inc.php /etc/roundcube/
COPY php.ini /etc/php/7.0/apache2/conf.d/99-local.ini
RUN    sed -i 's|/var/www/html|/var/lib/roundcube|g' /etc/apache2/sites-available/000-default.conf \
    && sed -i 's|/var/www/html|/var/lib/roundcube|g' /etc/apache2/sites-available/default-ssl.conf \
    && sed -i 's|/etc/ssl/certs/ssl-cert-snakeoil.pem|/keys/fullchain.pem|g' \
        /etc/apache2/sites-available/default-ssl.conf \
    && sed -i 's|/etc/ssl/private/ssl-cert-snakeoil.key|/keys/privkey.pem|g' \
        /etc/apache2/sites-available/default-ssl.conf \
    && a2ensite default-ssl \
    && a2enmod ssl \
    && dpkg-reconfigure -f noninteractive roundcube-core \
    && cat /var/lib/dbconfig-common/sqlite3/roundcube/roundcube | gzip > /rcdb.gz \
    && rm /var/lib/dbconfig-common/sqlite3/roundcube/roundcube
COPY start.sh /

CMD ["bash", "/start.sh"]
