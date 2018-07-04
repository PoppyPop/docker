#!/bin/bash
#

#confs
sudo mkdir -p /srv/confs/metrics-host

sudo cp -f docker-compose.yml /srv/confs/metrics-host/
sudo cp -f metricbeat.yml /srv/confs/metrics-host/

curl -X GET http://yugo.mo-ot.fr:8887/int.pem | sudo tee /srv/confs/metrics-host/int.pem > /dev/null
curl -X GET http://yugo.mo-ot.fr:8887/ca.pem | sudo tee /srv/confs/metrics-host/ca.pem > /dev/null
