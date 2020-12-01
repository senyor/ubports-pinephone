#!/bin/bash

set -xe

source "$(dirname $0)/mk-loopdev.sh"

SRC=$1
OUT=$2

TMP=$(mktemp -d)

truncate --size 500K scr.img
mkfs.ext4 scr.img

LOOPDEV=$(mount_loopdev scr.img "$TMP")

if [ "$device" = 'pinetab' ]; then
    cat "$SRC/boot-pinetab-prepend.txt" "$SRC/boot.txt" | sudo tee "$TMP/boot.txt"
else
    sudo cp "$SRC/boot.txt" "$TMP/boot.txt"
fi

sudo mkimage -A arm -O linux -T script -C none -n "U-Boot boot script" -d "$TMP/boot.txt" "$TMP/boot.scr"

cleanup_loopdev "$LOOPDEV"

mv scr.img $OUT

echo "done"
