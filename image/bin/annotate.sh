#!/bin/bash

set -o errexit
set -o nounset
set -o xtrace

KMER=21
SIZE=10000
COVERAGE=2

ASSEMBLY=...
REFERENCE=...




QUERY_MASH=$(mktemp -d)/query.msh
mash sketch -k $(KMER) -s $(SIZE) -m $(COVERAGE) -o ${QUERY_MASH} ${REFERENCE}


DOMAIN=$(d_predict predict \
		--reference-mash=${DOMAIN_DB}/domain_db.msh \
		--query-mash=${QUERY_MASH} \
		--mapping-file=${DOMAIN_DB}/mapping.csv)


# http://stackoverflow.com/a/18279131/91144
if file --mime-type "${1}" | grep -q gzip$; then
        IN=$(realpath $(mktemp))
        gunzip --keep ${1} --stdout > ${IN}
else
        IN=$(realpath $1)
fi

OUT=$2

DIR=$(mktemp -d)
cd ${DIR}
prokka --cpus $(nproc) ${IN} --kingdom=${DOMAIN}
mv */*.gff ${OUT}
cd /
rm -fr ${DIR}
