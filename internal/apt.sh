#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
APT="apt-get -y --no-install-recommends"

mkdir -p /var/cache/docker-apt/lists/partial /var/cache/docker-apt/archives/partial

$APT $@ || { $APT update; $APT $@; }
