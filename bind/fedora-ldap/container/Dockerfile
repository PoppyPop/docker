FROM fedora:latest

# install main packages:
RUN dnf -y update && dnf clean all && \
	dnf -y install bind-utils bind bind-dyndb-ldap && \
	dnf clean all

# gen rndc key:
RUN rndc-confgen -a -c /etc/rndc.key
RUN chown named:named /etc/rndc.key

# copy cfg files:
COPY named.conf /etc/named.conf

# init env
RUN mkdir /var/log/named && \
	chown named:named /var/log/named

#VOLUME ["/etc/bind"]
#VOLUME ["/var/cache/bind"]

EXPOSE 53 53/udp

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
