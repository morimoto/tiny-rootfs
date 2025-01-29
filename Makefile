VERSION	= 1.0.1
HOST	=
INSDIR	= ${PWD}/tiny-rootfs-${VERSION}
PACKAGE	= busybox hostcp

-include .config

all:	 busybox_all
install: busybox_install

include ./package/*/Makefile

clean:
	@echo clean install dir
	@sudo rm -fr ${INSDIR}
	@$(foreach pkg,$(PACKAGE),make -s ${pkg}_clean;)	# call xxx_clean

mrproper: clean
	@$(foreach pkg,$(PACKAGE),make -s ${pkg}_mrproper;)	# call xxx_mrproper
