NAME = poppypop/ldap
VERSION = latest

.PHONY: all build openldap fd cleandata

all: build

build: openldap fd

openldap:
	make -C openldap
	
fd:
	make -C fusiondirectory
	
cleandata:
	docker run -it --rm -v openldap-data:/volume alpine  sh -c "rm -rf /volume/*"
	
