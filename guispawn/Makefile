CONTAINER = $(notdir $(shell pwd))
MKOSI = mkosi.default.tmpl \
		mkosi.postinst \
		mkosi.extra \
		mkosi.nspawn
NSPAWN = ${CONTAINER} \
	${CONTAINER}.nspawn
MIRROR=$(shell reflector --age 12 --sort age --country $(shell where-am-i) --protocol https --protocol http | grep Server | head -1 | sed -e 's/^Server = \([a-z:/.]*\)\/.*$$/\1/')

all: image

image: ${MKOSI}
	sed -e 's/CONTAINER_NAME/${CONTAINER}/g' -e 's|MIRROR|${MIRROR}|g' mkosi.default.tmpl > mkosi.default
	mkosi build

clean: ${NSPAWN}
	mkosi clean
	rm mkosi.default

install: ${NSPAWN}
	/usr/lib/systemd/systemd-import raw ${CONTAINER}
	install -Dm644 -o root -g root \
		${CONTAINER}.nspawn /etc/systemd/nspawn/${CONTAINER}.nspawn

uninstall:
	machinectl remove ${CONTAINER}
