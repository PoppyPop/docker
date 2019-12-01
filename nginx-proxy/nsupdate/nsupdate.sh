#!/bin/sh
#

export TS=$(date +"%s")

envsubst < /tmp/nsupdate.raw > /tmp/nsupdate.final

nsupdate -y ${NSKEY} -v /tmp/nsupdate.final
