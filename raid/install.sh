#!/bin/bash

# /dev/sdf2 = cache ssd


#md0 : 
#/dev/sda1   	 2048 1953525134 1953523087 931.5G Linux LVM
#/dev/sdb1        2048 1953525134 1953523087 931.5G Linux LVM
#/dev/sdc1        2048 1953525134 1953523087 931.5G Linux LVM

#sudo mdadm --create /dev/md0 --level=5 --raid-devices=3 /dev/sda1 /dev/sdb1 /dev/sdc1

#sudo pvcreate /dev/md0

#md1 : 
#/dev/sdb2  1953525760 3907029134 1953503375 931.5G Linux LVM
#/dev/sdc2  1953525760 3907029134 1953503375 931.5G Linux LVM
#/dev/sdd1        2048 1953505422 1953503375 931.5G Linux RAID
#/dev/sde1        2048 1953505422 1953503375 931.5G Linux RAID

#sudo mdadm --create /dev/md1 --level=10 --raid-devices=4 /dev/sdb2 /dev/sdc2 /dev/sdd1 /dev/sde1

#sudo pvcreate /dev/md1



#LVM 
#vgcreate datas-vg /dev/md0 /dev/sdf2

#lvcreate -l %FREE -n datas datas-vg /dev/md0

# Cache
#lvcreate -L 59G -n cache datas-vg /dev/sdf2
#lvcreate -L 100M -n cache_meta datas-vg /dev/sdf2

#lvconvert --type cache-pool --cachemode writeback --poolmetadata datas-vg/cache_meta datas-vg/cache

#lvconvert --type cache --cachepool datas-vg/cache datas-vg/datas

# ADD NEW
vgextend datas-vg /dev/md1

# remove the cache and extend the volume
lvconvert --uncache datas-vg/datas
lvextend -l %FREE datas-vg/datas /dev/md1

# Recreate the cache using the data you collected above
lvcreate -L 100M -n cache_meta datas-vg /dev/sdf2
lvcreate -l %FREE -n cache datas-vg /dev/sdf2

lvconvert --type cache-pool --cachemode writeback --poolmetadata datas-vg/cache_meta datas-vg/cache
lvconvert --type cache --cachepool datas-vg/cache datas-vg/datas




