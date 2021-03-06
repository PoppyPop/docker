#!/bin/bash
#

sudo cp -f conf/* /srv/confs/efk/

sudo cp -f Filebeat/filebeat.docker.yml /srv/confs/efk/

docker run -it --rm -v fluentd-conf:/volume -v ${PWD}/fluentd:/orig alpine \
    sh -c "rm -rf /volume/* ; cp -fa /orig/fluent.conf /volume/ ; cp -fa /orig/docker-log.tmpl /volume/ ; touch /volume/docker-log.conf"