${BUSYBOX}.tar.bz2:
	wget http://www.busybox.net/downloads/${BUSYBOX}.tar.bz2

${BUSYBOX}/.config: ${BUSYBOX}.tar.bz2
	tar -jxf ${BUSYBOX}.tar.bz2
	cp ./package/pkg_busybox/configs/config			$@
ifneq ($(HOST),)
	echo "CONFIG_CROSS_COMPILER_PREFIX=\"${HOST}-\""	>> $@
endif
	echo "CONFIG_PREFIX=\"${INSDIR}\""			>> $@
	cd ${BUSYBOX}; make oldconfig

${BUSYBOX}/busybox: ${BUSYBOX}/.config
	cd ${BUSYBOX}; make

insdirs ${INSDIR}/sbin ${INSDIR}/etc:
	mkdir -p ${INSDIR}/proc
	mkdir -p ${INSDIR}/mnt
	mkdir -p ${INSDIR}/home/user
	mkdir -p ${INSDIR}/root
	mkdir -p ${INSDIR}/var/log
	mkdir -p ${INSDIR}/tmp
	mkdir -p ${INSDIR}/etc
	mkdir -p ${INSDIR}/dev
	mkdir -p ${INSDIR}/sys
	mkdir -p ${INSDIR}/lib

busybox_install: insdirs ${BUSYBOX}/busybox
	${TOP}/package/pinstall ${TOP}/package/pkg_busybox/pkg/ ${INSDIR}/
	cd ${BUSYBOX}; make CONFIG_PREFIX=${INSDIR} install
	echo ${VERSION} > ${INSDIR}/etc/version
	sudo rm -fr ${INSDIR}/dev/console
	sudo mknod ${INSDIR}/dev/console c 5 1
