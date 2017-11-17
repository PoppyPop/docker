#!/bin/bash
#

docker volume create --driver local \
    --opt type=nfs \
    --opt o=addr=192.168.0.250,rw,async \
    --opt device=:/volume1/ATrier \
    pico-atrier
    

docker volume create -o type=none -o device=/datas/atrier -o o=bind aria-atrier

# Local bind
docker volume create -o type=none -o device=/datas/downloads/aria2/Downloads -o o=bind aria-downloads
docker volume create -o type=none -o device=/datas/downloads/aria2/Ended -o o=bind aria-ended
docker volume create -o type=none -o device=/datas/downloads/aria2/Extract -o o=bind aria-extract

#docker volume rm aria-atrier 

#docker volume rm aria-downloads 
#docker volume rm aria-ended 
#docker volume rm aria-extract 

#docker volume rm pico-atrier