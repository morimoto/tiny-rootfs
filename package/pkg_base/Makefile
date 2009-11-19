install: ${BUSYBOX}/busybox
	mkdir -p ${INSDIR}
	cd ${INSDIR}; mkdir -p proc mnt home home/user root var var/log tmp etc dev sys lib
	${TOP}/package/pinstall ${TOP}/package/pkg_base/pkg/ ${INSDIR}/
	cd ${BUSYBOX}; make O= CONFIG_PREFIX=${INSDIR} install
	echo ${VERSION} > ${INSDIR}/etc/version
	sudo rm -fr ${INSDIR}/dev/console
	sudo mknod ${INSDIR}/dev/console c 5 1
