#!/bin/bash
#

ADMINPASS={ADMINPASS}

dnf install @freeipa-server oddjob-mkhomedir libsss_sudo haveged jq

systemctl start haveged
systemctl enable haveged

ipa-server-install --realm=MOOT.FR --domain=moot.fr \
	--ds-password=DIAZc6HHE6jDuPkL --admin-password=PLRW7Q03rZGeN7nu \
	--ssh-trust-dns --setup-dns --no-host-dns --idstart=10000 --mkhomedir \
	--hostname nessie.moot.fr --reverse-zone=0.168.192.in-addr.arpa \
	--no-forwarders \
	--ip-address=192.168.0.234 --unattended \
	--external-ca 

wget http://192.168.0.235:8887/ca.pem
cp ca.pem /etc/pki/ca-trust/source/anchors/
update-ca-trust

curl -d '{}' -X POST http://192.168.0.235:8888/api/v1/cfssl/info | jq -r ".result.certificate" > int.pem

cat int.pem >> ipa-cachain.pem
cat ca.pem >> ipa-cachain.pem

wget https://github.com/PoppyPop/docker/raw/master/pki/cfssl/go-client/cfssl-sign-linux-amd64
chmod +x cfssl-sign-linux-amd64

./cfssl-sign-linux-amd64 -u http://192.168.0.235:8888 -p intermediate sign -k 8992A20EC1197149F71C34473879B541 ipa.csr

ipa-server-install --realm=MOOT.FR --domain=moot.fr \
	--ds-password=DIAZc6HHE6jDuPkL --admin-password=PLRW7Q03rZGeN7nu \
	--ssh-trust-dns --setup-dns --no-host-dns --idstart=10000 --mkhomedir \
	--hostname nessie.moot.fr --reverse-zone=0.168.192.in-addr.arpa \
	--no-forwarders \
	--ip-address=192.168.0.234 --unattended \
    --external-cert-file=/root/ipa.crt --external-cert-file=/root/ipa-cachain.pem

for x in http https dns freeipa-ldap freeipa-ldaps freeipa-replication ntp; do firewall-cmd --permanent --zone=FedoraServer --add-service=${x} ; done

systemctl reload firewalld

authconfig --enablemkhomedir --update

# DDNS
# Add /etc/named.conf > include "/etc/ddns.key";
# Create/Add file /etc/ddns.key shared with dhcp server
# IPA Web ui -> Add "grant DDNS_UPDATE wildcard * ANY;" in zone parameters

# Create backup images fedora
# qemu-img convert -O qcow2 -c myos.img myos.gz.img