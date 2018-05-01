FROM golang:1.9-alpine as builder

RUN set -xe \
	&& apk update --no-cache && apk upgrade --no-cache \
	&& apk add --update --no-cache git \
	&& rm -rf /var/cache/apk/*

WORKDIR /go/src/github.com/PoppyPop/docker/webui-aria2/go-automate-ended
COPY ./src/ .

RUN go get -d -v ./...   
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o go-automate-ended .


FROM alpine:latest  
RUN apk add --no-cache --update jq ca-certificates unrar curl && \
     mkdir -p /usr/local/share/ca-certificates/ && \
	 curl -d '{}' -X POST http://yugo.moot.fr:8888/api/v1/cfssl/info | jq -r ".result.certificate" > /usr/local/share/ca-certificates/int.pem && \
	 curl -X GET http://yugo.moot.fr:8887/ca.pem > /usr/local/share/ca-certificates/ca.pem && \
     update-ca-certificates

VOLUME /datas

WORKDIR /app/
COPY --from=builder /go/src/github.com/PoppyPop/docker/webui-aria2/go-automate-ended/go-automate-ended .
CMD ["/app/go-automate-ended"] 