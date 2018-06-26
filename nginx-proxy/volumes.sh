#!/bin/bash
#

#datas
docker volume create certs --label backup=yes

docker volume create ngproxy-tmpl
