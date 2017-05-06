#!/bin/bash
#

# START SYNC 
# CHANGE MASTER 'pi1' TO MASTER_HOST='192.168.0.238', MASTER_PORT=3306,MASTER_USER='replication', MASTER_PASSWORD='yqTOksHDSGTy' ;

SLAVENAME='pi1'
REMOTESERVER='pi1.moot'
REMOTEUSER='replication'
REMOTEPASS='yqTOksHDSGTy'

mysqldump -u $REMOTEUSER -p$REMOTEPASS -h $REMOTESERVER --databases `mysql -u $REMOTEUSER -p$REMOTEPASS -h $REMOTESERVER --skip-column-names -e "SELECT GROUP_CONCAT(schema_name SEPARATOR ' ') FROM information_schema.schemata WHERE schema_name NOT IN ('mysql','performance_schema','information_schema');"` --no-data --skip-add-drop-table --lock-table=false --quick > dump-struct.sql

sed -i 's/CREATE TABLE/CREATE TABLE IF NOT EXISTS/g' dump-struct.sql

mysql -u root -p6wObbPbBTaps -h 127.0.0.1 < dump-struct.sql

rm dump-struct.sql

mysqldump -u $REMOTEUSER -p$REMOTEPASS -h $REMOTESERVER --databases `mysql -u $REMOTEUSER -p$REMOTEPASS -h $REMOTESERVER --skip-column-names -e "SELECT GROUP_CONCAT(schema_name SEPARATOR ' ') FROM information_schema.schemata WHERE schema_name NOT IN ('mysql','performance_schema','information_schema');"` --insert-ignore --master-data=1 --skip-add-drop-table --apply-slave-statements --no-create-info > dump.sql

sed -i "s/STOP ALL SLAVES;/STOP SLAVE '$SLAVENAME';/g" dump.sql
sed -i "s/CHANGE MASTER TO MASTER_LOG_FILE/CHANGE MASTER '$SLAVENAME' TO MASTER_LOG_FILE/g" dump.sql
sed -i "s/START ALL SLAVES;/START SLAVE '$SLAVENAME';/g" dump.sql

mysql -u root -p6wObbPbBTaps -h 127.0.0.1 < dump.sql

rm dump.sql