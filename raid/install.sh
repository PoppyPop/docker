#!/bin/bash

# /dev/sdf2 = cache ssd

# v2 : uniquement raid 10

mdadm --create --verbose /dev/md0 --level=10 --raid-devices=4 /dev/sdd missing /dev/sde missing

mdadm --detail --scan | tee -a /etc/mdadm/mdadm.conf

update-initramfs -u

#echo '/dev/md0 /mnt/md0 ext4 defaults,nofail,discard 0 0' | sudo tee -a /etc/fstab










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

#CHECK
#sudo lvs -a -o +devices

# ADD NEW
#sudo vgextend datas-vg /dev/md1

# remove the cache and extend the volume
#sudo lvconvert --uncache datas-vg/datas
#sudo lvextend -l +100%FREE datas-vg/datas /dev/md1

# Recreate the cache using the data you collected above
#sudo lvcreate -L 100M -n cache_meta datas-vg /dev/sdf2
#sudo lvcreate -l 100%FREE -n cache datas-vg /dev/sdf2
# Needed for convert OP
#sudo lvreduce -l -25 datas-vg/cache

#sudo lvconvert --type cache-pool --cachemode writeback --poolmetadata datas-vg/cache_meta datas-vg/cache
#sudo lvconvert --type cache --cachepool datas-vg/cache datas-vg/datas

#size update
#sudo resize2fs /dev/mapper/datas--vg-datas

#update /etc/mdadm/mdadm.conf
# Add missing line
#sudo mdadm --detail --scan

#after update
#sudo update-initramfs -u

#/dev/mapper/datas--vg-datas    /datas  ext4    defaults,nofail 0       2




