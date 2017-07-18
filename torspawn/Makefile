CONTAINER = $(notdir $(shell pwd))
MKOSI = mkosi.default \
		mkosi.postinst \
		mkosi.extra \
		mkosi.nspawn
NSPAWN = ${CONTAINER}.tar.xz \
	${CONTAINER}.nspawn

all: image

image: ${MKOSI}
	mkosi build

clean: ${NSPAWN}
	mkosi clean

install: ${NSPAWN}
	machinectl import-tar ${CONTAINER}.tar.xz
	install -Dm644 -o root -g root \
		${CONTAINER}.nspawn /etc/systemd/nspawn/${CONTAINER}.nspawn

uninstall:
	machinectl remove ${CONTAINER}
