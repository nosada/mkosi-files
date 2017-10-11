# What's this?
Configs and files for generating simple archlinux container by [mkosi](https://github.com/systemd/mkosi).


# How to use
After cloning this repository, you could do belows:

## Creating container image
```
$ cd <container_directory>
# make
```

## Importing built image
- importing image via machinectl
- putting nspawn config to /etc/systemd/nspawn/

```
$ cd <container_directory>
# make install
```

## Removing container image
- removing image via machinectl
  - imply deletion of nspawn config

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
- `torspawn/`: running tor and privoxy inside container
- `sngskspawn/`: content of https://sngsk.info
