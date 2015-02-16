${ALSA-LIB}.tar.bz2:
	wget ftp://ftp.alsa-project.org/pub/lib/${ALSA-LIB}.tar.bz2

${ALSA-UTIL}.tar.bz2:
	wget ftp://ftp.alsa-project.org/pub/utils/${ALSA-UTIL}.tar.bz2

${ALSA-DIR}:
	mkdir ${ALSA-DIR}

${ALSA-DIR}/usr/include ${ALSA-DIR}/usr/lib: ${ALSA-LIB}/Makefile
	cd ${ALSA-LIB};\
	make;\
	make DESTDIR=${TOP}/${ALSA-DIR} install-strip

${ALSA-DIR}/usr/bin/aplay ${ALSA-DIR}/usr/bin/arecord ${ALSA-DIR}/usr/bin/amixer: ${ALSA-UTIL}/Makefile
	cd ${ALSA-UTIL};\
	make;\
	make DESTDIR=${TOP}/${ALSA-DIR} install-strip;\
	rm -fr ${TOP}/${ALSA-DIR}/usr/share/locale;\
	rm -fr ${TOP}/${ALSA-DIR}/usr/share/man;
	${CROSS}strip $@

${ALSA-LIB}/configure: ${ALSA-LIB}.tar.bz2
	tar -jxf ${ALSA-LIB}.tar.bz2

${ALSA-UTIL}/configure: ${ALSA-UTIL}.tar.bz2
	tar -jxf ${ALSA-UTIL}.tar.bz2

# use statically link
${ALSA-LIB}/Makefile: ${ALSA-LIB}/configure
	cd ${ALSA-LIB};\
	./configure --host=${HOST} --enable-shared=no --enable-static=yes

${ALSA-UTIL}/Makefile: ${ALSA-UTIL}/configure
	cd ${ALSA-UTIL};\
	./configure	--host=${HOST} --with-alsa-prefix=${TOP}/${ALSA-DIR}/usr/lib \
			--with-alsa-inc-prefix=${TOP}/${ALSA-DIR}/usr/include --disable-alsamixer \
			--disable-xmlto --without-udev-rules-dir --disable-nls \
			LDFLAGS="-static"

alsa_install: ${ALSA-DIR} ${ALSA-DIR}/usr/bin/aplay ${ALSA-DIR}/usr/bin/arecord ${ALSA-DIR}/usr/bin/amixer
	${TOP}/package/pinstall ${ALSA-DIR}/usr/share		${INSDIR}/usr;\
	${TOP}/package/pinstall ${ALSA-DIR}/usr/bin/aplay	${INSDIR}/usr/bin/;\
	${TOP}/package/pinstall ${ALSA-DIR}/usr/bin/arecord	${INSDIR}/usr/bin/;\
	${TOP}/package/pinstall ${ALSA-DIR}/usr/bin/amixer	${INSDIR}/usr/bin/
