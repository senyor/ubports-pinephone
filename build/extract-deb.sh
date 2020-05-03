#!/bin/bash

set -xe

DEB=$(realpath $1)
OUT=$(realpath $2)

TMP=$(mktemp -d)
HERE=$(pwd)

mkdir ${OUT} || true

cd ${TMP}
ar x ${DEB}

cd ${OUT}
tar xf ${TMP}/data.tar.*

cd ${HERE}

rm -r ${TMP}

