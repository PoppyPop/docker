#!/bin/bash
#

src=${BASH_SOURCE%/*}

backupDir=~/restorefile

getLatestFile () {
	local dir=$1
	local suffix=$2
	
	local latest
	
	for file in "$dir/$suffix"*; do
		[[ $file -nt $latest ]] && latest=$file
	done
	echo "$latest"
}

# Restore Baskup file
if [ ! -d "$backupDir" ]; then
	mkdir "$backupDir"
	rclone copy --max-age 1d  gdsecret:/$(hostname -f)/daily/ "$backupDir"
fi

read -p "Veuillez vous assurer qu'il n'y a qu'une seule version de chaque backup"

# Sensitive
echo "Sensitive"
sensitiveArch=$( getLatestFile $backupDir "local-sensitive" )

if [ ! -z ${sensitiveArch+x} ]; then
	# ${src}/sensitiveconf/restore-sensitive.sh $sensitiveArch
fi

# Elastic
echo "Elastic"
elasticArch=$( getLatestFile $backupDir "local-elastic" )

if [ ! -z ${elasticArch+x} ]; then
	# ${src}/elastic/restore-elastic.sh $elasticArch
fi


# Web
echo "Web"
webArch=$( getLatestFile $backupDir "local-web" )

if [ ! -z ${webArch+x} ]; then
	# ${src}/web/restore-web.sh $webArch
fi

