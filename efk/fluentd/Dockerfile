FROM fluent/fluentd:onbuild

USER root

RUN apk add --update --virtual .build-deps \
        sudo build-base ruby-dev \

 # cutomize following instruction as you wish
 && gem install \ 
        fluent-plugin-elasticsearch \
        fluent-plugin-record-reformer \
        fluent-plugin-xml-parser \
        fluent-plugin-tail-multiline-ex \
        fluent-plugin-parser \
	fluent-plugin-concat \

 && gem sources --clear-all \
 && apk del .build-deps \
 && rm -rf /var/cache/apk/* \
           /root/.gem/ruby/2.3.0/cache/*.gem
