#!/bin/bash
#
# NextCloud

if [ ! -f db.env ] 
then
	if [ "$1" = "" ]; then 
		PASSCONFIG=$(openssl rand -base64 12)
	else
		PASSCONFIG=$1
	fi
	
	if [ "$2" = "" ]; then 
		PASSNEXT=$(openssl rand -base64 12)
	else
		PASSNEXT=$2
	fi
	
	BASE="nextcloud"
	USER="nextcloud"
	
	NUSER="admin"
	HOST="mariadb"
	
	echo -e "Creating BDD min config please enter root password"
	CREATE="CREATE DATABASE IF NOT EXISTS ${BASE};GRANT ALL ON ${BASE}.* TO ${USER}@'%' IDENTIFIED BY '${PASSCONFIG}';"
	#echo "$CREATE"
	mysql -h yugo.moot -u root -p -e "$CREATE"
	
	cp db.env.sample db.env
	sed -i "s|{BASE}|${BASE}|g" db.env
	sed -i "s|{USER}|${USER}|g" db.env
	sed -i "s|{PASSCONFIG}|${PASSCONFIG}|g" db.env
	sed -i "s|{NUSER}|${NUSER}|g" db.env
	sed -i "s|{PASSNEXT}|${PASSNEXT}|g" db.env
	sed -i "s|{HOST}|${HOST}|g" db.env
	
	echo -e $"=========== INFOS ==========="
	echo "base     : ${BASE}"
	echo "user     : ${USER}"
	echo "pass     : ${PASSCONFIG}"
	echo -e $"-----------------------------"
	echo "Next User     : ${NUSER}"
	echo "Next pass     : ${PASSNEXT}"
	echo -e $"=========== INFOS ==========="
else
	echo "config file already exist" 
fi
