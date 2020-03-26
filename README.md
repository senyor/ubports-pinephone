# PinePhone

This repository is used for documentation, issue tracking, and project management for the [Pine64 PinePhone](https://www.pine64.org/pinephone/) port of Ubuntu Touch. Unlike the other Community Ports repositories, it does not contain Android binaries for building system images.

## How do I install Ubuntu Touch on my PinePhone?

Please note that our PinePhone images are currently **not suitable for daily use**. See [this repository's Issues tab][] for more information. You must reinstall using these instructions often.

You will need a microSD card, 4GB or larger.

1. Download `ubuntu-touch-pinephone.img.gz` from [the latest rootfs-pinephone build on UBports CI](https://ci.ubports.com/job/rootfs/job/rootfs-pinephone/)
1. Extract `ubuntu-touch-pinephone.img.gz` to receive a 4GB file, `ubuntu-touch-pinephone.img`.
1. Flash `ubuntu-touch-pinephone.img` to your microSD card using [balenaEtcher](https://www.balena.io/etcher/), Disk Image Writer, `dd`, or another method you are comfortable with.
1. Insert your microSD card into the slot on the rear of the PinePhone.
1. Boot your PinePhone.

The default password is `phablet`.

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

And yes, the Pinephone is no daily driver yet. See the list to get an idea where we are!

### Working
* Actors: Manual brightness
* Actors: Notification LED
* Actors: Vibration
* Cellular: Carrier info, signal strength
* Cellular: Change audio routings
* Cellular: Data connection
* Cellular: Incoming, outgoing calls
* Cellular: PIN unlock
* Cellular: SMS in, out
* Cellular: Voice in calls
* GPU: Boot into UI
* Misc: Charging
* Misc: Shutdown / Reboot
* Network: WiFi (generally unstable)
* Sensors: Rotation
* Sensors: Touchscreen
* Sound: Loudspeaker
* Sound: Volume control

### Working but unstable/buggy
* Network: Bluetooth (only works after cold boot)
* Network: Hotspot
* Sensors: GPS

### Not working
* Actors: Torchlight
* Camera: Flashlight
* Camera: Photo
* Camera: Video
* Cellular: MMS in, out
* GPU: Video acceleration
* Misc: Battery percentage
* Misc: Reset to factory defaults
* Network:Flight mode
* Sensors: Automatic brightness
* Sensors: Proximity
* Sound: Earphones
* Sound: Microphone
* USB: MTP access
* USB: RNDIS access

