NAME = poppypop/go-automated-ended
VERSION = latest

.PHONY: all build openldap fd

all: build

build: openldap fd

openldap:
	make -C openldap
	
fd:
	make -C fusiondirectory
	
