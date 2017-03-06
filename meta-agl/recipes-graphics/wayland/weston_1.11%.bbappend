FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"

SRC_URI_append = "\
    file://0001-compositor-drm.c-Launch-without-input-devices-11.patch \
    file://weston.service \
    file://weston.ini \
    "

inherit systemd

SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE_${PN} = "weston.service"


EXTRA_OECONF_remove_rpi = "\
        --enable-rpi-compositor \
    WESTON_NATIVE_BACKEND=rpi-backend.so \
"

EXTRA_OECONF_append_rpi = "\
    WESTON_NATIVE_BACKEND=drm-backend.so \
    --disable-static \
"

CFLAGS_append_rpi ="\
    -I${STAGING_DIR_TARGET}/usr/include/interface/vcos/pthreads \
    -I${STAGING_DIR_TARGET}/usr/include/interface/vmcs_host/linux \
"

do_install_append() {
    # Install systemd unit files
    if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
        install -m 644 -p -D ${WORKDIR}/weston.service ${D}${systemd_system_unitdir}/weston.service
    fi

    WESTON_INI_CONFIG=${sysconfdir}/xdg/weston
    install -d ${D}${WESTON_INI_CONFIG}
    install -m 0644 ${WORKDIR}/weston.ini ${D}${WESTON_INI_CONFIG}/weston.ini
}

FILES_${PN} += " \
    ${sysconfdir}/xdg/weston/weston.ini \
    "
