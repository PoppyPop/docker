FROM alpine:3.6

ENV EASYRSA_REQ_COUNTRY    "FR"
ENV EASYRSA_REQ_PROVINCE   "FR"
ENV EASYRSA_REQ_CITY       "Strasbourg"
ENV EASYRSA_REQ_ORG        "Moot"
ENV EASYRSA_REQ_EMAIL      "pki@moot"
ENV EASYRSA_REQ_OU         "Moot"

RUN set -xe \
	&& apk update --no-cache && apk upgrade --no-cache \
	&& apk add --update --no-cache easy-rsa \
	&& rm -rf /var/cache/apk/*
	
# RUN set -xe cd /usr/share/easy-rsa/ && ./easyrsa init-pki && ./easyrsa build-ca subca nopass
COPY utils/config.sh /usr/share/easy-rsa/config.sh
COPY utils/sign-client.sh /usr/share/easy-rsa/sign-client.sh
COPY utils/sign-server.sh /usr/share/easy-rsa/sign-server.sh
	
VOLUME /usr/share/easy-rsa/pki

WORKDIR /usr/share/easy-rsa/
	
ENTRYPOINT ["/bin/sh"]

