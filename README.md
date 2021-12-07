# PinePhone / PineTab

This repository is used for documentation, issue tracking, and project management for the [Pine64 PinePhone](https://www.pine64.org/pinephone/) and [Pine64 PineTab](https://www.pine64.org/pinetab/) ports of Ubuntu Touch. Unlike the other Community Ports repositories, it does not contain Android binaries for building system images.

This repository also contains configuration and scripts to build a device tarball. Device tarballs are unpacked over an Ubuntu Touch tarball during a system-image installation process.

## How do I install Ubuntu Touch on my PinePhone?

You will need a microSD card, 8GB or larger.

1. Download `ubuntu-touch-pinephone.img.gz` from [the latest rootfs-pinephone-systemimage build on UBports CI](https://ci.ubports.com/job/rootfs/job/rootfs-pinephone-systemimage/)
1. Flash `ubuntu-touch-pinephone.img` to your microSD card using [balenaEtcher](https://www.balena.io/etcher/), GNOME Disk Image Writer, or another method you are comfortable with.
1. Insert your microSD card into the slot on the rear of the PinePhone.
1. Boot your PinePhone.

## How is the PinePhone image built?

Unlike our other supported devices, the PinePhone does not require Android drivers or services. Therefore, building Halium for this device is not required. Instead, we package the kernel, Trusted Firmware (specifically TF-A), platform initializer and bootloader (specifically u-boot), and device-specific configuration into an archive for installation via system-image. This repository builds that archive.

Our system-image-server picks up the archive built by this repository. It distributes the archive, an Ubuntu Touch mainline image, and the server configuration to devices.

The [`rootfs-pinephone-systemimage` job on UBports CI](https://ci.ubports.com/job/rootfs/job/rootfs-pinephone-systemimage/) installs the system-image-server's output to a flashable .img file, ready for your consumption.

The lack of Android, hardware design of the PinePhone, and our misassumptions cause problems on the PinePhone that are not experienced on other devices. We track them via [this repository's Issues tab][].

Additionally, we use the Mesa drivers to run graphical applications on the PinePhone. We experienced problems with our usual methods of running software via the mirclient protocol while using Mesa. Therefore, applications running on the PinePhone use the Wayland protocol to speak to Mir. The issues posed in the [Waylandify project on UBports' GitHub](https://github.com/orgs/ubports/projects/16) affect Ubuntu Touch on the PinePhone.

## How do I help make Ubuntu Touch on the PinePhone better?

Installing Ubuntu Touch on your PinePhone then reporting the issues you find here is a great first step! If you're not sure if an issue belongs here or somewhere on GitHub, you can contact us via any of our standard chats or forums:

* [UBports Forum](https://forums.ubports.com)
* `#ubports:matrix.org` using Riot, FluffyChat, or your favorite Matrix client
* `@ubports` on Telegram

## What works, what doesn't?

The PinePhone might not be ready to be your daily driver yet. You can see [its entry on devices.ubuntu-touch.io](https://devices.ubuntu-touch.io/device/pinephone/) to see what works and what doesn't.

## Building a device image

The remainder of the files in this repository build the PinePhone device tarball, which system-image installs alongside the Ubuntu Touch tarball to create the final Ubuntu Touch software on your device.

You can create a device tarball by running `./build.sh` in this repository. See the [.gitlab-ci.yml](.gitlab-ci.yml) file to see an example run of this script along with installation of dependencies. You will need sudoer rights to your machine, and the script will likely ask for your password before it finishes.

[this repository's Issues tab]: https://gitlab.com/ubports/community-ports/pinephone/issues
