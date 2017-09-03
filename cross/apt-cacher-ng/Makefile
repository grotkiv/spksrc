PKG_NAME = apt-cacher-ng
PKG_VERS = 3-5
PKG_EXT = tar.gz
PKG_DOWNLOAD_METHOD = git
PKG_GIT_HASH = eba47b1

PKG_DIST_SITE = https://alioth.debian.org/anonscm/git/apt-cacher-ng/apt-cacher-ng.git
PKG_DIST_FILE = $(PKG_NAME)-git$(PKG_GIT_HASH).$(PKG_EXT)
PKG_DIR = $(PKG_NAME)-git$(PKG_GIT_HASH)

DEPENDS = cross/openssl cross/fuse

HOMEPAGE = http://www.unix-ag.uni-kl.de/~bloch/acng/
COMMENT  = A caching proxy for apt.

CONFIGURE_TARGET = myConfigure
INSTALL_TARGET = myInstall

include ../../mk/spksrc.cross-cc.mk

.PHONY: myConfigure
myConfigure:
	$(RUN) cmake . -DCMAKE_BUILD_TYPE=Release

.PHONY: myInstall
myInstall:
	$(RUN) make install DESTDIR=$(INSTALL_DIR)/$(INSTALL_PREFIX)
