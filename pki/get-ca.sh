#!/bin/sh
#

curl -X GET http://yugo.mo-ot.fr:8887/ca.pem > ca.pem
curl -X GET http://yugo.mo-ot.fr:8887/int.pem > int.pem

openssl x509 -outform der -in ca.pem -out ca.crt
openssl x509 -outform der -in int.pem -out int.crt

update-ca-certificates

#curl -d '{}' -X POST http://yugo.mo-ot.fr:8888/api/v1/cfssl/info | jq -r ".result.certificate" > int.pem

#alpine
sudo mkdir -p /usr/local/share/ca-certificates/
curl -X GET http://yugo.mo-ot.fr:8887/int.pem | sudo tee /usr/local/share/ca-certificates/int.pem  > /dev/null
curl -X GET http://yugo.mo-ot.fr:8887/ca.pem | sudo tee /usr/local/share/ca-certificates/ca.pem  > /dev/null

sudo update-ca-certificates

#ubuntu
export BASEDIR=/usr/local/share/ca-certificates

sudo mkdir ${BASEDIR}
curl -X GET http://pki.mo-ot.fr:8887/int.pem | sudo tee ${BASEDIR}/Moot.fr_INT.pem  > /dev/null
curl -X GET http://pki.mo-ot.fr:8887/ca.pem | sudo tee ${BASEDIR}/Moot.fr_CA.pem  > /dev/null

sudo openssl x509 -in ${BASEDIR}/Moot.fr_INT.pem -inform PEM -out ${BASEDIR}/Moot.fr_INT.crt 
sudo openssl x509 -in ${BASEDIR}/Moot.fr_CA.pem -inform PEM -out ${BASEDIR}/Moot.fr_CA.crt 

sudo update-ca-certificates