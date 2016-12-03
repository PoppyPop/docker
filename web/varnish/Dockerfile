FROM alpine:latest
ENV REFRESHED_AT 2016-12-03

RUN set -xe \
	&& apk update --no-cache && apk upgrade --no-cache \
	&& apk add --no-cache --update --no-progress bash varnish \
	&& rm -rf /var/cache/apk/*

ENV VARNISH_BACKEND_PORT 80
ENV VARNISH_BACKEND_IP 172.17.42.1
ENV VARNISH_PORT 80

VOLUME ["/var/lib/varnish", "/etc/varnish"]

EXPOSE 80

ADD varnish.sh /varnish.sh
CMD ["/varnish.sh"]