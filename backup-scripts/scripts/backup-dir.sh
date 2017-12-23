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


# What to backup. 
backup_name=$1
backup_files="/volume"

# Where to backup to.
dest="/backup"

retention=10
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

# Clean old backup
find $dest/daily -type f -mtime +$retention -delete
find $dest/weekly -type f -mtime +$((retention*7)) -delete
find $dest/monthly -type f -mtime +$((retention*30)) -delete

# Create archive.
if [ $day_num == 1 ]; then
	backup $backup_files $dest/monthly/$month_file
fi

if [ $day == "Sunday" ]; then
	backup $backup_files $dest/weekly/$week_file 
fi

backup $backup_files $dest/daily/$day_file 

