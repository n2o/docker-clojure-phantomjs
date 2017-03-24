# docker-clojure-phantomjs

Creates an Alpine-based [Clojure](https://clojure.org/) environment with [Leiningen](https://leiningen.org/) and [PhantomJS](http://phantomjs.org/).

This is an excellent image when working with ClojureScript and the need for some tests with a browser, for example a configuration with [lein doo](https://github.com/bensu/doo).

Uses the latest official [clojure:alpine](https://hub.docker.com/_/clojure/) image and adds PhantomJS and a Patch for Alpine Linux.
