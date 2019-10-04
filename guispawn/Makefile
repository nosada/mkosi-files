CONTAINER = $(notdir $(shell pwd))
MKOSI = mkosi.default.tmpl \
		mkosi.postinst \
		mkosi.extra \
		mkosi.nspawn
NSPAWN = ${CONTAINER} \
	${CONTAINER}.nspawn \
	tor-browser
MIRROR=$(shell reflector --age 12 --sort age --country $(shell where-am-i) --protocol https --protocol http | grep Server | head -1 | sed -e 's/^Server = \([a-z:/.]*\)\/.*$$/\1/')

all: image

prepare:
	[ -d tor-browser ] || git clone https://aur.archlinux.org/tor-browser.git
	[ -e tor-browser/*.pkg.tar.xz ] || (cd tor-browser; extra-x86_64-build)
	[ -e mkosi.extra/*.pkg.tar.xz ] || cp tor-browser/*.pkg.tar.xz mkosi.extra/
	reflector --age 12 --sort age --country $(shell where-am-i) --protocol https --protocol http > mkosi.extra/mirrorlist

image: ${MKOSI} prepare
	sed -e 's/CONTAINER_NAME/${CONTAINER}/g' -e 's|MIRROR|${MIRROR}|g' mkosi.default.tmpl > mkosi.default
	mkosi build

clean: ${NSPAWN}
	mkosi clean
	rm mkosi.default
	rm -rf tor-browser
	rm -f mkosi.extra/*.pkg.tar.xz
	rm -f mkosi.extra/mirrorlist

install: ${NSPAWN}
	machinectl import-raw ${CONTAINER}
	install -Dm644 -o root -g root \
		${CONTAINER}.nspawn /etc/systemd/nspawn/${CONTAINER}.nspawn

uninstall:
	machinectl remove ${CONTAINER}
