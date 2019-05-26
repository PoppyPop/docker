#!/bin/bash
#

docker run -it --rm -v fluentd-conf:/volume -v ${PWD}/fluentd:/orig alpine \
    sh -c "rm -rf /volume/* ; cp -fa /orig/fluent.conf /volume/ ; cp -fa /orig/docker-log.tmpl /volume/ ; touch /volume/docker-log.conf"