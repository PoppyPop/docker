#!/bin/bash
#

apt-get install bcache-tools

wget https://gist.githubusercontent.com/visvirial/22513f28671752962f71c75a758a00f6/raw/53244e149b78b5b8ecb12a8d588191208b9d9d0d/bcache-status
chmod +x bcache-status
mv bcache-status /usr/sbin/

# -B = backing device = spinning dsk
wipefs -a /dev/sdf2
make-bcache -B /dev/md0

#Copy set-UUID from output
#UUID:                   6b1561e6-55b1-44ab-84ad-9c2164d17ac0
#Set UUID:               5b6f302d-4e51-4fbf-a6eb-b10061c2821c
#version:                1
#block_size:             1
#data_offset:            16

mkfs.ext4 /dev/bcache0

mount /dev/bcache0 /datas

#Update fstab

cp -pur /datas-backup/* /datas/

# -C = cache device = ssd
wipefs -a /dev/sda2
make-bcache -C /dev/sda2 #check device
#Copy set-UUID from output
#UUID:                   25564fdd-84cf-40a5-8b67-9253de554e5e
#Set UUID:               ee0c5ce4-c401-45ae-bbd2-11d9bce912c9
#version:                0
#nbuckets:               121326
#block_size:             1
#bucket_size:            1024
#nr_in_set:              1
#nr_this_dev:            0
#first_bucket:           1

# stats 
cat /sys/block/bcache0/bcache/state
# or 
bcache-status

# Set cache
#echo CACHE-set-UUID > /sys/block/bcache0/bcache/attach
echo ee0c5ce4-c401-45ae-bbd2-11d9bce912c9 > /sys/block/bcache0/bcache/attach

# Set cache mode
echo writeback > /sys/block/bcache0/bcache/cache_mode

# Set sequential cache
echo 1M > /sys/block/bcache0/bcache/sequential_cutoff

# Allow 10percent of dirty datas (only in cache)
echo 10 > /sys/block/bcache0/bcache/writeback_percent




#Stats
cat /sys/block/bcache0/bcache/dirty_data
tail /sys/block/bcache0/bcache/stats_total/*