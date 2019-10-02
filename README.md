# What's this?
Configs and files for generating archlinux container image by [mkosi](https://github.com/systemd/mkosi).

Expected to be used on Arch Linux.


# How to use
1. Install `base-devel`, `git`, `reflector` and `mkosi` (from AUR)
2. If you want to use `guispawn` (explained in below), install `devtools` too
3. Clone this repository

After cloning it, you could do belows:

## Simple way
Invoke `update-nspawn-images` as root:

```
# update-nspawn-images CONTAINER OTHER_CONTAINER ...
```

where `CONTAINER` or `OTHER_CONTAINER` are nspawn container name in this repository.

Note that `update-nspawn-images` will install / update container image.


## Complicated way

### Create container image
```
$ cd CONTAINER/
# make
```

### Import built image
- Import container image via `machinectl`
- Install nspawn config to `/etc/systemd/nspawn/` as `CONTAINER.nspawn`

```
$ cd CONTAINER/
# make install
```

### Remove container image
- Remove container image via `machinectl`
- Delete nspawn config installed as `/etc/systemd/nspawn/CONTAINER.nspawn`

```
$ cd CONTAINER/
# make uninstall
```

### Clean built files
Delete container image and `mkosi.default` in `CONTAINER/`
```
$ cd CONTAINER/
# make clean
```


# Containers on this repository
- `buildspawn/`: environment to build Arch packages
- `corespawn/`: basic Arch container
- `mstdnspawn/`: configuable Mastodon instance
- `guispawn/`: running web browser (Tor browser or Chromium) with flashplugin inside nspawn container
- `tlspawn/`: container which includes Tex Live packages (`tl` is abbreviation of `Tex Live`)
- `torspawn/`: running tor and privoxy inside container
- `sngskspawn/`: application container used in https://sngsk.info

## Notes
Some environment variables are required to run X apps (i.e. qutebrowser or chromium) inside `guispawn`. Use below snippet:

```
$ machinectl shell \
	--setenv=display=:0 \
	--setenv=xauthority="\${HOME}/.xauthority" \
	--setenv=pulse_server=unix:/run/user/host/pulse/native \
	gui@guispawn /usr/bin/COMMAND ARGUMENTS
```
