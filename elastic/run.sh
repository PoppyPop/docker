#!/bin/bash
#

cd /srv/docker/elastic &>/dev/null

sudo docker run -d --restart=always -v "$PWD/data":/usr/share/elasticsearch/data -p 9200:9200 -p 9300:9300 --name myelastic elasticsearch

cd - &>/dev/null