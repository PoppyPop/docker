#!/bin/bash
#

docker run -ti -rm -v /srv/docker/efk/elastic:/usr/share/elasticsearch/data -p 9200:9200 -p 9300:9300 --name myelastic elasticsearch