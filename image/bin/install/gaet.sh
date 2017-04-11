#!/bin/bash

fetch.sh https://s3-us-west-1.amazonaws.com/gaet/releases/${GAET_VERSION}.tar.xz gaet-tmp
mv /usr/local/gaet-tmp/gaet-${GAET_VERSION}/ /usr/local/geat/
ln -s /usr/local/geat/bin/* /usr/local/bin
