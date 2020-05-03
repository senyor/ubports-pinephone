#!/bin/bash

set -xe

DEB=$1
OUT=$(realpath $2)

TMP=$(mktemp -d)
HERE=$(pwd)
SCRIPT=$(dirname $(realpath $0))

cd ${TMP}
wget ${DEB}
$SCRIPT/extract-deb.sh ${TMP}/*.deb ${OUT}

cd ${HERE}
rm -r ${TMP}

echo "done"
