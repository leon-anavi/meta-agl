RDEPENDS_${PN}_append_sota += " u-boot-otascript"

# uprev firmware
RPIFW_DATE_raspberrypi3 = "20190517"
SRCREV_raspberrypi3 = "e1900836948f6c6bdf4571da1b966a9085c95d37"
SRC_URI[md5sum] = "ba272fed3661f0c8d5e4c424d2617246"
SRC_URI[sha256sum] = "2a4c566e98b16575ebf295b795b40a5772f81282948e957bdc9733cf72fdcd39"
PV_raspberrypi3 = "${RPIFW_DATE}"

RPIFW_DATE_raspberrypi4 = "20190709"
SRCREV_raspberrypi4 = "356f5c2880a3c7e8774025aa6fc934a617553e7b"
RPIFW_SRC_URI_raspberrypi4 = "https://github.com/raspberrypi/firmware/archive/${SRCREV}.tar.gz"
RPIFW_S_raspberrypi_4 = "${WORKDIR}/firmware-${SRCREV}"

SRC_URI_raspberrypi4 = "${RPIFW_SRC_URI}"
SRC_URI[md5sum] = "${@ '5962784e7963f0116cd1519e47749b25' if d.getVar('MACHINE_ARCH') == 'raspberrypi4' else 'ba272fed3661f0c8d5e4c424d2617246'}"
SRC_URI[sha256sum] = "${@ '6e07d98e4229ba7a1970a4c475fc6b8631823d200d3b8734a508e7ff5ea4c120' if d.getVar('MACHINE_ARCH') == 'raspberrypi4' else '2a4c566e98b16575ebf295b795b40a5772f81282948e957bdc9733cf72fdcd39'}"

PV_raspberrypi4 = "${RPIFW_DATE}"
