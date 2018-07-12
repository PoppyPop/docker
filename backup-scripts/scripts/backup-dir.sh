#!/bin/sh
####################################
#
# grandfather-father-son rotation.
#
####################################

# Fail on error
set -e

backup () { 
	# Backup the files using tar.
	tar -cjf $2 -C $1 .

	# Print end status message.
	echo "Backup $2 finished"
}

if [ -z "$1" ]; then
	echo "name is mandatory"
	exit 1
fi

# What to backup. 
backup_name="$1"

if [ -z "$2" ]; then
	backup_files="/volume"
else
	backup_files="$2"
fi

# Where to backup to.
if [ -z "$3" ]; then
	dest="/backup"
else
	dest="$3"
fi

retentionday=8
retentionweek=4
retentionmonth=2
ext="tar.bz2"

# Setup variables for the archive filename.
day=$(date +%A)
day_num=$(date +"%d")
now=$(date +"%Y-%m-%d_%H-%M")

day_file="$backup_name-$now.$ext"

week_num=$(date +"%Y-%V")
week_file="$backup_name-$week_num.$ext"

# Find if the Month is odd or even.
month_num=$(date +"%Y-%m")
month_file="$backup_name-$month_num.$ext"

# Prep directory
mkdir -p $dest/monthly
mkdir -p $dest/weekly
mkdir -p $dest/daily

# Create archive.
if [ $day_num -eq 1 ]; then
	backup $backup_files $dest/monthly/$month_file
fi

if [ "$day" = "Sunday" ]; then
	backup $backup_files $dest/weekly/$week_file 
fi

backup $backup_files $dest/daily/$day_file 

# Clean old backup
ls -tp "$dest/daily/$backup_name"* 2>/dev/null | grep -v '/$' | tail -n +$retentionday | xargs -I {} rm -- {}
ls -tp "$dest/weekly/$backup_name"* 2>/dev/null | grep -v '/$' | tail -n +$retentionweek | xargs -I {} rm -- {}
ls -tp "$dest/monthly/$backup_name"* 2>/dev/null | grep -v '/$' | tail -n +$retentionmonth | xargs -I {} rm -- {}

