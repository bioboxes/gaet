#!/bin/sh

set -o errexit
set -o nounset
set -o xtrace

BUILD_DEPENDENCIES="\
	ca-certificates \
	g++ \
	python-dev \
	python-pip \
	wget \
	xz-utils"

RUNTIME_DEPENDENCIES="\
	bioperl \
	file \
	less \
	libdatetime-perl \
	libdigest-md5-perl \
	libidn11 \
	libxml-simple-perl \
	openjdk-7-jre-headless \
	python-minimal"

apt-get update
apt-get install --yes --no-install-recommends ${BUILD_DEPENDENCIES}

export PATH=${PATH}:/usr/local/bin/install

# Install dependendencies
prokka.sh
domain_predictor.sh

# Clean up dependencies
# apt-get autoremove --purge --yes ${BUILD_DEPENDENCIES}
# apt-get clean

# Ensure RUNTIME_DEPENDENCIES are installed after purging BUILD_DEPENDENCIES
apt-get install --yes --no-install-recommends ${RUNTIME_DEPENDENCIES}
# rm -rf /var/lib/apt/lists/*

# Build prokka database
prokka --setupdb
