## Introduction

The `meta-agl` layer provides the minimal set of software
to boot an AGL Distribution system.
You use this layer as the minimal core on which to build AGL profiles.

**NOTE:** The `meta-agl` layer does not include a reference UI.
  The reference UI is included as part of the
  [`meta-agl-demo`](./meta-agl-demo.html) layer.
  Furthermore, `meta-agl` does not include additional components, such
  as security, which are part of the
  `meta-agl-extra` layer.

## Sub-Layers

The `meta-agl` layer itself contains many sub-layers and files.
Following is a "tree" look at the layer:

```
.
├── docs
├── meta-agl
├── meta-agl-bsp
├── meta-agl-distro
├── meta-agl-profile-cluster
├── meta-agl-profile-cluster-qt5
├── meta-agl-profile-core
├── meta-agl-profile-graphical
├── meta-agl-profile-graphical-html5
├── meta-agl-profile-graphical-qt5
├── meta-agl-profile-hud
├── meta-agl-profile-telematics
├── meta-app-framework
├── meta-netboot
├── meta-security
├── README-AGL.md
├── README.md
├── scripts
├── templates
```

This list provides some overview information on the files and sub-layers
in `meta-agl`:

* `docs`: Contains files that support AGL documentation.
* `meta-agl`: Contains layer configuration for the `meta-agl` layer.
* `meta-agl-bsp`: Contains adaptations for recipes and required packages
  to boot an AGL distribution on targeted hardware and emulation (i.e. QEMU).
* `meta-agl-distro`: Contains distro configuration and supporting scripts.
* `meta-agl-profile-cluster`: The middleware for the AGL cluster profile.
  The set of packages required for AGL Cluster Distribution.
  Profiles include support for Wayland images.
* `meta-agl-profile-cluster-qt5`: The middleware for the AGL Qt5-based cluster profile.
  The set of packages required for AGL Qt5-based Cluster Distribution.
  Profiles include support for Wayland images with Qt5.
* `meta-agl-profile-core`: Configuration and recipes for the AGL core profiles.
* `meta-agl-profile-graphical`: Configuration and recipes supporting graphical user
  interfaces.
* `meta-agl-profile-graphical-html5`: Configuration and recipes supporting profiles
  with HTML user interface support.
* `meta-agl-profile-graphical-qt5`: Configuration and recipes supporting profiles
  with Qt5-based user interface support.
* `meta-agl-profile-hud`: Configuration and recipes supporting profiles with
  Head-Up-Display (HUD) support.
* `meta-agl-profile-telematics`: Configuration and recipes supporting profiles with
  telematics support.
* `meta-app-framework`: Configuration and recipes supporting the AGL Application
  Framework.
* `meta-netboot`: Contains recipes and configuration adjustments to allow network
  boot through network block device (NBD) since network file system (NFS) does not
  support security labels.
* `meta-security`: Configuration and recipes supporting security applications.
* `scripts`: AGL development setup and support scripts.
* `templates`: Base, feature, and machine templates used in the AGL development
  environment.

## Packagegroups

This section describes the AGL
[packagegroup](https://yoctoproject.org/docs/2.4.4/dev-manual/dev-manual.html#usingpoky-extend-customimage-customtasks)
design:

* packagegroup-agl-image-minimal

        packagegroup-agl-core-automotive.bb
        packagegroup-agl-core-connectivity.bb
        packagegroup-agl-core-graphics.bb
        packagegroup-agl-core-kernel.bb
        packagegroup-agl-core-multimedia.bb
        packagegroup-agl-core-navi-lbs.bb
        packagegroup-agl-core-os-commonlibs.bb
        packagegroup-agl-core-security.bb
        packagegroup-agl-core-speech-services.bb

  The previous list of Packagegroups are used to create the `agl-image-minimal` image,
  which is a small image just capable of allowing a device to boot.

  Subsystem should maintain packagegroup-agl-core-[subsystem].bb which should
  hold sufficient packages to build `agl-image-minimal`.

* packagegroup-agl-image-ivi

        packagegroup-agl-ivi-automotive.bb
        packagegroup-agl-ivi-connectivity.bb
        packagegroup-agl-ivi-graphics.bb
        packagegroup-agl-ivi-kernel.bb
        packagegroup-agl-ivi-multimedia.bb
        packagegroup-agl-ivi-navi-lbs.bb
        packagegroup-agl-ivi-os-commonlibs.bb
        packagegroup-agl-ivi-security.bb
        packagegroup-agl-ivi-speech-services.bb

  The previous list of Packagegroups are used to create the `agl-image-ivi`
  image, which is a baseline image (i.e. Service Layer and Operating System
  Layer defined in AGL Spec v1.0) for the AGL profiles.

* packagegroup-agl-test.bb

  Additional tools used in QA tests (for agl-image*-qa).

<!--
* packagegroup-ivi-common*

        packagegroup-ivi-common-core-automotive.bb
        packagegroup-ivi-common-core.bb
        packagegroup-ivi-common-core-connectivity.bb
        packagegroup-ivi-common-core-graphics.bb
        packagegroup-ivi-common-core-kernel.bb
        packagegroup-ivi-common-core-multimedia.bb
        packagegroup-ivi-common-core-navi-lbs.bb
        packagegroup-ivi-common-core-os-commonlibs.bb
        packagegroup-ivi-common-core-security.bb
        packagegroup-ivi-common-core-speech-services.bb
        packagegroup-ivi-common-test.bb

The previous Packagegroups pick up some packages from upstream
locations such as
[GENIVI Alliance](https://www.genivi.org/) and others.
The `meta-ivi-common` layer produces no image.
All the Packagegroups in this layer are aggregated to `packagegroup-ivi-common-core`,
which is included by the images and the two recipes  `agl-image-ivi.bb` and `agl-demo-platform.bb`.
-->
