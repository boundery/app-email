#!/bin/sh

PF_IP=`ip -o addr show to $post-spam_SUBNET | cut -d'/' -f1 | cut -d' ' -f7`
spampd --host=$PF_IP:24 --relayhost=email-dovecot:24 \
       --children=2 --nodetach --maxsize=65535 --tagall
