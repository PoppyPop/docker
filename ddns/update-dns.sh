#!/bin/bash
#

cd /srv/ddns/

./cloudflare-update-record.sh

./ovh-update-record -ak=... -as=... -ck=...
