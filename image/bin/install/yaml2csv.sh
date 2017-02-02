#!/bin/bash

mkdir -p /usr/local/yaml2csv/bin
wget https://s3-us-west-1.amazonaws.com/bioboxes-packages/yaml2csv/yaml2csv-${Y2C_VERSION}.xz -O - \
	| xz -d \
	> /usr/local/yaml2csv/bin/yaml2csv
chmod 700 /usr/local/yaml2csv/bin/yaml2csv
ln -s /usr/local/yaml2csv/bin/* /usr/local/bin
