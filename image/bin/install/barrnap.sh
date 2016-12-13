#!/bin/bash

# hmmer3
fetch.sh 'http://eddylab.org/software/hmmer3/3.1b2/hmmer-3.1b2-linux-intel-x86_64.tar.gz' hmmer3

# barrnap
fetch.sh https://github.com/tseemann/barrnap/archive/0.7.tar.gz barrnap
ln -s /usr/local/barrnap/binaries/linux/* /usr/local/barrnap/bin/* /usr/local/bin

# Patch with JGI changes to barrnap containing RNaseP and SRP
cd /usr/local/barrnap
wget --output-document - \
	'https://patch-diff.githubusercontent.com/raw/tseemann/barrnap/pull/18.diff' | patch -p1
cd ./build
PATH=/usr/local/hmmer3/binaries:${PATH} ./build_HMMs.sh
mv arc.hmm bac.hmm euk.hmm mito.hmm ../db
rm -rf /usr/local/barrnap/binaries/darwin /usr/local/barrnap/examples /usr/local/barrnap/build /usr/local/hmmer3
