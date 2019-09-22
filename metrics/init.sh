#!/bin/bash
#

#confs
sudo mkdir -p /srv/confs/metrics-host

sudo cp -f docker-compose.yml /srv/confs/metrics-host/
sudo cp -f metricbeat.yml /srv/confs/metrics-host/
