#!/bin/bash
#

#if [ -f "/srv/backs/$1"


docker run -it --rm -v $1:/volume -v /srv/backs:/srv/backs alpine \
    sh -c "rm -rf /volume/* ; tar -C /volume/ -xjf $2"
