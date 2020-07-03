#!/bin/bash

set -xe

source "$(dirname $0)/mk-loopdev.sh"

DEB=$(realpath $1)
INT=$(realpath $2)
OUT=$(realpath $3)
DEVICE="$4"

TMP=$(mktemp -d)
TMPMNT=$(mktemp -d)
HERE=$(pwd)

cd ${TMP}
ar x ${DEB}
tar xf data.tar.*
cd ${HERE}

truncate --size 50M ${OUT}
mkfs.ext4 ${OUT}

LOOPDEV=$(mount_loopdev "$OUT" "$TMPMNT")

sudo mv ${TMP}/boot/* ${TMPMNT}
sudo mv ${TMPMNT}/vmlinuz-* ${TMPMNT}/vmlinuz
sudo mv ${TMP}/usr/lib/linux-image-*/allwinner/sun50i-a64-${DEVICE}.dtb ${TMPMNT}/dtb
sudo mv ${TMP}/lib/modules ${TMPMNT}/modules
sudo cp ${INT} ${TMPMNT}/initrd.img

cleanup_loopdev "$LOOPDEV"

echo "done"
