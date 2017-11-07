#!/bin/bash
#

sudo apt-get install kvm libvirt-bin

sudo virsh net-destroy default
sudo virsh net-autostart --disable default

sudo apt-get install openvswitch-switch network-manager

#sudo apt install kimchi ginger
wget -O kimchi.deb https://github.com/kimchi-project/kimchi/releases/download/2.5.0/kimchi-2.5.0-0.noarch.deb 
wget -O wok.deb https://github.com/kimchi-project/kimchi/releases/download/2.5.0/wok-2.5.0-0.noarch.deb

sudo dpkg -i wok.deb kimchi.deb

sudo apt-get install -f

