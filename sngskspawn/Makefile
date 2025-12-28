CONTAINER = $(notdir $(shell pwd))
MKOSI = mkosi.conf \
		mkosi.extra \
		mkosi.finalize.chroot \
		mkosi.repart \
		mkosi.nspawn
NSPAWN = ${CONTAINER} \
	${CONTAINER}.nspawn
MIRROR=$(shell grep Server /etc/pacman.d/mirrorlist | head -1 | cut -d ' ' -f 3 | cut -d '$$' -f 1)

all: image

prepare:
	cp /etc/pacman.d/mirrorlist mkosi.extra/etc/pacman.d/mirrorlist

image: ${MKOSI} prepare
	cp -f mkosi.extra/opt/sngsk.info/sngsk.info.service mkosi.extra/etc/systemd/system/sngsk.info.service
	cp -f mkosi.extra/opt/sngsk.info/nginx/container/nginx.conf mkosi.extra/etc/nginx/nginx.conf
	sed -i -e '/^pid/d' mkosi.extra/etc/nginx/nginx.conf
	mkosi --mirror ${MIRROR} build

clean: ${NSPAWN}
	mkosi clean
	rm -f ${CONTAINER}.nspawn
	rm -f mkosi.extra/etc/pacman.d/mirrorlist
	rm -f mkosi.extra/etc/systemd/system/sngsk.info.service
	rm -rf mkosi.extra/etc/nginx/nginx.conf
	rm -rf ./mkosi-*
	git clean -df
	git reset --hard

install: ${NSPAWN}
	machinectl import-tar ${CONTAINER}
	install -Dm644 -o root -g root \
		${CONTAINER}.nspawn /etc/systemd/nspawn/${CONTAINER}.nspawn

uninstall:
	machinectl stop ${CONTAINER}
	machinectl remove ${CONTAINER}
