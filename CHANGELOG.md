# Changelog

All notable changes to this project will be documented in this file.

## 2017-12-20

  - Fixed a bug where tbl2asn causes pipeline to fail when the tbl2asn binary
    is more than a year old. The use of tbl2asn is not necessary for the GAET
    pipeline and so can be removed with a patch to the prokka script. The
    docker image was patched rather than rebuilding from scratch because
    rebuilding the image will require resolving binary compatibility issues
    between the domain prediction tool and numpy.
