#!/bin/bash

set -xe

OUT=$(realpath $1)

TMP=$(mktemp -d)
HERE=$(pwd)
SCRIPT=$(dirname $(realpath $0))/build

mkdir ${TMP}/system
mkdir ${TMP}/partitions

TMPDOWN=$(mktemp -d)
cd $TMPDOWN
wget -O u.zip https://gitlab.com/pine64-org/u-boot/-/jobs/artifacts/universalsuperbox/testing-new-partitions/download?job=build
wget -O k.zip https://gitlab.com/pine64-org/linux/-/jobs/artifacts/pine64-kernel-ubports/download?job=build
unzip k.zip
unzip u.zip
ls .
cd $HERE

$SCRIPT/deb-to-bootimg.sh ${TMPDOWN}/linux-image-*-pine64_*.deb ${HERE}/initrd.img ${TMP}/partitions/boot.img
$SCRIPT/wget-extract-deb.sh http://repo.ubports.com/pool/xenial/main/l/linux-firmware-rtlwifi/linux-firmware-rtlwifi_20200316+0ubports0+0~xenial20200412191958.2~1.gbpdcaffd_all.deb ${TMP}/system
$SCRIPT/wget-extract-deb.sh http://repo.ubports.com/pool/xenial/main/l/linux-firmware-pine64-rtl8723-bt/linux-firmware-pine64-rtl8723-bt_20190223+0ubports0+0~xenial20200412190853.3~1.gbp327449_all.deb ${TMP}/system
$SCRIPT/mk-scr.sh uboot ${TMP}/partitions/

cp ${TMPDOWN}/u-boot-sunxi-with-spl-pinephone.bin ${TMP}/partitions/loader.img
cp recovery-pinephone.img ${TMP}/partitions/recovery.img
cp -av overlay/* ${TMP}/

$SCRIPT/build-tarball-mainline.sh pinephone ${OUT} ${TMP}

cd ${HERE}
rm -r ${TMP}
rm -r ${TMPDOWN}

echo "done"

