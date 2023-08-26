CONTAINER = $(notdir $(shell pwd))
MKOSI = mkosi.conf \
		mkosi.postinst \
		mkosi.extra \
		mkosi.nspawn
NSPAWN = ${CONTAINER} \
	${CONTAINER}.nspawn
MIRROR=$(shell grep Server /etc/pacman.d/mirrorlist | head -1 | cut -d ' ' -f 3 | cut -d '$$' -f 1)

all: image

prepare:
	cp /etc/pacman.d/mirrorlist mkosi.extra/mirrorlist

image: ${MKOSI} prepare
	mkosi --mirror ${MIRROR} --output ${CONTAINER} build

clean: ${NSPAWN}
	mkosi --output ${CONTAINER} clean
	rm -f mkosi.extra/mirrorlist
	rm -rf ./mkosi-*

install: ${NSPAWN}
	machinectl import-raw ${CONTAINER}
	install -Dm644 -o root -g root \
		${CONTAINER}.nspawn /etc/systemd/nspawn/${CONTAINER}.nspawn

uninstall:
	machinectl remove ${CONTAINER}
