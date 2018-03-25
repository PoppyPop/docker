FROM cfssl/cfssl

RUN set -x && \
	apk --no-cache --update add ca-certificates

ADD conf/config.json /etc/cfssl/config.json
ADD conf/db-config.json /etc/cfssl/db-config.json
ADD conf/ca.json /etc/cfssl/ca.json
ADD conf/intermediate.json /etc/cfssl/intermediate.json
ADD conf/ocsp.json /etc/cfssl/ocsp.json

ADD entrypoint.sh /entrypoint.sh
ADD certstore.db /etc/cfssl/certstore.db

ENTRYPOINT ["/entrypoint.sh"]

