#!/bin/bash
#

if [ "$@" != "" ]; then 
	exec "$@"
else
	# Run in foreground and log to STDERR (console):
	/usr/sbin/named -u named -g
fi


