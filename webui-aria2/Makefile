NAME = poppypop/go-automated-ended
VERSION = latest

.PHONY: all build go-automate-ended

all: build

build: go-automate-ended

go-automate-ended:
	make -C go-automate-ended build
	
run:
	docker run -ti --rm -v aria-downloads:/downloads -p 6800:6800 $(NAME):$(VERSION)
	
shell:
	docker run -ti --rm -v aria-downloads:/downloads -p 6800:6800 $(NAME):$(VERSION) /bin/sh