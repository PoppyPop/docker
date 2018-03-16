#!/bin/bash
#

#if [ -f "/srv/backs/$1"


docker run -it -v $1:/volume -v /srv/backs:/srv/backs alpine \
    sh -c "rm -rf /volume/* ; tar -C /volume/ -xjf $2"
