#!/bin/bash
#

sudo docker network create --opt com.docker.network.driver.mtu=9000 proxy-net
