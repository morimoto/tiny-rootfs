${KEXEC}.tar.bz2:
	wget http://www.kernel.org/pub/linux/kernel/people/horms/kexec-tools/${KEXEC}.tar.bz2

${KEXEC}/Makefile: ${KEXEC}.tar.bz2
	tar -jxf ${KEXEC}.tar.bz2
	cd ${KEXEC}; LDFLAGS=-static ./configure --host=${HOST}

${KEXEC}/build/sbin/kexec: ${KEXEC}/Makefile
	cd ${KEXEC}; make

kexec_install: ${INSDIR}/sbin ${KEXEC}/build/sbin/kexec
	${TOP}/package/pinstall ${KEXEC}/build/sbin/kexec ${INSDIR}/sbin/
