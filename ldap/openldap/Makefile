NAME = poppypop/ldap
VERSION = latest

.PHONY: all build run shell

all: build

build:
	docker build -t $(NAME):$(VERSION) --rm -f Dockerfile.alpine  .
	
run:
	docker run -ti --rm -v openldap-data:/var/lib/openldap/openldap-data -v /etc/ssl/private:/etc/ssl/private:ro -p 389:389 -p 636:636 --name ldap $(NAME):$(VERSION)
	
shell:
	docker run -ti --rm -v openldap-data:/var/lib/openldap/openldap-data -v /etc/ssl/private:/etc/ssl/private:ro -p 389:389 -p 636:636 --name ldap $(NAME):$(VERSION) /bin/sh