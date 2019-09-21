#!/bin/bash
#


fqdnhost=`sudo grep -c ".mo-ot.fr" /etc/hostname`

if [ "$fqdnhost" -eq "0" ]
then
   host=$(cat /etc/hostname | tr -d "\n")
   echo "$host.mo-ot.fr
" | sudo tee /etc/hostname > /dev/null
   sudo hostname "$host.mo-ot.fr"
   echo "127.0.0.1	$host.mo-ot.fr" | sudo tee -a /etc/hosts
fi