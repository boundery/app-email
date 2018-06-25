spamassassin:
	docker build --build-arg FROM_PREFIX=arm32v7/ -t spamassassin ./spamassassin
CONTAINERS += spamassassin

dovecot:
	docker build --build-arg FROM_PREFIX=arm32v7/ -t dovecot ./dovecot
CONTAINERS += dovecot

postfix:
	docker build --build-arg FROM_PREFIX=arm32v7/ -t postfix ./postfix
CONTAINERS += postfix

PHONY += $(CONTAINERS)

PHONY += all
all: $(CONTAINERS)

#XXX Remove the -0 from xz when things are stable.
PHONY += deploy
deploy: $(CONTAINERS)
	@test $(SERVER)
	docker save $? | xz -0 | pv -W | ssh root@$(SERVER) 'cat>data/sslnginx/html/apps/email.tar.xz'
	scp startemail root@$(SERVER):~/data/sslnginx/html/apps/

.PHONY: $(PHONY)
