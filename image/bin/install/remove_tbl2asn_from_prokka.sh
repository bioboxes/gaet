#!/bin/bash

set -o errexit
set -o nounset
set -o xtrace

apt-get update
apt-get install --yes --no-install-recommends patch

patch \
	--input=/usr/local/share/prokka.patch \
	--directory=/usr/local/bin \
	/usr/local/prokka/bin/prokka

apt-get autoremove --purge --yes patch
apt-get clean
rm -rf /var/lib/apt/lists/*
