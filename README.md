# VistaTV Random Stats Server

## Introduction

The VistaTV Random Stats Server provides an HTTP / TCP interface to random data. 

## Prerequisites

* [Ruby](http://www.ruby-lang.org/) v1.9.3 or v2.0
* [Bundler](http://gembundler.com/)

## Getting started

### Obtain the code

    $ git clone https://github.com/bbcrd/vistatv_random_stats_server.git
    $ cd vistatv_random_stats_server

### Install gem dependencies

    $ bundle install

### Configure

    $ cp config/config.yml.example config/config.yml

Edit `config/config.yml` to your local requirements. Refer to the [Configuration settings](#config) section below for details.


### Start the server

    foreman start

## <a id="config"></a>Configuration settings

The Stats Server is configured using a [YAML](http://www.yaml.org/) format file, `config/config.yml`. Here's an example:

    stats_server:
      host: "localhost"
      port: 8081

    stats_http_server:
      host: "localhost"
      port: 8083


The following sections describe each of the settings in this file.

### stats_server

#### host

The hostname of the stats socket server, typically `"localhost"`.

#### port

The port that the stats server listens on for incoming socket connections.

### stats_http_server

#### host

The hostname of the stats HTTP server, typically `"localhost"`.

#### port

The port that the stats server listens on for HTTP requests.

## License

See [COPYING](COPYING)

## Authors

See [AUTHORS](AUTHORS)

## Copyright

Copyright 2013 British Broadcasting Corporation




