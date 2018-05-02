#!/bin/sh
#

curl -X GET http://yugo.moot.fr:8887/ca.pem > ca.pem
curl -X GET http://yugo.moot.fr:8887/int.pem > int.pem

openssl x509 -outform der -in ca.pem -out ca.crt
openssl x509 -outform der -in int.pem -out int.crt

update-ca-certificates

#curl -d '{}' -X POST http://yugo.moot.fr:8888/api/v1/cfssl/info | jq -r ".result.certificate" > int.pem
