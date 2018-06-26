#!/bin/bash
#

if [ ! -f conf/config.json ] 
then
	OCSPKEY=$(hexdump -n 16 -e '4/4 "%08X" 1 "\n"' /dev/urandom)
	INTKEY=$(hexdump -n 16 -e '4/4 "%08X" 1 "\n"' /dev/urandom)
	DEFKEY=$(hexdump -n 16 -e '4/4 "%08X" 1 "\n"' /dev/urandom)
	
	cp conf-sample/config.json.sample conf/config.json
	sed -i "s|{OCSPKEY}|${OCSPKEY}|g" conf/config.json
	sed -i "s|{INTKEY}|${INTKEY}|g" conf/config.json
	sed -i "s|{DEFKEY}|${DEFKEY}|g" conf/config.json
	
	echo -e $"=========== CFSSL ==========="
	echo "OCSP          : ${OCSPKEY}" 
	echo "INTERMEDIATE  : ${INTKEY}"
	echo "DEFAULT       : ${DEFKEY}"
	echo -e $"=========== /CFSSL ==========="
else
	echo "config file already exist" 
fi