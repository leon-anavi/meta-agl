FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"

SRC_URI_append = "\
    file://wayland-client-protocol.h \
    "

do_compile_append() {
  cp ../wayland-client-protocol.h ../build/protocol/wayland-client-protocol.h
}
