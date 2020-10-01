CONTAINER = $(notdir $(shell pwd))
MKOSI = mkosi.default.tmpl \
		mkosi.postinst \
		mkosi.extra \
		mkosi.nspawn
NSPAWN = ${CONTAINER} \
	${CONTAINER}.nspawn
MIRROR=$(shell reflector --age 12 --sort age --country $(shell where-am-i) --protocol https --protocol http | grep Server | head -1 | cut -d ' ' -f 3 | cut -d '$$' -f 1)

all: image

prepare:
	echo "Server = ${MIRROR}/\$$repo/os/\$$arch" > mkosi.extra/mirrorlist

image: ${MKOSI} prepare
	sed -e 's;CONTAINER_NAME;${CONTAINER};g' -e 's;MIRROR;${MIRROR};g' mkosi.default.tmpl > mkosi.default
	mkosi build

clean: ${NSPAWN}
	mkosi clean
	rm mkosi.default
	rm mkosi.extra/mirrorlist

install: ${NSPAWN}
	machinectl import-raw ${CONTAINER}
	install -Dm644 -o root -g root \
		${CONTAINER}.nspawn /etc/systemd/nspawn/${CONTAINER}.nspawn

uninstall:
	machinectl remove ${CONTAINER}
