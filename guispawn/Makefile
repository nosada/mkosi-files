CONTAINER = $(notdir $(shell pwd))
MKOSI = mkosi.conf \
		mkosi.build.chroot \
		mkosi.postinst.chroot \
		mkosi.extra \
		mkosi.repart \
		mkosi.nspawn
NSPAWN = ${CONTAINER} \
	${CONTAINER}.nspawn
MIRROR=$(shell grep Server /etc/pacman.d/mirrorlist | head -1 | cut -d ' ' -f 3 | cut -d '$$' -f 1)

all: image

prepare:
	[ -d aurpkg ] || mkdir aurpkg
	cp /etc/pacman.d/mirrorlist mkosi.extra/mirrorlist

tor-browser: prepare
	[ -d aurpkg/tor-browser-bin ] || git clone https://aur.archlinux.org/tor-browser-bin.git aurpkg/tor-browser-bin

aur: tor-browser

image: ${MKOSI} prepare aur
	mkosi --mirror ${MIRROR} build

clean: ${NSPAWN}
	mkosi clean
	rm -f ${CONTAINER}.nspawn
	rm -f mkosi.extra/mirrorlist
	rm -rf aurpkg
	rm -rf ./mkosi-*
	git clean -df
	git reset --hard

install: ${NSPAWN}
	machinectl import-raw ${CONTAINER}
	install -Dm644 -o root -g root \
		${CONTAINER}.nspawn /etc/systemd/nspawn/${CONTAINER}.nspawn

uninstall:
	machinectl show ${CONTAINER} > /dev/null && machinectl stop ${CONTAINER} || echo "${CONTAINER} not running; it's OK to uninstall"
	# `machinectl status` requires more time & resource to show; it's useful to "delay" checking that the container stoped correctly
	machinectl status ${CONTAINER} > /dev/null 2> /dev/null || machinectl show-image ${CONTAINER} > /dev/null && machinectl remove ${CONTAINER}
