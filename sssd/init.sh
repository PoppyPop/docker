#!/bin/bash
#

sudo apt-get install libsss-sudo sssd-ldap sssd-tools

sudo cp sssd.conf /etc/sssd/sssd.conf

sudo chmod a-rwx,u+r /etc/sssd/sssd.conf

# Add to /etc/pam.d/common-session
# After pam_sss
# session optional                          pam_mkhomedir.so skel = /etc/skel/ mask=0077

# Add to /etc/ssh/sshd_config
# AuthorizedKeysCommand /usr/bin/sss_ssh_authorizedkeys
# AuthorizedKeysCommandUser root