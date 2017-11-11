FROM alpine:3.4

ENV LDAPTLS_CACERT=/etc/ssl/certs/ca-certificates.crt

RUN set -xe && \
	apk update --no-cache && apk upgrade --no-cache && \
	apk add --update --no-cache krb5-server-ldap krb5-server krb5 krb5-conf openldap-clients openssl ca-certificates && \
	wget -O /usr/local/share/ca-certificates/ca.crt http://yugo.moot/ca.crt && \
	update-ca-certificates && \
	mkdir /etc/krb5kdc && \
	rm -rf /var/cache/apk/*
	
ADD krb5.conf /etc/krb5.conf
	
ENTRYPOINT ["/bin/sh"]
