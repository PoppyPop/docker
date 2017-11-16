#!/bin/bash
#

if [ ! -f container/conf/config.json ] 
then
	OCSPKEY=$(hexdump -n 16 -e '4/4 "%08X" 1 "\n"' /dev/urandom)
	INTKEY=$(hexdump -n 16 -e '4/4 "%08X" 1 "\n"' /dev/urandom)
	DEFKEY=$(hexdump -n 16 -e '4/4 "%08X" 1 "\n"' /dev/urandom)
	
	cp container/conf/config.json.sample container/conf/config.json
	sed -i "s|{OCSPKEY}|${OCSPKEY}|g" container/conf/config.json
	sed -i "s|{INTKEY}|${INTKEY}|g" container/conf/config.json
	sed -i "s|{DEFKEY}|${DEFKEY}|g" container/conf/config.json
	
	echo -e $"=========== CFSSL ==========="
	echo "OCSP          : ${OCSPKEY}" 
	echo "INTERMEDIATE  : ${INTKEY}"
	echo "DEFAULT       : ${DEFKEY}"
	echo -e $"=========== /CFSSL ==========="
else
	echo "config file already exist" 
fi