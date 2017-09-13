FROM golang:1.9-alpine

RUN set -xe \
	&& apk update --no-cache && apk upgrade --no-cache \
	&& apk add --update --no-cache git nfs-utils rpcbind \
	&& rm -rf /var/cache/apk/*

VOLUME /downloads
VOLUME /ended
VOLUME /extract
VOLUME /nfs

WORKDIR /go/src/app
COPY ./src/ .

RUN go-wrapper download   # "go get -d -v ./..."
RUN go-wrapper install    # "go install -v ./..."

CMD ["go-wrapper", "run"] # ["app"]