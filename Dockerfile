FROM clojure:alpine

# Taken from https://github.com/Overbryd/docker-phantomjs-alpine/releases
RUN apk update && apk add --no-cache fontconfig curl && \
    mkdir -p /usr/share && \
    cd /usr/share \
    && curl -L https://github.com/Overbryd/docker-phantomjs-alpine/releases/download/2.11/phantomjs-alpine-x86_64.tar.bz2 | tar xj \
    && ln -s /usr/share/phantomjs/phantomjs /usr/bin/phantomjs \
    && phantomjs --version
