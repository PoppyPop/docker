#!/bin/bash
#

# elastic 1
sudo mkdir -p /srv/datas/efk/elastic1

# elastic 2
sudo mkdir -p /srv/datas/efk/elastic2

# Backup
sudo mkdir -p /srv/datas/efk/backup

sudo chown -R 1000:1000 /srv/datas/efk/*

sudo docker network create --opt com.docker.network.driver.mtu=9000 efk-net

# conf
sudo mkdir -p /srv/confs/efk/
sudo mkdir -p /srv/backs/efk

sudo cp -f docker-compose.yml /srv/confs/efk/
sudo cp -f fluentd/fluent.conf /srv/confs/efk/

vmmapcount=`sudo grep -c "vm.max_map_count" /etc/sysctl.conf`

if [ "$vmmapcount" -eq "0" ]
then
	# Persist data for the next reboot 
	echo "vm.max_map_count=262144" | sudo tee -a /etc/sysctl.conf 
	
	# Change the value manually
	echo "Runtime Write : "
	sudo sysctl -w vm.max_map_count=262144  
else
	# Message to modify sysctl.conf manually
	echo "vm.max_map_count Already exist in /etc/sysctl.conf"
	echo "You have to change /etc/sysctl.conf manually"
	echo "Modify the line vm.max_map_count to the value 262144"
	echo "Actual value : "
	sudo grep "vm.max_map_count" /etc/sysctl.conf

	# Change the value manually
	echo "Runtime Write : "
	sudo sysctl -w vm.max_map_count=262144  
fi