#!/bin/sh
#

curl -X GET http://yugo.moot.fr:8887/ca.pem > ca.pem
curl -d '{}' -X POST http://yugo.moot.fr:8888/api/v1/cfssl/info | jq -r ".result.certificate" > int.pem
