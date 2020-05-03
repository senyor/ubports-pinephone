#!/bin/bash

set -xe

SRC=$1
OUT=$2

truncate --size 500K persist.img
mkfs.ext2 persist.img

mv persist.img $OUT

echo "done"
