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

read -p "Voulez-vous démarrer le restore ?"

# Sensitive
echo "Sensitive"
${src}/sensitiveconf/restore-sensitive.sh $sensitiveArch

# Elastic
echo "Elastic"
# ${src}/elastic/restore-elastic.sh $elasticArch

# Web
echo "Web"
# ${src}/web/restore-web.sh $webArch

# Docker
echo "Web"
# ${src}/docker/restore-docker.sh $webArch