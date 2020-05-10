#!/bin/bash
#

#datas
docker volume create letsencrypt --label backup=yes

docker volume create ngproxy-tmpl

docker volume create ngproxy-vhost

docker volume create nsupdate-tmpl

docker volume create adguard-tmpl
