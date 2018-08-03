#ARCH=amd64
ARCH=arm32v7

spamassassin:
	docker build --build-arg FROM_PREFIX=$(ARCH)/ -t $(ARCH)/email-spamassassin ./spamassassin
CONTAINERS += spamassassin

dovecot:
	docker build --build-arg FROM_PREFIX=$(ARCH)/ -t $(ARCH)/email-dovecot ./dovecot
CONTAINERS += dovecot

postfix:
	docker build --build-arg FROM_PREFIX=$(ARCH)/ -t $(ARCH)/email-postfix ./postfix
CONTAINERS += postfix

PHONY += $(CONTAINERS)

PHONY += all
all: $(CONTAINERS)

PHONY += deploy
deploy: $(CONTAINERS)
	@test $(SERVER)
	@for i in $?; do \
	  docker tag $(ARCH)/email-$$i localhost:5000/$(ARCH)/email-$$i ; \
	  docker push localhost:5000/$(ARCH)/email-$$i ; \
	done
	scp email.json root@$(SERVER):~/data/sslnginx/html/apps/

.PHONY: $(PHONY)
