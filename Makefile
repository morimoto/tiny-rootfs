VERSION	= 0.0.3
KEXEC	= kexec-tools-2.0.1
BUSYBOX	= busybox-1.33.1
ALSA-LIB= alsa-lib-1.0.27
ALSA-UTIL= alsa-utils-1.0.27
ALSA-DIR= alsa-dir
HOST	=
CROSS	=
O	=
TOP	= ${PWD}
INSDIR	= ${TOP}/initramfs
PACKAGE = `ls -d ./package/pkg_*`

-include .config

#
# you can change install dir
# make O=${PATH}
#
ifneq ($(O),)
INSDIR := $(shell mkdir -p ${O} && cd ${O} && /bin/pwd)
$(if $(INSDIR),, \
     $(error output directory "$(O)" does not exist))
endif

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
	rm -fr ${KEXEC}
	rm -fr ${ALSA-LIB}
	rm -fr ${ALSA-UTIL}
	rm -fr ${ALSA-DIR}
	rm -fr ${ALSA-DIR}no

mrproper: clean
	rm -fr ${BUSYBOX}.tar.bz2
	rm -fr ${KEXEC}.tar.bz2
	rm -fr ${ALSA-LIB}.tar.bz2
	rm -fr ${ALSA-UTIL}.tar.bz2
