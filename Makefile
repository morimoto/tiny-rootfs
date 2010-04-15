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

${BUSYBOX}.tar.bz2:
	wget http://www.busybox.net/downloads/${BUSYBOX}.tar.bz2

${BUSYBOX}/.config: ${BUSYBOX}.tar.bz2
	tar -jxf ${BUSYBOX}.tar.bz2
	cp ./busybox_config/${BUSYBOX}.config			$@
	echo "CONFIG_CROSS_COMPILER_PREFIX=\"${CROSS}\""	>> $@
	echo "CONFIG_PREFIX=\"${INSDIR}\""			>> $@
	cd ${BUSYBOX}; make oldconfig

${BUSYBOX}/busybox: ${BUSYBOX}/.config
	cd ${BUSYBOX}; make O=

${KEXEC}.tar.bz2:
	wget http://www.kernel.org/pub/linux/kernel/people/horms/kexec-tools/${KEXEC}.tar.bz2

${KEXEC}/Makefile: ${KEXEC}.tar.bz2
	tar -jxf ${KEXEC}.tar.bz2
	cd ${KEXEC}; LDFLAGS=-static ./configure --host=${HOST}

${KEXEC}/build/sbin/kexec: ${KEXEC}/Makefile
	cd ${KEXEC}; make

include ./package/*/Makefile

clean:
	sudo rm -fr ${INSDIR}
	rm -fr ${BUSYBOX}
	rm -fr ${KEXEC}

mrproper: clean
	rm -fr ${BUSYBOX}.tar.bz2
	rm -fr ${KEXEC}.tar.bz2
