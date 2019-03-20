#!/bin/sh

useradd $USERNAME

#XXX Tighten up inet_interfaces in main.cf, so we only listen on the public v4/6 addresses.
echo "$DOMAINNAME" > /etc/mailname
sed -i -e "s/XXXHOSTNAMEXXX/$HOSTNAME/g" -e "s/XXXDOMAINNAMEXXX/$DOMAINNAME/g" /etc/postfix/main.cf
if [ -n "$SMTP" ]; then
    cp /etc/postfix/master.cf.smtp /etc/postfix/master.cf
elif [ -n "$SUBMISSION" ]; then
    cp /etc/postfix/master.cf.submission /etc/postfix/master.cf
else
    echo "Neither SMTP nor SUBMISSION is set!" >&2
    exit 99
fi

#XXX /etc/aliases root->user

/etc/init.d/postfix start
#XXX Find a better way to wait for 'master'. wait only waits for children of current shell...
while true; do sleep 3600; done

