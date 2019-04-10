#!/bin/sh

useradd -m $USERNAME
echo $USERNAME:prjx321 | chpasswd

if [ ! -f /var/lib/dbconfig-common/sqlite3/roundcube/roundcube ]; then
    zcat /rcdb.gz > /var/lib/dbconfig-common/sqlite3/roundcube/roundcube
    chown www-data.www-data /var/lib/dbconfig-common/sqlite3/roundcube
    chmod ug+rwx /var/lib/dbconfig-common/sqlite3/roundcube
    chmod o+rx /var/lib/dbconfig-common/sqlite3/roundcube
    chown www-data.www-data /var/lib/dbconfig-common/sqlite3/roundcube/roundcube
    chmod ug+rw /var/lib/dbconfig-common/sqlite3/roundcube/roundcube
fi

if grep -q XXXDESKEYXXX /etc/roundcube/config.inc.php; then
    KEY=`dd if=/dev/urandom bs=1024 count=1 | base64 -w 0 | tr -d '=' | td -d| cut -c1-24`
    sed -i "s|XXXDESKEYXXX|$KEY|g" /etc/roundcube/config.inc.php
fi

exec apache2ctl -DFOREGROUND
