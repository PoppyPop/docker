#!/bin/sh
#

trap "break;exit" SIGHUP SIGINT SIGTERM

# TZ setup
apk add --update --no-cache tzdata
cp /usr/share/zoneinfo/Europe/Paris /etc/localtime

mkdir -p /config/data
chown 999:44 /config/data

while true; do
  CURDATE="$(date +"%Y-%m-%d") $(nmeter -d0 '%3t' | head -n1)"
  echo "${CURDATE} [   INFO] Executing Cron"
  
  rm /config/data/xmltv.xml
  #wget -qO- http://racacaxtv.ga/alacarte/xmlgz.php?key=3db857d80f8206c655779b51b4f5dc35 | gunzip -c > /config/data/xmltv.xml
  wget -qO /config/data/xmltv.xml http://www.xmltv.fr/guide/tvguide.xml
  chown 999:44 /config/data/xmltv.xml
  sleep 2d
done