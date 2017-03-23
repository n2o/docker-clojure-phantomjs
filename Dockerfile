FROM clojure:alpine

# Based on https://github.com/Overbryd/docker-phantomjs-alpine/releases. Thanks!
RUN apk add --no-cache fontconfig curl \
    && cd /tmp \
    && curl -L https://github.com/Overbryd/docker-phantomjs-alpine/releases/download/2.11/phantomjs-alpine-x86_64.tar.bz2 | tar xj \
    && ln -s /tmp/phantomjs/phantomjs /usr/bin/phantomjs \
    && phantomjs --version
