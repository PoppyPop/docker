#!/bin/bash
#

find /srv/confs/ -name docker-compose.yml -exec bash -c 'sudo systemctl enable docker-compose@$(basename $(dirname {}))'  \;