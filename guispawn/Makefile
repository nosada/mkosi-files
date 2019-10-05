CONTAINER = $(notdir $(shell pwd))
MKOSI = mkosi.default.tmpl \
		mkosi.postinst \
		mkosi.extra \
		mkosi.nspawn
NSPAWN = ${CONTAINER} \
	${CONTAINER}.nspawn
MIRROR=$(shell reflector --age 12 --sort age --country $(shell where-am-i) --protocol https --protocol http | grep Server | head -1 | sed -e 's/^Server = \([a-z:/.]*\)\/.*$$/\1/')

all: image

prepare:
	[ -d aurpkg ] || git clone https://aur.archlinux.org/tor-browser.git aurpkg
	[ -d mkosi.builddir ] || mkdir -p mkosi.builddir
	echo "Server = ${MIRROR}/\$$repo/os/\$$arch" > mkosi.extra/mirrorlist
	sed -e 's;CONTAINER_NAME;${CONTAINER};g' -e 's;MIRROR;${MIRROR};g' mkosi.default.tmpl > mkosi.default

image: ${MKOSI} prepare
	mkosi build

clean: ${NSPAWN}
	mkosi clean
	rm mkosi.default
	rm mkosi.extra/mirrorlist
	rm -rf aurpkg
	[ -e ${CONTAINER}.cache-* ] && rm ${CONTAINER}.cache-*

install: ${NSPAWN}
	machinectl import-raw ${CONTAINER}
	install -Dm644 -o root -g root \
		${CONTAINER}.nspawn /etc/systemd/nspawn/${CONTAINER}.nspawn

uninstall:
	machinectl remove ${CONTAINER}
