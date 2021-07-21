VERSION	= 0.0.3
BUSYBOX	= busybox-1.33.1
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

mrproper: clean
	rm -fr ${BUSYBOX}.tar.bz2
