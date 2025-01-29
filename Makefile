VERSION	= 1.0.1
BUSYVER	= 1.36.1
BUSYBOX	= busybox-${BUSYVER}
HOST	=
CROSS	=
TOP	= ${PWD}
INSDIR	= ${TOP}/tiny-rootfs-${VERSION}
PACKAGE = `ls -d ./package/pkg_*`

-include .config

#
# you can use cross compiler
# make HOST=${sh4-unknown-linux}
#
ifneq ($(HOST),)
CROSS := ${HOST}-
endif

all: ${BUSYBOX}/busybox
install: busybox_install

include ./package/*/Makefile

clean:
	sudo rm -fr ${INSDIR}
	rm -fr ${BUSYBOX}

mrproper: clean
	rm -fr ${BUSYBOX}.tar.bz2
