#!/bin/bash
#

docker run  \
  --rm \
  --name=filebeat \
  --user=root \
  --network=efk-net \
  -v es-certs:/certs \
  --volume="$(pwd)/filebeat.docker.yml:/usr/share/filebeat/filebeat.yml:ro" \
  --volume="/var/lib/docker/containers:/var/lib/docker/containers:ro" \
  --volume="/var/run/docker.sock:/var/run/docker.sock:ro" \
  docker.elastic.co/beats/filebeat:7.3.0 filebeat -e -strict.perms=false \
  -E output.elasticsearch.hosts=["elastic1:9200"] \
  -E output.elasticsearch.protocol=https \
  -E output.elasticsearch.username="Filebeat" \
  -E output.elasticsearch.password="Pk7r2TP5p7owA3" \
  -E output.elasticsearch.ssl.certificate_authorities=["/certs/ca/ca.crt"]
