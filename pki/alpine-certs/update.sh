#!/bin/sh
#

set -x

apk add --update ca-certificates curl

rm -rf /etc/ssl/certs/*

#alpine
mkdir -p /usr/local/share/ca-certificates/
curl -X GET http://pki.mo-ot.fr:8887/int.pem | tee /usr/local/share/ca-certificates/Moot.fr_INT.pem  > /dev/null
curl -X GET http://pki.mo-ot.fr:8887/ca.pem | tee /usr/local/share/ca-certificates/Moot.fr_CA.pem  > /dev/null

update-ca-certificates

cd /etc/ssl/certs/ && for i in *; do link=$(readlink $i) && rm $i && cp $link $i; done

exit