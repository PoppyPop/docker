#!/bin/bash
#

docker run -ti --rm -v /srv/docker/efk/fluentd:/etc/fluent -p 24224:24224 --link myelastic:elasticsearch --name myfluentd poppypop/fluentd