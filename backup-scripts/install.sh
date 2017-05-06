#!/bin/bash
#

sudo mkdir -p /srv/scripts

sudo cp -rf scripts/* /srv/scripts/

sudo cp -rf cron.daily/* /etc/cron.daily/
