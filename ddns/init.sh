#!/bin/bash
#

sudo apt-get install golang-go

#conf
sudo mkdir -p /srv/ddns/

sudo cp -f cloudflare-update-record.sh /srv/ddns/
sudo cp -f ovh /srv/ddns/ovh-update-record
sudo cp -f update-dns.sh /srv/ddns/

sudo cp -f ipupdate /etc/cron.hourly/


