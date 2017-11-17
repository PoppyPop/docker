NAME = poppypop/go-automated-ended
VERSION = latest

.PHONY: all build go-automate-ended webui aria2

all: build

build: go-automate-ended webui aria2

go-automate-ended:
	make -C go-automate-ended build
	
webui:
	make -C webui build
	
aria2:
	git clone https://github.com/PoppyPop/aria2-alpine.git
	make -C aria2-alpine build
	rm -rf aria2-alpine

run:
	docker run -ti --rm -v aria-downloads:/downloads -p 6800:6800 $(NAME):$(VERSION)
	
shell:
	docker run -ti --rm -v aria-downloads:/downloads -p 6800:6800 $(NAME):$(VERSION) /bin/sh