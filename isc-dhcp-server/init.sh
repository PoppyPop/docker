#!/bin/bash
#

sudo mkdir -p /srv/confs/dhcpd

sudo cp -f conf/dhcpd-single.conf /srv/confs/dhcpd/dhcpd.conf

sudo cp -f docker-compose.yml /srv/confs/dhcpd/

sudo touch /srv/confs/dhcpd/dhcpd.leases
sudo chown 1000:1000 /srv/confs/dhcpd/dhcpd.leases
sudo chmod g+w /srv/confs/dhcpd/dhcpd.leases