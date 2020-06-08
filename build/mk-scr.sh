#!/bin/bash

set -xe

source "$(dirname $0)/mk-loopdev.sh"

SRC=$1
OUT=$2

TMP=$(mktemp -d)

truncate --size 500K scr.img
mkfs.ext4 scr.img

LOOPDEV=$(mount_loopdev scr.img "$TMP")

sudo mkimage -A arm -O linux -T script -C none -n "U-Boot boot script" -d $SRC/boot.txt "$TMP/boot.scr"

cleanup_loopdev "$LOOPDEV"

mv scr.img $OUT

echo "done"
