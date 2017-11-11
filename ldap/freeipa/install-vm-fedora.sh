#!/bin/bash
#

dnf install @freeipa-server oddjob-mkhomedir libsss_sudo haveged

systemctl start haveged
systemctl enable haveged

ipa-server-install --realm=MOOT.FR --domain=moot.fr --ds-password=DIAZc6HHE6jDuPkL --admin-password=PLRW7Q03rZGeN7nu --ssh-trust-dns --setup-dns 

for x in http https dns freeipa-ldap freeipa-ldaps freeipa-replication; do firewall-cmd --permanent --zone=FedoraServer --add-service=${x} ; done

authconfig --enablemkhomedir --update

# DDNS
# Add /etc/named.conf > include "/etc/ddns.key";
# Create/Add file /etc/ddns.key shared with dhcp server
# IPA Web ui -> Add "grant DDNS_UPDATE wildcard * ANY;" in zone parameters
