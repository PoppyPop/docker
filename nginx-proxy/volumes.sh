#!/bin/bash
#

#datas
docker volume create certs --label backup=yes

docker volume create letsencrypt --label backup=yes

docker volume create ngproxy-tmpl

docker volume create ngproxy-vhost
