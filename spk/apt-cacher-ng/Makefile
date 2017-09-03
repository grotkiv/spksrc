SPK_NAME = apt-cacher-ng
SPK_VERS = 3-5
SPK_REV = 1
SPK_ICON = src/apt-cacher-ng.png
DSM_UI_DIR = app

DEPENDS = cross/busybox cross/$(SPK_NAME)

MAINTAINER = grotkiv
DESCRIPTION = apt-cacher-ng is a proxy for apt-get that stores already downloaded debian packages to speed up further debian based installations.
ADMIN_PORT = 3142
RELOAD_UI = yes
DISPLAY_NAME = apt-cacher-ng
CHANGELOG = "1. Initial package"

HOMEPAGE = http://www.unix-ag.uni-kl.de/~bloch/acng/

INSTALLER_SCRIPT = src/installer.sh
SSS_SCRIPT       = src/dsm-control.sh
FWPORTS          = src/${SPK_NAME}.sc

INSTALL_PREFIX = /usr/local/$(SPK_NAME)

BUSYBOX_CONFIG = usrmng
ENV += BUSYBOX_CONFIG="$(BUSYBOX_CONFIG)"

include ../../mk/spksrc.spk.mk

