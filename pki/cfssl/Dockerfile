FROM cfssl/cfssl

RUN set -x && \
	apk --no-cache --update add ca-certificates

ADD config.json /etc/cfssl/config.json
ADD db-config.json /etc/cfssl/db-config.json
ADD certstore.db /etc/cfssl/certstore.db

ADD ca.json /etc/cfssl/ca.json
ADD intermediate.json /etc/cfssl/intermediate.json
ADD ocsp.json /etc/cfssl/ocsp.json

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

