#!/bin/bash
#

dnf install @freeipa-server oddjob-mkhomedir libsss_sudo haveged

systemctl start haveged
systemctl enable haveged

ipa-server-install --realm=MOOT.FR --domain=moot.fr \
	--ds-password=DIAZc6HHE6jDuPkL --admin-password=PLRW7Q03rZGeN7nu \
	--ssh-trust-dns --setup-dns --no-host-dns --idstart=10000 --mkhomedir \
	--hostname nessie.moot.fr --reverse-zone=0.168.192.in-addr.arpa \
	--no-forwarders \
	--ip-address=192.168.0.234 --unattended \
	--external-ca 

ipa-server-install --realm=MOOT.FR --domain=moot.fr \
	--ds-password=DIAZc6HHE6jDuPkL --admin-password=PLRW7Q03rZGeN7nu \
	--ssh-trust-dns --setup-dns --no-host-dns --idstart=10000 --mkhomedir \
	--hostname nessie.moot.fr --reverse-zone=0.168.192.in-addr.arpa \
	--no-forwarders \
	--ip-address=192.168.0.234 --unattended \
    --external-cert-file=/root/ipa.crt --external-cert-file=/root/ca.pem

for x in http https dns freeipa-ldap freeipa-ldaps freeipa-replication ntp; do firewall-cmd --permanent --zone=FedoraServer --add-service=${x} ; done

systemctl reload firewalld

authconfig --enablemkhomedir --update

# DDNS
# Add /etc/named.conf > include "/etc/ddns.key";
# Create/Add file /etc/ddns.key shared with dhcp server
# IPA Web ui -> Add "grant DDNS_UPDATE wildcard * ANY;" in zone parameters

# Create backup images fedora
# qemu-img convert -O qcow2 -c myos.img myos.gz.img