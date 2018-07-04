#!/bin/bash
#

docker run -it --rm -v fluentd-conf:/volume -v ${PWD}:/orig alpine \
    sh -c "rm -rf /volume/* ; cp -fa /orig/fluentd.conf /volume/ ; cp -fa /orig/docker-log.tmpl /volume/ ; touch /volume/docker-log.conf"
	
docker run -it --rm -v fluentd_fluentd-logpos:/volume alpine \
    sh -c "rm -rf /volume/* "