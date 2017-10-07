#!/bin/bash
#

ldapmodify -H ldap://127.0.0.1/ -D "cn=admin,dc=moot" -Wx -f conf/samba_indices.ldif

ldapadd -H ldap://127.0.0.1/ -D "cn=admin,dc=moot" -Wx -f conf/config.ldif
