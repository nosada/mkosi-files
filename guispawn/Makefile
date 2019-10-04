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
	[ -e mkosi.builddir/PKGBUILD ] || git clone https://aur.archlinux.org/tor-browser.git mkosi.builddir
	echo "Server = ${MIRROR}/\$$repo/os/\$$arch" > mkosi.extra/mirrorlist

image: ${MKOSI} prepare
	sed -e 's/CONTAINER_NAME/${CONTAINER}/g' -e 's|MIRROR|${MIRROR}|g' mkosi.default.tmpl > mkosi.default
	mkosi -i build

clean: ${NSPAWN}
	mkosi clean
	rm mkosi.default
	rm mkosi.extra/mirrorlist
	rm -rf mkosi.builddir

install: ${NSPAWN}
	machinectl import-raw ${CONTAINER}
	install -Dm644 -o root -g root \
		${CONTAINER}.nspawn /etc/systemd/nspawn/${CONTAINER}.nspawn

uninstall:
	machinectl remove ${CONTAINER}
