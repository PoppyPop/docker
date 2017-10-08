#!/bin/sh
#

# Sign
EASYRSA_PKI=pki/sign ./easyrsa build-server-full $1 nopass

#Publish
mkdir -p pki/publish/server/$1

cp pki/sign/issued/$1.crt pki/publish/server/$1/
cp pki/sign/private/$1.key pki/publish/server/$1/
cp pki/sign/ca.crt pki/publish/server/$1/

openssl pkcs12 -export -out pki/publish/server/$1/$1.p12 -inkey pki/publish/server/$1/$1.key -in pki/publish/server/$1/$1.crt -certfile pki/publish/server/$1/ca.crt -passout pass:
