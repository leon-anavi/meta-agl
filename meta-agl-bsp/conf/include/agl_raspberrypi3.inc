# By default built kernel without DSI support for the official
# 7" Raspberry Pi touchscreen display. Set to 1 in local.conf
# to enable it.
ENABLE_DSI ?= "0"

# Maximum memory allowed to be assigned
GPU_MEM = "128"

ENABLE_CMA = "1"
# Add CMA to the kernel arguments for SOTA
OSTREE_KERNEL_ARGS_sota_append = " cma=256M"
CMA_LWM = "16"
CMA_HWM = "32"

MULTI_PROVIDER_WHITELIST += "virtual/libgl virtual/egl virtual/libgles1 virtual/libgles2"

# The correct config for a Raspberry Pi 3 in 32bit mode
UBOOT_MACHINE = "rpi_3_32b_config"

KERNEL_IMAGETYPE = "uImage"

MACHINE_FEATURES += "vc4graphics"

# For libomxil
#LICENSE_FLAGS_WHITELIST = "commercial"

IMAGE_INSTALL_append = " kernel-modules linux-firmware-rpidistro-bcm43430 linux-firmware-rpidistro-bcm43455 create-combined-dtb "

# Psplash causes crash on first boot on RPi
IMAGE_FEATURES_remove = "splash"

# Build updatable image. Only takes effect when sota.bbclass is inherited
DISTRO_FEATURES_append = " sota"

# Add overlays for 7inch touch
# https://github.com/k-quigley/linux/commits/rpi-4.14.y
python () {
    if d.getVar('ENABLE_DSI') == '1' and d.getVar('MACHINE') == 'raspberrypi3':
        d.appendVar('RPI_KERNEL_DEVICETREE_OVERLAYS', ' overlays/rpi-backlight.dtbo')
        d.appendVar('RPI_KERNEL_DEVICETREE_OVERLAYS', ' overlays/rpi-7inch.dtbo')
}

# Create WIC images to write to SD cards.
WKS_FILE = "sdimage-raspberrypi.wks"
AGL_EXTRA_IMAGE_FSTYPES = "wic.xz wic.bmap wic.xz.sha256sum"
IMAGE_BOOT_FILES = "bcm2835-bootfiles/* \
                 ${@make_dtb_boot_files(d)} \
                 ${@bb.utils.contains('KERNEL_IMAGETYPE', 'uImage', \
                    '${KERNEL_IMAGETYPE} u-boot.bin;${SDIMG_KERNELIMAGE} boot.scr', \
                    '${KERNEL_IMAGETYPE};${SDIMG_KERNELIMAGE}', d)} \
                 "
do_image_wic[depends] += " \
    bcm2835-bootfiles:do_deploy \
    ${@bb.utils.contains('KERNEL_IMAGETYPE', 'uImage', 'u-boot:do_deploy', '',d)} \
    "
