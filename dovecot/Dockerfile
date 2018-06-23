ARG FROM_PREFIX

FROM ${FROM_PREFIX}python3

RUN    apt-get update \
    && apt-get install -y dovecot-sqlite dovecot-sieve dovecot-imapd dovecot-lmtpd \
    && rm -rf /var/lib/apt/lists/*

COPY start.sh /
COPY 10-mail.conf 10-ssl.conf 10-auth.conf 10-master.conf 20-lmtp.conf /etc/dovecot/conf.d/

EXPOSE 993/tcp

CMD ["bash", "/start.sh"]
