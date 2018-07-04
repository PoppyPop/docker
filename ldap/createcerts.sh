#!/bin/bash
#

# Fail on error
set -e

AUTOORGURL=$(curl -L -s -u "PoppyPop" https://api.github.com/repos/PoppyPop/cfssl-client/releases/latest | jq -r ".assets[] | select(.name | test(\"cfssl-client_linux_amd64\")) | .browser_download_url")

curl -L -s $AUTOORGURL > cfssl-client

chmod +x cfssl-client

./cfssl-client -p server -u http://pki.mo-ot.fr:8888 generate -d ldap.mo-ot.fr -d ldap -d openldap

docker run --rm  -v openldap-certs:/dist -v ${PWD}:/local alpine \
	sh -c "rm -rf /dist/* ; cp -f /local/ldap.mo-ot.fr.* /dist/"
	
rm cfssl-client

rm -rf ldap.mo-ot.fr.*

	
