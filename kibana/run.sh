#!/bin/bash
#

cd /srv/docker/kibana &>/dev/null

sudo docker run --link myelastic:elasticsearch -p 5601:5601 -d --restart=always --name mykibana kibana

cd - &>/dev/null