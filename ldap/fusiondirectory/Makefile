NAME = poppypop/fusiond
VERSION = latest

.PHONY: all build run shell

all: build

build:
	docker build -t $(NAME):$(VERSION) --rm .
	
run:
	docker run -ti --rm --name fusiond -p 12080:80 $(NAME):$(VERSION)
	
shell:
	docker run -ti --rm --name fusiond -p 12080:80 $(NAME):$(VERSION) /bin/sh