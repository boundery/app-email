ARG FROM_PREFIX

FROM ${FROM_PREFIX}python3

RUN    apt-get update \
    && apt-get install -y postfix postfix-sqlite postfix-pcre \
    && rm -rf /var/lib/apt/lists/*

COPY start.sh /
COPY master.cf main.cf /etc/postfix/

EXPOSE 25/tcp

CMD ["bash", "/start.sh"]
