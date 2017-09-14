#!/bin/bash
#

sudo apt-get install golang-go

sudo go get github.com/ovh/go-ovh/ovh

#conf
sudo mkdir -p /srv/ddns/

sudo cp -f cloudflare-update-record.sh /srv/ddns/
sudo cp -f ovh.go /srv/ddns/
sudo cp -f update-dns.sh /srv/ddns/

sudo cp -f ipupdate /etc/cron.hourly/


