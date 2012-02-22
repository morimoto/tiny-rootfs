VERSION	= 0.0.1
KEXEC	= kexec-tools-2.0.1
BUSYBOX	= busybox-1.16.0
HOST	=
CROSS	=
O	=
INSDIR	= $(shell pwd)/initramfs
PACKAGE = `ls -d ./package/pkg_*`
TOP	= `pwd`

-include .config

#
# you can change install dir
# make O=${PATH}
#
ifneq ($(O),)
INSDIR := $(shell cd ${O} && /bin/pwd)
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

mrproper: clean
	rm -fr ${BUSYBOX}.tar.bz2
	rm -fr ${KEXEC}.tar.bz2
