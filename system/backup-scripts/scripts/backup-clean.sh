#!/bin/bash
#

backupdir=/srv/backs

retentionday=20
retentionweek=50
retentionmonth=70


# Clean orphans
find "$backupdir/daily/" -type f -ctime +$retentionday -exec sudo rm -rf {} \;
find "$backupdir/weekly/" -type f -ctime +$retentionweek -exec sudo rm -rf {} \;
find "$backupdir/monthly/" -type f -ctime +$retentionmonth -exec sudo rm -rf {} \;