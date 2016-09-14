FROM alpine:latest
  
RUN apk update --no-cache && apk upgrade --no-cache \
	 && apk --no-cache --update add bash ruby ruby-json ruby-irb \
	 && apk --no-cache --update add --virtual build-dependencies build-base ruby-dev zlib-dev \
     && rm -rf /var/cache/apk/* && \
  echo 'gem: --no-document' >> /etc/gemrc && \
  gem install thread_safe && \
  gem install tzinfo && \
  gem install nokogiri && \
  gem install fluentd && \
  gem install fluent-plugin-elasticsearch && \
  gem install fluent-plugin-xml-parser && \
  gem install fluent-plugin-tail-multiline-ex && \
  apk del build-dependencies --purge && \
  rm -rf /root/.gem && \ 
  rm -rf /var/cache/apk/*

EXPOSE 24224

VOLUME ["/etc/fluent"]

CMD ["/usr/bin/fluentd"]
