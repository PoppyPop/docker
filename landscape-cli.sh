#!/bin/sh
#

sudo apt-get install landscape-client

sudo scp poppy@landscape-server:/etc/ssl/certs/landscape_server_ca.crt /etc/landscape/server.pem

sudo echo "ssl_public_key = /etc/landscape/server.pem" >> /etc/landscape/client.conf

sudo landscape-config --account-name standalone --url https://landscape-server/message-system --ping-url http://landscape-server/ping
