#!/bin/bash
#

#confs
sudo mkdir -p /srv/confs/metrics-docker

sudo cp -f docker-compose.yml /srv/confs/metrics-docker/
sudo cp -f metricbeat.yml /srv/confs/metrics-docker/

curl -X GET http://yugo.moot.fr:8887/int.pem | sudo tee /srv/confs/metrics-docker/int.pem > /dev/null
curl -X GET http://yugo.moot.fr:8887/ca.pem | sudo tee /srv/confs/metrics-docker/ca.pem > /dev/null
