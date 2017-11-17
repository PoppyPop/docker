NAME = poppypop/go-automated-ended
VERSION = latest

.PHONY: all build run shell

all: build

build:	
	docker build -t $(NAME):$(VERSION) --rm .

run:
	docker run -ti --rm -v /downloads/aria2/Downloads:/downloads -v /downloads/aria2/Ended:/ended -v /downloads/aria2/Extract:/extract $(NAME):$(VERSION)
	
shell:
	docker run -ti --rm -v /downloads/aria2/Downloads:/downloads -v /downloads/aria2/Ended:/ended -v /downloads/aria2/Extract:/extract $(NAME):$(VERSION) /bin/sh