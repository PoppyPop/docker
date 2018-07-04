docker run -ti --rm \
   -v /var/run/docker.sock:/tmp/docker.sock:ro \
   -v ${PWD}:/templates \
   -l fluentd-tag=nginx \
   -t jwilder/docker-gen -watch /templates/docker-log.tmpl /templates/docker.conf