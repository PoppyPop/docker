#!/bin/bash
#

docker volume create kea-pgsql --label backup=yes
docker volume create kea-conf