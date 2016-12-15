#!/bin/bash

set -o errexit
set -o nounset
set -o xtrace

# Domain prediction python tool
pip install scipy numpy
pip install https://s3-us-west-1.amazonaws.com/bioboxes-packages/domain-prediction/${DPRED_VERSION}.tar.gz

# mash
fetch.sh https://github.com/marbl/Mash/releases/download/v1.1.1/mash-Linux64-v${MASH_VERSION}.tar.gz mash
ln -s /usr/local/mash/mash /usr/local/bin
