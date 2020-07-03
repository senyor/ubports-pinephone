# PinePhone / PineTab

This repository is used for documentation, issue tracking, and project management for the [Pine64 PinePhone](https://www.pine64.org/pinephone/) and [Pine64 PineTab](https://www.pine64.org/pinetab/) ports of Ubuntu Touch. Unlike the other Community Ports repositories, it does not contain Android binaries for building system images.

This repository also contains configuration and scripts to build a device tarball, which is installed over an Ubuntu Touch tarball during a system-image installation process.

## How do I install Ubuntu Touch on my PinePhone?

Please note that our PinePhone images are currently **not suitable for daily use**. See [this repository's Issues tab][] for more information.

You will need a microSD card, 16GB or larger.

1. Download `ubuntu-touch-pinephone.img.gz` from [the latest rootfs-pinephone-systemimage build on UBports CI](https://ci.ubports.com/job/rootfs/job/rootfs-pinephone-systemimage/)
1. Flash `ubuntu-touch-pinephone.img` to your microSD card using [balenaEtcher](https://www.balena.io/etcher/), GNOME Disk Image Writer, or another method you are comfortable with.
1. Insert your microSD card into the slot on the rear of the PinePhone.
1. Boot your PinePhone.

It will eventually be possible to install Ubuntu Touch on the PinePhone via the UBports Installer. However, this method will likely perform the same steps as outlined here. Currently, we do not have a PinePhone in the hands of developers interested in the installer. This will change soon.

## How is the PinePhone image built?

Unlike our other supported devices, the PinePhone does not require the use of Android drivers or services. Therefore, building Halium for this device is not required. Instead, we build the images for the PinePhone using the `debos` configuration found in [ubports/core/rootfs-builder-debos on GitLab](https://gitlab.com/ubports/core/rootfs-builder-debos). See the `pine64-common.yaml` and `pinephone.yaml` files for the configuration, see the repository's `readme.md` file for information on building the images yourself.

The lack of Android also causes its own problems, which are tracked via the Issues page of this repository.

Additionally, we use the Mesa drivers to run on the PinePhone. The Mir backend for Mesa does not support Mir-on-Mir, which is used by all other supported devices to run applications. Applications running on the PinePhone use the Wayland protocol, not MirAL, to speak to Mir. Therefore, all of the issues posted in the [Waylandify project on UBports' GitHub](https://github.com/orgs/ubports/projects/16) affect Ubuntu Touch on the PinePhone.

## How does this repository work?

We track issues which are specific to the PinePhone in [this repository's Issues tab][]. We also add issues here which affect devices that do not use Android, but do not have their own tracker. For example, ["Image-based upgrades are not available"](https://gitlab.com/ubports/community-ports/pinephone/issues/1) affects all devices that do not use Android. However, there is currently no other place to put this issue on GitLab. It fits best here because the PinePhone is the most popular non-Android device, and the one people have the most questions about.

## How do I help make Ubuntu Touch on the PinePhone better?

Installing Ubuntu Touch on your PinePhone then reporting the issues you find here is a great first step! If you're not sure if an issue belongs here or somewhere on GitHub, you can contact us via any of our standard chats or forums:

* [UBports Forum](https://forums.ubports.com)
* `#ubports` on freenode IRC
* `#ubports:matrix.org` using Riot, FluffyChat, or your favorite Matrix client
* `@ubports` on Telegram

[this repository's Issues tab]: https://gitlab.com/ubports/community-ports/pinephone/issues

## What works, what doesn't?

And yes, the Pinephone is maybe not your daily driver yet. See the list to get an idea where we are!

### Working
* Actors: Manual brightness
* Actors: Notification LED
* Actors: Vibration
* Cellular: Carrier info, signal strength
* Cellular: Data connection
* Cellular: Incoming, outgoing calls
* Cellular: PIN unlock
* Cellular: SMS in, out
* Cellular: Voice in calls
* GPU: Boot into UI
* Misc: Battery percentage
* Misc: Charging
* Misc: Shutdown / Reboot
* Network:Flight mode
* Sensors: Automatic brightness
* Sensors: Proximity
* Sensors: Rotation
* Sensors: Touchscreen
* Sound: Loudspeaker
* Sound: Volume control

### Working but unstable/buggy
* Network: Bluetooth (only works after cold boot)
* Network: WiFi (only works well after warm reboot)
* Network: Hotspot

### Not working
* Actors: Torchlight
* Camera: Flashlight
* Camera: Photo
* Camera: Video
* Cellular: Change audio routings
* Cellular: MMS in, out
* GPU: Video acceleration
* Misc: Reset to factory defaults
* Sensors: GPS
* Sound: Earphones
* Sound: Microphone
* USB: MTP access
* USB: RNDIS access

## Building a device image

The remainder of the files in this repository build the PinePhone device tarball, which system-image installs alongside the Ubuntu Touch tarball to create the final Ubuntu Touch software on your device.

You can create a device tarball by running `./build.sh` in this repository. See the [.gitlab-ci.yml](.gitlab-ci.yml) file to see an example run of this script along with installation of dependencies. You will need sudoer rights to your machine, and the script will likely ask for your password before it finishes.

Currently this script will download a Linux kernel, u-boot, and recovery image from Pine64 or UBports CI, whichever is upstream. We would like to allow users to pack a local build of any of these items as well, and for that we welcome contributions.
