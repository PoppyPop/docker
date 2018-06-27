#!/bin/bash
#

FILE=env/ddns.env

if [ ! -f $FILE ] 
then
	echo -n "Enter domain: "
	read DOMAIN

	echo -n "Enter subdomain: "
	read SUBDOMAIN
	
	echo -n "Enter sleep between check: "
	read SLEEPD
	
	echo "DDNS_DOMAIN=$DOMAIN" > $FILE
	echo "DDNS_SUBDOMAIN=$SUBDOMAIN" >> $FILE
	echo "DDNS_SLEEP=$SLEEPD" >> $FILE

	echo -n "Do you want to use CloudFlare ?"
	select yn in "Yes" "No"; do
		case $yn in
			Yes ) USE_CF=1; break;;
			No ) break;;
		esac
	done
	
	if [ "$USE_CF" == "1" ]; then
		echo -n "Enter CF mail: "
		read CFMAIL

		echo -n "Enter CF key: "
		read CFKEY
		
		echo "CF_MAIL=$CFMAIL" >> $FILE
		echo "CF_KEY=$CFKEY" >> $FILE
	fi
	
	echo -n "Do you want to use OVH ?"
	select yn in "Yes" "No"; do
		case $yn in
			Yes ) USE_OVH=1; break;;
			No ) break;;
		esac
	done
		
	if [ "$USE_OVH" == "1" ]; then
		echo -n "Enter CF mail: "
		read OVH_AK

		echo -n "Enter CF key: "
		read OVH_AS
		
		echo -n "Enter CF key: "
		read OVH_CK
		
		echo "OVH_AK=$OVH_AK" >> $FILE
		echo "OVH_AS=$OVH_AS" >> $FILE
		echo "OVH_CK=$OVH_CK" >> $FILE
	fi	
		
else
	echo "config file already exist" 
fi
