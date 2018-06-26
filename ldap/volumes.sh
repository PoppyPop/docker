#!/bin/bash
#

#datas
docker volume create openldap-config --label backup=yes
docker volume create openldap-data --label backup=yes
docker volume create openldap-certs --label backup=yes

docker volume create fusiond-config