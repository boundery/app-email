#!/bin/sh

#XXX This should authenticate against the host, or maybe an auth container.
#XXX Until then, move this useradd to the Dockerfile.
useradd -m $USERNAME
echo $USERNAME:prjx321 | chpasswd

#XXX This should use Let's Encrypt.
openssl req -x509 -nodes -days 3650 -newkey rsa:2048 \
        -out /etc/dovecot/dovecot.pem -keyout /etc/dovecot/private/dovecot.pem \
        -subj "/C=US/ST=CA/L=CA/O=none/OU=none/CN=$DOMAINNAME/emailAddress=postmaster@$DOMAINNAME"

LMTPIP=`ip -o addr show to $spam_dove_SUBNET | cut -d'/' -f1 | cut -d' ' -f7`
echo $LMTPIP
sed -i -e "s/XXXLMTPIPXXX/$LMTPIP/g" /etc/dovecot/conf.d/10-master.conf

/usr/sbin/dovecot -F -c /etc/dovecot/dovecot.conf
