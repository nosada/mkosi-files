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
	mkosi --mirror ${MIRROR} build

clean: ${NSPAWN}
	mkosi clean
	rm -f ${CONTAINER}.nspawn
	rm -f mkosi.extra/etc/pacman.d/mirrorlist
	rm -rf ./mkosi-*
	git clean -df
	git reset --hard

install: ${NSPAWN}
	importctl -m import-tar ${CONTAINER}
	install -Dm644 -o root -g root \
		${CONTAINER}.nspawn /etc/systemd/nspawn/${CONTAINER}.nspawn

uninstall:
	machinectl show ${CONTAINER} > /dev/null && machinectl stop ${CONTAINER} || echo "${CONTAINER} not running; it's OK to uninstall"
	machinectl show ${CONTAINER} > /dev/null 2> /dev/null || machinectl show-image ${CONTAINER} > /dev/null && machinectl remove ${CONTAINER}
