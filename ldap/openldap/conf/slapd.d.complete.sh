#!/bin/sh
#

for line in $(find /etc/openldap/slapd.d -type f -iname "*.ldif"); do
   line=${line%.ldif}
   if [ ! -d $line ] 
   then
      mkdir -p $line
   fi
done


