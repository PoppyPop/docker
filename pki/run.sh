#!/bin/bash
#

docker run -ti --rm -v /srv/datas/pki:/usr/share/easy-rsa/pki --name pki poppypop/pki $1