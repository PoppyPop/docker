#!/bin/bash
#

sudo mkdir /usr/share/ca-certificates/extra

curl http://yugo.moot:8887/ca.pem > ca.pem

openssl x509 -in ca.pem -inform PEM -out ca.crt

sudo cp ca.crt /usr/share/ca-certificates/extra/

rm ca.pem ca.crt

sudo dpkg-reconfigure ca-certificates