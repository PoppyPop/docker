#!/bin/sh
#

curl -X GET http://yugo.moot.fr:8887/ca.pem > ca.pem
curl -X GET http://yugo.moot.fr:8887/int.pem > int.pem

openssl x509 -outform der -in ca.pem -out ca.crt
openssl x509 -outform der -in int.pem -out int.crt

update-ca-certificates

#curl -d '{}' -X POST http://yugo.moot.fr:8888/api/v1/cfssl/info | jq -r ".result.certificate" > int.pem

#alpine
sudo mkdir -p /usr/local/share/ca-certificates/
curl -X GET http://yugo.moot.fr:8887/int.pem | sudo tee /usr/local/share/ca-certificates/int.pem  > /dev/null
curl -X GET http://yugo.moot.fr:8887/ca.pem | sudo tee /usr/local/share/ca-certificates/ca.pem  > /dev/null

sudo update-ca-certificates

#ubuntu
sudo mkdir /usr/share/ca-certificates/extra

curl -X GET http://yugo.moot.fr:8887/int.pem | sudo tee /usr/share/ca-certificates/extra/int.pem  > /dev/null
curl -X GET http://yugo.moot.fr:8887/ca.pem | sudo tee /usr/share/ca-certificates/extra/ca.pem  > /dev/null

sudo openssl x509 -in /usr/share/ca-certificates/extra/int.pem -inform PEM -out /usr/share/ca-certificates/extra/int.crt 
sudo openssl x509 -in /usr/share/ca-certificates/extra/ca.pem -inform PEM -out /usr/share/ca-certificates/extra/ca.crt 

sudo dpkg-reconfigure ca-certificates
sudo update-ca-certificates