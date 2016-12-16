#!/bin/bash

set -o errexit
set -o nounset
set -o xtrace

# mash
fetch.sh https://github.com/marbl/Mash/releases/download/v1.1.1/mash-Linux64-v${MASH_VERSION}.tar.gz mash
ln -s /usr/local/mash/mash /usr/local/bin


# Reference genome mash database
fetch.sh "https://s3-us-west-1.amazonaws.com/jgi-mash-database/mashes/2016-12-09-13%3A12%3A31.tar.xz" domain_db
echo "domain,mash_id" > ${DOMAIN_DB}/mapping.csv
cut -f 1,2 -d , ${DOMAIN_DB}/genome_metadata.csv >> ${DOMAIN_DB}/mapping.csv


# Create combined database of sketches
pip install --use-wheel https://s3-us-west-1.amazonaws.com/bioboxes-packages/domain-prediction/${DPRED_VERSION}.tar.gz
d_predict fit --mash-dir=${DOMAIN_DB}/mash --output-file=${DOMAIN_DB}/domain_db.msh


# Remove no-longer-needed individual sketches and intermediate files
rm -rf ${DOMAIN_DB}/mash ${DOMAIN_DB}/genome_metadata.csv /tmp/tmp*
