NAME = poppypop/nextcloud
VERSION = latest

.PHONY: all build app web

all: build

build: app web

app:
	make -C app
	
web:
	make -C web build
