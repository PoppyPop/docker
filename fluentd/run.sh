#!/bin/bash
#

cd /srv/docker/fluentd &>/dev/null

docker run -d --restart=always -v "$PWD":/etc/fluent -p 24224:24224 --link myelastic:elasticsearch --name myfluentd poppypop/fluentd

#debug
#docker run -ti --rm -v /srv/docker/fluentd:/etc/fluent -p 24224:24224 --link myelastic:elasticsearch --name myfluentd poppypop/fluentd

cd - &>/dev/null