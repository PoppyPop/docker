#!/bin/sh
#

curl -d '{}' -X POST http://yugo.moot:8888/api/v1/cfssl/info | jq -r ".result.certificate" > ca.pem
