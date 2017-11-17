NAME = poppypop/aria2-webui
VERSION = latest

.PHONY: all build run shell

all: build

build:
	git clone https://github.com/ziahamza/webui-aria2.git
	docker build -t $(NAME):$(VERSION) --rm .
	rm -rf webui-aria2

run:
	docker run -ti --rm $(NAME):$(VERSION)
	
shell:
	docker run -ti --rm $(NAME):$(VERSION) /bin/sh