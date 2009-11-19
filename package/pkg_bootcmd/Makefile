bootcmd_install: ${KEXEC}/build/sbin/kexec install
	${TOP}/package/pinstall ${TOP}/package/pkg_bootcmd/pkg/   ${INSDIR}/
	cd ${INSDIR}; mkdir -p var/run/udhcpc
	cp ${KEXEC}/build/sbin/kexec ${INSDIR}/usr/bin/
	${CROSS}strip ${INSDIR}/usr/bin/kexec
