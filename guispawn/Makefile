CONTAINER = $(notdir $(shell pwd))
MKOSI = mkosi.default.tmpl \
		mkosi.postinst \
		mkosi.extra \
		mkosi.nspawn
NSPAWN = ${CONTAINER} \
	${CONTAINER}.nspawn

all: image

image: ${MKOSI}
	sed -e 's/CONTAINER_NAME/${CONTAINER}/g' mkosi.default.tmpl > mkosi.default
	mkosi build

clean: ${NSPAWN}
	mkosi clean
	rm mkosi.default

install: ${NSPAWN}
	machinectl import-raw ${CONTAINER}
	install -Dm644 -o root -g root \
		${CONTAINER}.nspawn /etc/systemd/nspawn/${CONTAINER}.nspawn

uninstall:
	machinectl remove ${CONTAINER}
