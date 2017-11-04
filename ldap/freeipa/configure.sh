#!/bin/bash
#

if [ ! -f ipa-server-install-options ] 
then
	PASSCONFIG=$(openssl rand -base64 12)
	PASSDIR=$(openssl rand -base64 12)
	
	
	cp ipa-server-install-options.sample ipa-server-install-options
	sed -i "s|{PASSCONFIG}|${PASSCONFIG}|g" ipa-server-install-options
	sed -i "s|{PASSDIR}|${PASSDIR}|g" ipa-server-install-options
	
	echo -e $"=========== IPA ==========="
	echo "PASSCONFIG  : ${PASSCONFIG}"
	echo "PASSDIR     : ${PASSDIR}"
	echo -e $"=========== /IPA ==========="
else
	echo "config file already exist" 
fi