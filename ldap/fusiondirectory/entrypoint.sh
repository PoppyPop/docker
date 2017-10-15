#!/bin/bash
#

chmod 640 /etc/fusiondirectory/fusiondirectory.conf
chown root:www-data /etc/fusiondirectory/fusiondirectory.conf

yes Yes | fusiondirectory-setup --check-config
yes Yes | fusiondirectory-setup --check-config

rm -f /var/run/apache2/apache2.pid

/usr/sbin/apachectl -DFOREGROUND