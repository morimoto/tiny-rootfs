VERSION	= 1.0.1
BUSYVER	= 1.36.1
BUSYBOX	= busybox-${BUSYVER}
HOST	=
INSDIR	= ${PWD}/tiny-rootfs-${VERSION}

-include .config

all: ${BUSYBOX}/busybox
install: busybox_install

include ./package/*/Makefile

clean:
	sudo rm -fr ${INSDIR}
	rm -fr ${BUSYBOX}

mrproper: clean
	rm -fr ${BUSYBOX}.tar.bz2
