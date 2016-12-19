#!/bin/sh

set -o errexit
set -o nounset
set -o xtrace

NON_ESSENTIAL_BUILD_DEPENDENCIES="\
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
	make \
	openjdk-7-jre-headless \
	parallel \
	python-minimal \
	python-pkg-resources
	python-six"

apt-get update
apt-get install --yes --no-install-recommends ${NON_ESSENTIAL_BUILD_DEPENDENCIES}

export PATH=${PATH}:/usr/local/bin/install

# Install dependendencies
domain_predictor.sh
prokka.sh
gaet.sh

# Clean up dependencies
apt-get autoremove --purge --yes ${NON_ESSENTIAL_BUILD_DEPENDENCIES}
apt-get clean

# Ensure required dependencies are installed after purging NON_ESSENTIAL_BUILD_DEPENDENCIES
apt-get install --yes --no-install-recommends ${RUNTIME_DEPENDENCIES}
rm -rf /var/lib/apt/lists/*

# Build prokka database
prokka --setupdb
