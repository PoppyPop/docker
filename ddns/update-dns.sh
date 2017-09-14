#!/bin/bash
#

cd /srv/ddns/

./cloudflare-update-record.sh

go run ovh.go
