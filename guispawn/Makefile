CONTAINER = $(notdir $(shell pwd))
MKOSI = mkosi.default.tmpl \
		mkosi.postinst \
		mkosi.extra \
		mkosi.nspawn
NSPAWN = ${CONTAINER} \
	${CONTAINER}.nspawn
MIRROR=$(shell grep Server /etc/pacman.d/mirrorlist | head -1 | cut -d ' ' -f 3 | cut -d '$$' -f 1)

all: image

prepare:
	[ -d aurpkg ] || mkdir aurpkg
	[ -d aurpkg/tor-browser ] || git clone https://aur.archlinux.org/tor-browser.git aurpkg/tor-browser
	cp /etc/pacman.d/mirrorlist mkosi.extra/mirrorlist
	sed -e 's;CONTAINER_NAME;${CONTAINER};g' -e 's;MIRROR;${MIRROR};g' mkosi.default.tmpl > mkosi.default

image: ${MKOSI} prepare
	mkosi build

clean: ${NSPAWN}
	mkosi clean
	rm mkosi.default
	rm mkosi.extra/mirrorlist
	rm -rf aurpkg

install: ${NSPAWN}
	machinectl import-raw ${CONTAINER}
	install -Dm644 -o root -g root \
		${CONTAINER}.nspawn /etc/systemd/nspawn/${CONTAINER}.nspawn

uninstall:
	machinectl remove ${CONTAINER}
