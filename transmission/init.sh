#!/bin/bash
#

sudo mkdir -p /srv/confs/transmission

sudo mkdir -p /datas/downloads/transmission

#conf systemd
sudo cp -f docker-compose.yml /srv/confs/transmission/


rmemmax=`sudo grep -c "net.core.rmem_max" /etc/sysctl.conf`

if [ "$rmemmax" -eq "0" ]
then
	# Persist data for the next reboot 
	echo "net.core.rmem_max=4194304" | sudo tee -a /etc/sysctl.conf 
	
	# Change the value manually
	echo "Runtime Write : "
	sudo sysctl -w net.core.rmem_max=4194304  
else
	# Message to modify sysctl.conf manually
	echo "net.core.rmem_max Already exist in /etc/sysctl.conf"
	echo "You have to change /etc/sysctl.conf manually"
	echo "Modify the line net.core.rmem_max to the value 4194304"
	echo "Actual value : "
	sudo grep "net.core.rmem_max" /etc/sysctl.conf

	# Change the value manually
	echo "Runtime Write : "
	sudo sysctl -w net.core.rmem_max=4194304   
fi


wmemmax=`sudo grep -c "net.core.wmem_max" /etc/sysctl.conf`

if [ "$wmemmax" -eq "0" ]
then
	# Persist data for the next reboot 
	echo "net.core.wmem_max=1048576" | sudo tee -a /etc/sysctl.conf 
	
	# Change the value manually
	echo "Runtime Write : "
	sudo sysctl -w net.core.wmem_max=1048576  
else
	# Message to modify sysctl.conf manually
	echo "net.core.wmem_max Already exist in /etc/sysctl.conf"
	echo "You have to change /etc/sysctl.conf manually"
	echo "Modify the line net.core.wmem_max to the value 1048576"
	echo "Actual value : "
	sudo grep "net.core.wmem_max" /etc/sysctl.conf

	# Change the value manually
	echo "Runtime Write : "
	sudo sysctl -w net.core.wmem_max=1048576   
fi
