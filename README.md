# Clojure Alpine Image with PhantomJS

Creates an Alpine-based [Clojure](https://clojure.org/) environment
with [Leiningen](https://leiningen.org/) and [PhantomJS](http://phantomjs.org/).

This is an excellent image when working with ClojureScript and the need for some
tests with virtual browsers, for example
with [lein doo](https://github.com/bensu/doo) and PhantomJS.

Uses the latest official [clojure:alpine](https://hub.docker.com/_/clojure/)
image and adds PhantomJS with a patch for Alpine Linux.

## Usage

### Local Machine

Copy your code into the container to /code. You can do this by volume-mounting.
Let's assume the project's name is awesomeproject and it's a ClojureScript
project using [lein-doo](https://github.com/bensu/doo/) and phantomjs
(pre-installed in this image). To start the tests, we need to tell doo that it
should use the phantomjs runner to run the tests. We can do this by simply
calling:

    lein doo phantom test once
    
Okay, let's bring the code and the container together to execute our tests:

```shell
docker run --rm -v ~/.m2:/root/.m2 -v awesomeproject:/code cmeter/clojure-phantomjs
```

* `--rm`: removes the container after the tests finished. I like this option to
  don't mess up my system with unused containers
* `-v ~/.m2:/root/.m2`: this is an optimization to use my local cache of my jar
  files in the container. The second
* `-v awesomeproject:/code`: links my project to the container's folder `/code`

You can override the command to use your own leiningen test-aliases etc. As a
default, the container uses the command from above to start the tests with `lein
doo`.

### CI

I am using this image in the GitLab CI and in CircleCI. The configuration is
simpler in the CI, since the complete repository is usually directly checked out
into the ci's runner environment.

#### Samples

A sample job-configuration of your ClojureScript project for the GitLab CI could
look like this:

```yaml
test:
  image: cmeter/clojure-phantomjs
  stage: test
  script:
    - lein doo phantom test once
```

And for a CircleCI 2.0 config, I am using it like this:

```yaml
version: 2
jobs:
  test:
    docker:
      - image: cmeter/clojure-phantomjs
    working_directory: ~/code

    steps:
      - checkout
      - restore_cache:
          keys:
          - v1-dependencies-{{ checksum "project.clj" }}
          - v1-dependencies-
      - run: lein deps
      - save_cache:
          paths:
            - ~/.m2
          key: v1-dependencies-{{ checksum "project.clj" }}
      - run: lein doo phantom test once
```
