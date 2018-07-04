#!/bin/sh
#

set -x

apt-get update && apt-get -y install ca-certificates curl

rm -rf /etc/ssl/certs/*

BASEDIR=/usr/local/share/ca-certificates
#BASEDIR=/usr/share/ca-certificates/extra

#debian
mkdir ${BASEDIR}
curl -X GET http://pki.mo-ot.fr:8887/int.pem | tee ${BASEDIR}/Moot.fr_INT.pem  > /dev/null
curl -X GET http://pki.mo-ot.fr:8887/ca.pem | tee ${BASEDIR}/Moot.fr_CA.pem  > /dev/null

openssl x509 -in ${BASEDIR}/Moot.fr_INT.pem -inform PEM -out ${BASEDIR}/Moot.fr_INT.crt 
openssl x509 -in ${BASEDIR}/Moot.fr_CA.pem -inform PEM -out ${BASEDIR}/Moot.fr_CA.crt 

#dpkg-reconfigure ca-certificates
update-ca-certificates -f

cd /etc/ssl/certs/ && for i in *; do link=$(readlink $i) && rm $i && cp $link $i; done

exit