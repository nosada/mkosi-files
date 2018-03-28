CONTAINER = $(notdir $(shell pwd))
MKOSI = mkosi.default.tmpl \
		mkosi.postinst \
		mkosi.extra \
		mkosi.nspawn
NSPAWN = ${CONTAINER} \
	${CONTAINER}.nspawn
MIRROR=$(shell reflector --latest 10 --age 12 --sort rate | grep Server | grep https | grep -v uwaterloo | cut -d ' ' -f 3 | head -1 | cut -d '/' -f -3)

all: image

image: ${MKOSI}
	sed -e 's/CONTAINER_NAME/${CONTAINER}/g' -e 's|MIRROR|${MIRROR}|g' mkosi.default.tmpl > mkosi.default
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
