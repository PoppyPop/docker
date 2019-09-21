#!/bin/bash
#

# START SYNC 

SLAVENAME='pi1'
REMOTESERVER='pi1.mo-ot.fr'
REMOTEUSER='replication'

read -p "Mot de passe de replication:" REMOTEPASS
read -p "Mot de passe sql root local:" ROOTPASS

echo "STOP SLAVE '${SLAVENAME}'" | mysql -u root -p$ROOTPASS -h 127.0.0.1
echo "CHANGE MASTER 'pi1' TO MASTER_HOST='${REMOTESERVER}', MASTER_PORT=3306,MASTER_USER='${REMOTEUSER}', MASTER_PASSWORD='${REMOTEPASS}' ;" | mysql -u root -p$ROOTPASS -h 127.0.0.1

mysqldump -u $REMOTEUSER -p$REMOTEPASS -h $REMOTESERVER --databases `mysql -u $REMOTEUSER -p$REMOTEPASS -h $REMOTESERVER --skip-column-names -e "SELECT GROUP_CONCAT(schema_name SEPARATOR ' ') FROM information_schema.schemata WHERE schema_name NOT IN ('mysql','performance_schema','information_schema');"` --no-data --skip-add-drop-table --lock-tables=false --quick > dump-struct.sql

sed -i 's/CREATE TABLE/CREATE TABLE IF NOT EXISTS/g' dump-struct.sql

mysql -u root -p$ROOTPASS -h 127.0.0.1 < dump-struct.sql

rm dump-struct.sql

mysqldump -u $REMOTEUSER -p$REMOTEPASS -h $REMOTESERVER --databases `mysql -u $REMOTEUSER -p$REMOTEPASS -h $REMOTESERVER --skip-column-names -e "SELECT GROUP_CONCAT(schema_name SEPARATOR ' ') FROM information_schema.schemata WHERE schema_name NOT IN ('mysql','performance_schema','information_schema');"` --insert-ignore --master-data=1 --skip-add-drop-table --apply-slave-statements --no-create-info > dump.sql

sed -i "s/STOP ALL SLAVES;/STOP SLAVE '$SLAVENAME';/g" dump.sql
sed -i "s/CHANGE MASTER TO MASTER_LOG_FILE/CHANGE MASTER '$SLAVENAME' TO MASTER_LOG_FILE/g" dump.sql
sed -i "s/START ALL SLAVES;/START SLAVE '$SLAVENAME';/g" dump.sql

mysql -u root -p$ROOTPASS -h 127.0.0.1 < dump.sql

rm dump.sql
