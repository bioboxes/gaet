#!/bin/bash

fetch.sh https://s3-us-west-1.amazonaws.com/gaet/releases/${GAET_VERSION}.tar.xz gaet-tmp
mv /usr/local/gaet-tmp/binary/gaet-${GAET_VERSION}/ /usr/local/gaet/
ln -s /usr/local/gaet/bin/* /usr/local/bin
