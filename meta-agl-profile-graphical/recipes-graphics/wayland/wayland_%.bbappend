FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = "\
    file://0001-Change-socket-mode-add-rw-for-group.patch \
    file://0002-server-Fix-fake-Address-already-in-use-error.patch \
    "
