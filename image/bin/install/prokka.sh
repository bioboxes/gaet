#!/bin/bash

set -o errexit
set -o nounset
set -o xtrace

# Forked version of barrnap
fetch.sh https://github.com/michaelbarton/barrnap/archive/${BARRNAP_VERSION}.tar.gz barrnap
ln -s /usr/local/barrnap/binaries/linux/* /usr/local/barrnap/bin/* /usr/local/bin
rm -rf /usr/local/barrnap/binaries/darwin /usr/local/barrnap/examples /usr/local/barrnap/build

# prokka
fetch.sh https://github.com/tseemann/prokka/archive/${PROKKA_VERSION}.tar.gz prokka
ln -s /usr/local/prokka/binaries/linux/* /usr/local/prokka/bin/* /usr/local/bin
rm -rf /usr/local/prokka/binaries/darwin /usr/local/prokka/doc

# tbl2asn
mkdir -p /usr/local/tbl2asn/bin
wget -N https://s3-us-west-1.amazonaws.com/bioboxes-packages/downloads/linux64.tbl2asn.xz \
	--quiet --output-document - | xz -d > /usr/local/tbl2asn/bin/tbl2asn
chmod 700 /usr/local/tbl2asn/bin/tbl2asn
rm /usr/local/bin/tbl2asn
ln -s /usr/local/tbl2asn/bin/tbl2asn /usr/local/bin
