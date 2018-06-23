#!/bin/sh

useradd $USERNAME

#XXX Tighten up inet_interfaces in main.cf, so we only listen on the public v4/6 addresses.
echo "$DOMAINNAME" > /etc/mailname
sed -i -e "s/XXXHOSTNAMEXXX/$HOSTNAME/g" -e "s/XXXDOMAINNAMEXXX/$DOMAINNAME/g" /etc/postfix/main.cf

#XXX /etc/aliases root->user

/etc/init.d/postfix start
#XXX Find a better way to wait for 'master'. wait only waits for children of current shell...
while true; do sleep 3600; done

