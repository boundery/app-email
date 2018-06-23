ARG FROM_PREFIX

FROM ${FROM_PREFIX}python3

RUN    apt-get update \
    && apt-get install -y spampd pyzor razor \
    && rm -rf /var/lib/apt/lists/*

COPY start.sh /
#COPY local.cf /etc/spamassassin/

CMD ["bash", "/start.sh"]
