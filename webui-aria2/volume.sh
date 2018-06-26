#!/bin/bash
#

#docker volume create --driver local \
#    --opt type=nfs \
#    --opt o=addr=192.168.0.250,rw,async \
#    --opt device=:/volume1/ATrier \
#    pico-atrier
    
docker volume create -o type=none -o device=/datas/downloads/aria2/datas -o o=bind aria-datas --label backup=no

