#!/bin/bash

set -xe

SRC=$1
OUT=$2

truncate --size 500K scr.img
mkfs.ext4 scr.img

mkdir mnt
sudo mount scr.img mnt

sudo mkimage -A arm -O linux -T script -C none -n "U-Boot boot script" -d $SRC/boot.txt mnt/boot.scr
ls mnt

sudo umount mnt
rm -r mnt

mv scr.img $OUT

echo "done"
