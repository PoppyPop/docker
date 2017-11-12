#!/bin/bash
#

if [ ! -f config.json ] 
then
	OCSPKEY=$(hexdump -n 16 -e '4/4 "%08X" 1 "\n"' /dev/urandom)
	INTKEY=$(hexdump -n 16 -e '4/4 "%08X" 1 "\n"' /dev/urandom)
	DEFKEY=$(hexdump -n 16 -e '4/4 "%08X" 1 "\n"' /dev/urandom)
	
	cp config.json.sample config.json
	sed -i "s|{OCSPKEY}|${OCSPKEY}|g" config.json
	sed -i "s|{INTKEY}|${INTKEY}|g" config.json
	sed -i "s|{DEFKEY}|${DEFKEY}|g" config.json
	
	echo -e $"=========== CFSSL ==========="
	echo "OCSP          : ${OCSPKEY}" 
	echo "INTERMEDIATE  : ${INTKEY}"
	echo "DEFAULT       : ${DEFKEY}"
	echo -e $"=========== /CFSSL ==========="
else
	echo "config file already exist" 
fi