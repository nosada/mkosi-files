# What's this?
Configs and files for generating archlinux container image by [mkosi](https://github.com/systemd/mkosi).

Expected to use this on Arch Linux.


# How to use
1. Install `base-devel`, `git`, `reflector` and `mkosi` (from AUR)
2. Clone this repository

After cloning it, you could do belows:

## Creating container image
```
$ cd <container_directory>
# make
```

## Importing built image
- Importing image via machinectl
- Putting nspawn config to /etc/systemd/nspawn/

```
$ cd <container_directory>
# make install
```

## Removing container image
- Removing image via machinectl
  - Nspawn config also deleted

```
$ cd <container_directory>
# make uninstall
```

## Cleaning built files
```
$ cd <container_directory>
# make clean
```


# Containers on this repository
- `buildspawn/`: for building archlinux packages
- `corespawn/`: basic container
- `mstdnspawn/`: (maybe) available as core of Mastodon instance
- `guispawn/`: run web browser (qutebrowser or chromium) with flashplugin inside nspawn container
- `torspawn/`: running tor and privoxy inside container
- `sngskspawn/`: content of https://sngsk.info
