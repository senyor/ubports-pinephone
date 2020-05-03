#!/bin/bash

set -xe

DEB=$(realpath $1)
INT=$(realpath $2)
OUT=$(realpath $3)

TMP=$(mktemp -d)
TMPMNT=$(mktemp -d)
HERE=$(pwd)

cd ${TMP}
ar x ${DEB}
tar xf data.tar.*
cd ${HERE}

truncate --size 50M ${OUT}
mkfs.ext4 ${OUT}

sudo mount ${OUT} ${TMPMNT}

sudo mv ${TMP}/boot/* ${TMPMNT}
sudo mv ${TMPMNT}/vmlinuz-* ${TMPMNT}/vmlinuz
sudo mv ${TMP}/usr/lib/linux-image-*/allwinner/sun50i-a64-pinephone-1.1.dtb ${TMPMNT}/dtb
sudo mv ${TMP}/lib/modules ${TMPMNT}/modules
sudo cp ${INT} ${TMPMNT}/

sudo umount ${TMPMNT}
rm -r ${TMPMNT}
rm -r ${TMP}

echo "done"
