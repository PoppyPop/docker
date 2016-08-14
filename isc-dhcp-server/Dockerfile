FROM alpine:latest

RUN set -xe \
	&& apk add --update --no-progress dhcp \
	&& rm -rf /var/cache/apk/*


RUN apk add --no-cache python3 bash && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    rm -r /root/.cache && \
    rm -rf /var/cache/apk/*

EXPOSE 67/tcp 	67/udp
EXPOSE 547/tcp 	547/udp
EXPOSE 647/tcp 	647/udp
EXPOSE 847/tcp 	847/udp

RUN ["touch", "/var/lib/dhcp/dhcpd.leases"]

VOLUME ["/data"]

#COPY util/my_init.py /sbin/my_init
#COPY util/entrypoint.sh /entrypoint.sh
#ENTRYPOINT ["/entrypoint.sh"]

ENTRYPOINT ["dhcpd"]
CMD ["-q", "-f", "-cf", "/data/dhcpd.conf", "-lf", "/data/dhcpd.leases", "--no-pid"]
