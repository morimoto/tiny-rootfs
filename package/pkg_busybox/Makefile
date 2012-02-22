${BUSYBOX}.tar.bz2:
	wget http://www.busybox.net/downloads/${BUSYBOX}.tar.bz2

${BUSYBOX}/.config: ${BUSYBOX}.tar.bz2
	tar -jxf ${BUSYBOX}.tar.bz2
	cp ./package/pkg_busybox/configs/${BUSYBOX}.config	$@
	echo "CONFIG_CROSS_COMPILER_PREFIX=\"${CROSS}\""	>> $@
	echo "CONFIG_PREFIX=\"${INSDIR}\""			>> $@
	cd ${BUSYBOX}; make oldconfig

${BUSYBOX}/busybox: ${BUSYBOX}/.config
	cd ${BUSYBOX}; make O=

install: ${BUSYBOX}/busybox
	mkdir -p ${INSDIR}
	cd ${INSDIR}; mkdir -p proc mnt home home/user root var var/log tmp etc dev sys lib
	${TOP}/package/pinstall ${TOP}/package/pkg_busybox/pkg/ ${INSDIR}/
	cd ${BUSYBOX}; make O= CONFIG_PREFIX=${INSDIR} install
	echo ${VERSION} > ${INSDIR}/etc/version
	sudo rm -fr ${INSDIR}/dev/console
	sudo mknod ${INSDIR}/dev/console c 5 1
