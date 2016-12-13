#!/bin/bash

set -o errexit
set -o nounset
set -o xtrace

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
prokka --cpus $(nproc) ${IN}
mv */*.gff ${OUT}
cd /
rm -fr ${DIR}
