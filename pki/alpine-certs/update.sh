#!/bin/sh
#

set -x

apk add --update ca-certificates curl

#alpine
mkdir -p /usr/local/share/ca-certificates/
curl -X GET http://yugo.moot.fr:8887/int.pem | tee /usr/local/share/ca-certificates/int.pem  > /dev/null
curl -X GET http://yugo.moot.fr:8887/ca.pem | tee /usr/local/share/ca-certificates/ca.pem  > /dev/null

update-ca-certificates

exit