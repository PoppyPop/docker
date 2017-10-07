FROM debian:stretch-slim

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
    && apt-get update \
	&& apt-get install -y apt-utils \
    && apt-get install -y ca-certificates gnupg2 \
	&& apt-key adv --keyserver keys.gnupg.net --recv-keys D744D55EACDA69FF \
	&& rm -rf /var/lib/apt/lists/*
		
#Add fusiondirectory sources
RUN printf "deb http://repos.fusiondirectory.org/fusiondirectory-current/debian-wheezy wheezy main\ndeb http://repos.fusiondirectory.org/fusiondirectory-extra/debian-jessie jessie main" > /etc/apt/sources.list.d/fusiondirectory.list

RUN apt-get update \
    && apt-get upgrade -y \
	&& apt-get install -y perl perl-modules php-mbstring libarchive-extract-perl
	

RUN apt-get install -y perl perl-modules fusiondirectory \
    fusiondirectory-plugin-dhcp \
	fusiondirectory-plugin-dns \
	fusiondirectory-plugin-freeradius \
	fusiondirectory-plugin-ldapdump \
    fusiondirectory-plugin-ldapmanager \
	fusiondirectory-plugin-ssh \
	fusiondirectory-plugin-sudo \
	fusiondirectory-plugin-samba \
    fusiondirectory-plugin-systems \
    fusiondirectory-plugin-weblink \
    fusiondirectory-plugin-webservice \
    fusiondirectory-webservice-shell \
	php-mbstring

COPY fd-template.conf /var/cache/fusiondirectory/template/fusiondirectory.conf
	
EXPOSE 80 443

CMD ["/bin/bash"]
	
	

