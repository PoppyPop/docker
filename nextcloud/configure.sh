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
	HOST="postgres"
	
	read -p "Creating BDD min config please enter postgres password: " PGPASSWORD
	export PGPASSWORD
	psql -U postgres -h yugo.mo-ot.fr -w -tc "SELECT 1 FROM pg_catalog.pg_database WHERE datname = '${BASE}'" | grep -q 1 || psql -U postgres -h yugo.mo-ot.fr -w -c "CREATE DATABASE ${BASE}"
	psql -U postgres -h yugo.mo-ot.fr -w -tc "SELECT 1 FROM pg_catalog.pg_roles WHERE rolname = '${USER}'" | grep -q 1 || psql -U postgres -h yugo.mo-ot.fr -w -c "CREATE ROLE ${USER} LOGIN PASSWORD '${PASSCONFIG}'"
	psql -U postgres -h yugo.mo-ot.fr -w -c "GRANT ALL PRIVILEGES ON DATABASE ${BASE} to ${USER}"
	
	
	cp conf-sample/db.env.sample env/db.env
	sed -i "s|{BASE}|${BASE}|g" env/db.env
	sed -i "s|{USER}|${USER}|g" env/db.env
	sed -i "s|{PASSCONFIG}|${PASSCONFIG}|g" env/db.env
	sed -i "s|{NUSER}|${NUSER}|g" env/db.env
	sed -i "s|{PASSNEXT}|${PASSNEXT}|g" env/db.env
	sed -i "s|{HOST}|${HOST}|g" env/db.env
	
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
