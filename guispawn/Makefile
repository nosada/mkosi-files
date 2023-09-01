CONTAINER = $(notdir $(shell pwd))
MKOSI = mkosi.conf \
		mkosi.postinst \
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
	[ -d aurpkg/tor-browser ] || git clone https://aur.archlinux.org/tor-browser.git aurpkg/tor-browser

aur: tor-browser

image: ${MKOSI} prepare aur
	[[ $(shell mkosi --version | awk '{print $$2}' | cut -d . -f 1) -lt 15 ]] && sed -e 's/\(Format=\).*/\1raw_btrfs/g' -i mkosi.conf
	mkosi --mirror ${MIRROR} --output ${CONTAINER} build

clean: ${NSPAWN}
	mkosi --output ${CONTAINER} clean
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
	machinectl remove ${CONTAINER}
