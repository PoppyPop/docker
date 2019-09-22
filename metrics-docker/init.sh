#!/bin/bash
#

#confs
sudo mkdir -p /srv/confs/metrics-docker

sudo cp -f docker-compose.yml /srv/confs/metrics-docker/
sudo cp -f metricbeat.yml /srv/confs/metrics-docker/
