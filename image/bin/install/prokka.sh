#!/bin/bash

# prokka
COMMIT=1caf2394850998f89a3782cc8846dc51978faac2
fetch.sh https://github.com/tseemann/prokka/archive/${COMMIT}.tar.gz prokka
ln -s /usr/local/prokka/binaries/linux/* /usr/local/prokka/bin/* /usr/local/bin
rm -rf /usr/local/prokka/binaries/darwin /usr/local/prokka/doc

# tbl2asn
mkdir -p /usr/local/tbl2asn/bin
wget ftp://ftp.ncbi.nih.gov/toolbox/ncbi_tools/converters/by_program/tbl2asn/linux64.tbl2asn.gz \
		--quiet --output-document - \
			| gunzip > /usr/local/tbl2asn/bin/tbl2asn
chmod 700 /usr/local/tbl2asn/bin/tbl2asn
rm /usr/local/bin/tbl2asn
ln -s /usr/local/tbl2asn/bin/tbl2asn /usr/local/bin
