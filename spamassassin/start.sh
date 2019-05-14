#!/bin/sh

#XXX cannot create tmp lockfile /var/cache/spampd/bayes.lock.spamassassin.12 for /var/cache/spampd/bayes.lock: Permission denied

PF_IP=`ip -o addr show to ${post_spam_SUBNET} | cut -d'/' -f1 | cut -d' ' -f7`
echo $PF_IP
spampd --host=$PF_IP:24 --relayhost=email-dovecot:24 \
       --children=2 --nodetach --maxsize=65535 --tagall
