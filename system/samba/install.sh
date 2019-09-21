#!/bin/bash
#

sudo apt install samba smbldap-tools

# change nfs thread to 64
# /etc/default/nfs-kernel-server


# change master passwd for the ldap server
sudo smbpasswd -W