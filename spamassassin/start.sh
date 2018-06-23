#!/bin/sh

PF_IP=`ip -o addr | grep -Eo $PF_SUBNET.[0-9]+`
spampd --host=$PF_IP:24 --relayhost=dovecot:24 \
       --children=2 --nodetach --maxsize=65535 --tagall
