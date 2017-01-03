#!/bin/bash

# http://stackoverflow.com/a/18279131/91144
if file --mime-type "${1}" | grep -q gzip$; then
        gunzip --keep ${1} --stdout
else
        cat ${1}
fi
