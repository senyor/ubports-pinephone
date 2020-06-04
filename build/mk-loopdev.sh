#!/bin/bash

# Functions to create and mount a loop device.
# Useful in Docker containers where /dev/loop cannot be populated after the
# container starts so manual losetup is needed.

# Mounts $1 at $2, taking care of silly loopdev creation.
# Echoes the name of the created loop device. Send this back to cleanup_loopdev()
# when you're finished.
# $1: Image file to mount
# $2: Desired point to mount image file to
mount_loopdev() {
    IMG="$1"
    MOUNTPOINT="$2"

    TMP=$(mktemp -d)
    NEXTLOOP=$(sudo losetup -f) || return 1
    NEXTLOOPNUM=$(echo "$NEXTLOOP" | cut -b 10-14)
    LOOPDEV="$TMP/mk-loopdev-loop$NEXTLOOPNUM"

    sudo mknod "$LOOPDEV" b 7 "$NEXTLOOPNUM" || return 1
    sudo losetup "$LOOPDEV" "$IMG" || return 1
    sudo mount "$LOOPDEV" "$MOUNTPOINT" || return 1

    echo "$LOOPDEV"
    return 0
}

# Cleans up and removes a loopdev created by mount_loopdev.
# $1: Value echoed by mount_loopdev()
cleanup_loopdev() {
    LOOPDEV="$1"

    sudo umount "$LOOPDEV" || return 1
    sudo losetup -d "$LOOPDEV" || return 1

    return 0
}
