#!/bin/sh
#

set -x

apt-get update && apt-get -y install ca-certificates curl

rm -rf /etc/ssl/certs/*

BASEDIR=/usr/local/share/ca-certificates
#BASEDIR=/usr/share/ca-certificates/extra

#debian
mkdir ${BASEDIR}
curl -X GET http://pki.mo-ot.fr:8887/int.crt | tee ${BASEDIR}/Mo-ot.fr_INT.crt  > /dev/null
curl -X GET http://pki.mo-ot.fr:8887/ca.crt | tee ${BASEDIR}/Mo-ot.fr_CA.crt  > /dev/null

#dpkg-reconfigure ca-certificates
update-ca-certificates -f

cd /etc/ssl/certs/ && for i in *; do link=$(readlink $i) && rm $i && cp $link $i; done

exit