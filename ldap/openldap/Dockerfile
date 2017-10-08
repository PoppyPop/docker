FROM alpine:latest

ENV FUSIONDIRECTORY_VERSION 1.2

RUN set -xe \
	&& apk update --no-cache && apk upgrade --no-cache \
	&& apk add --update --no-cache openldap openldap-back-monitor openldap-clients \
	&& mkdir /etc/openldap/slapd.d \
	&& mkdir -p /var/lib/openldap/openldap-data \
	&& rm -rf /var/cache/apk/*

ADD conf/slapd.ldif /etc/openldap/slapd.ldif
ADD conf/config.ldif /etc/openldap/config.ldif

#Handling schema
RUN mkdir tmpschema && cd tmpschema && mkdir fusiond && \
  mkdir -p /etc/openldap/schema-ldif-includes && \
  apk add --update --no-cache wget perl && \
  wget --no-check-certificate -q -O fusiondirectory-${FUSIONDIRECTORY_VERSION}.tar.gz https://github.com/fusiondirectory/fusiondirectory/archive/fusiondirectory-${FUSIONDIRECTORY_VERSION}.tar.gz && \
  tar -xzf fusiondirectory-${FUSIONDIRECTORY_VERSION}.tar.gz -C fusiond/ && \
  wget --no-check-certificate -q -O fusiondirectory-plugins-${FUSIONDIRECTORY_VERSION}.tar.gz --progress=dot:giga https://github.com/fusiondirectory/fusiondirectory-plugins/archive/fusiondirectory-${FUSIONDIRECTORY_VERSION}.tar.gz && \
  tar -xzf fusiondirectory-plugins-${FUSIONDIRECTORY_VERSION}.tar.gz -C fusiond/ && \
  wget --no-check-certificate -q -O schema2ldif-${FUSIONDIRECTORY_VERSION}.tar.gz  https://github.com/fusiondirectory/schema2ldif/archive/${FUSIONDIRECTORY_VERSION}.tar.gz && \
  tar -xzf schema2ldif-${FUSIONDIRECTORY_VERSION}.tar.gz -C fusiond/ && \
  /tmpschema/fusiond/schema2ldif-${FUSIONDIRECTORY_VERSION}/bin/schema2ldif fusiond/fusiondirectory-fusiondirectory-${FUSIONDIRECTORY_VERSION}/contrib/openldap/core-fd.schema > /etc/openldap/schema-ldif-includes/01-core-fd.ldif && \
  /tmpschema/fusiond/schema2ldif-${FUSIONDIRECTORY_VERSION}/bin/schema2ldif fusiond/fusiondirectory-fusiondirectory-${FUSIONDIRECTORY_VERSION}/contrib/openldap/core-fd-conf.schema > /etc/openldap/schema-ldif-includes/03-core-fd-conf.ldif && \
  /tmpschema/fusiond/schema2ldif-${FUSIONDIRECTORY_VERSION}/bin/schema2ldif fusiond/fusiondirectory-fusiondirectory-${FUSIONDIRECTORY_VERSION}/contrib/openldap/template-fd.schema > /etc/openldap/schema-ldif-includes/05-template-fd.ldif && \
  /tmpschema/fusiond/schema2ldif-${FUSIONDIRECTORY_VERSION}/bin/schema2ldif fusiond/fusiondirectory-fusiondirectory-${FUSIONDIRECTORY_VERSION}/contrib/openldap/ldapns.schema > /etc/openldap/schema-ldif-includes/07-ldapns.ldif && \
  for f in `ls fusiond/fusiondirectory-plugins-fusiondirectory-${FUSIONDIRECTORY_VERSION}/*/contrib/openldap/*.schema | grep -v conf` ; do bn=$(basename $f .schema); /tmpschema/fusiond/schema2ldif-${FUSIONDIRECTORY_VERSION}/bin/schema2ldif $f &> /etc/openldap/schema-ldif-includes/80-$bn.ldif; done && \
  for f in `ls fusiond/fusiondirectory-plugins-fusiondirectory-${FUSIONDIRECTORY_VERSION}/*/contrib/openldap/*.schema | grep conf` ; do bn=$(basename $f .schema); /tmpschema/fusiond/schema2ldif-${FUSIONDIRECTORY_VERSION}/bin/schema2ldif $f &> /etc/openldap/schema-ldif-includes/90-$bn.ldif; done && \
  mv /etc/openldap/schema-ldif-includes/80-mail-fd.ldif /etc/openldap/schema-ldif-includes/70-mail-fd.ldif && \
  for f in `ls /etc/openldap/schema-ldif-includes/*.ldif` ; do echo "include: file://$f" >> /etc/openldap/schema.ldif; done && \
  sed -i '/misc.ldif/r /etc/openldap/schema.ldif' /etc/openldap/slapd.ldif && \
  /usr/sbin/slapadd -F /etc/openldap/slapd.d -n 0 -l /etc/openldap/slapd.ldif  && \
  cd - && \
  rm -rf tmpschema && \
  apk del --no-cache wget perl && \
  rm -rf /var/cache/apk/*
 
#Main populate
RUN /usr/sbin/slapadd -F /etc/openldap/slapd.d -l /etc/openldap/config.ldif

VOLUME /var/lib/openldap

EXPOSE 389 636

CMD ["slapd", "-d", "256", "-h", "ldap:/// ldapi:///", "-F", "/etc/openldap/slapd.d"]
