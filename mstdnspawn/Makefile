CONTAINER = $(notdir $(shell pwd))
MKOSI = mkosi.conf \
		mkosi.finalize\
		mkosi.extra \
		mkosi.repart \
		mkosi.nspawn
NSPAWN = ${CONTAINER} \
	${CONTAINER}.nspawn
MIRROR=$(shell grep Server /etc/pacman.d/mirrorlist | head -1 | cut -d ' ' -f 3 | cut -d '$$' -f 1)

all: image

prepare:
	cp /etc/pacman.d/mirrorlist mkosi.extra/etc/pacman.d/mirrorlist

image: ${MKOSI} prepare
	[[ $(shell mkosi --version | awk '{print $$2}' | cut -d . -f 1) -lt 15 ]] && sed -e 's/\(Format=\).*/\1raw_btrfs/g' -i mkosi.conf || exit 0
	mkosi --mirror ${MIRROR} build

clean: ${NSPAWN}
	mkosi clean
	rm -f mkosi.extra/etc/pacman.d/mirrorlist
	rm -rf ./mkosi-*
	git clean -df
	git reset --hard

install: ${NSPAWN}
	machinectl import-raw ${CONTAINER}
	install -Dm644 -o root -g root \
		${CONTAINER}.nspawn /etc/systemd/nspawn/${CONTAINER}.nspawn

uninstall:
	machinectl remove ${CONTAINER}
