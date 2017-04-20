FROM fluent/fluentd:onbuild

USER root

RUN apk add --update --virtual .build-deps \
        sudo build-base ruby-dev \

 # cutomize following instruction as you wish
 && sudo -u fluent gem install \ 
        fluent-plugin-elasticsearch \
        fluent-plugin-record-reformer \
        fluent-plugin-xml-parser \
        fluent-plugin-tail-multiline-ex \
        fluent-plugin-parser \

 && sudo -u fluent gem sources --clear-all \
 && apk del .build-deps \
 && rm -rf /var/cache/apk/* \
           /home/fluent/.gem/ruby/2.3.0/cache/*.gem

USER fluent