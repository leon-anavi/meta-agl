FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "\
    file://e2fsck.conf \
    file://canbus-can.network \
    ${@bb.utils.contains('VIRTUAL-RUNTIME_net_manager','systemd','file://wired.network','',d)} \
"

# enable networkd/resolved support
PACKAGECONFIG_append_pn-systemd = " \
   ${@bb.utils.contains('VIRTUAL-RUNTIME_net_manager','systemd','networkd resolved','',d)} \
"

do_install_append() {
    # Install /etc/e2fsck.conf to avoid boot stuck by wrong clock time
    install -m 644 -p -D ${WORKDIR}/e2fsck.conf ${D}${sysconfdir}/e2fsck.conf

    # Install canbus network script
    install -m 0644 ${WORKDIR}/canbus-can.network ${D}${base_libdir}/systemd/network/60-canbus-can.network

    if ${@bb.utils.contains('VIRTUAL-RUNTIME_net_manager','systemd','true','false',d)}; then
       # Install DHCP configuration for Ethernet adapters
       install -m 644 ${WORKDIR}/wired.network ${D}${sysconfdir}/systemd/network
    fi
}

FILES_${PN} += "${sysconfdir}/e2fsck.conf "

# SPEC-737: connmand also has a NTP client which races with systemd-timesyncd
PACKAGECONFIG_remove = "timesyncd"

# Enable systemd-coredump when agl-devel is set on
PACKAGECONFIG_append_agl-devel = " coredump"
