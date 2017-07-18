# What's this?
Configs and files for generating simple archlinux container by [mkosi](https://github.com/systemd/mkosi).


# How to use
After cloning this repository, you would do:

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

## Remove container image
- removing image via machinectl
  - imply deletion of nspawn config

```
$ cd <container_directory>
# make uninstall
```

## Clean built files
```
$ cd <container_directory>
# make clean
```


# Containers on this repository
- `corespawn/`: basic container
- `buildspawn/`: basic container for building archlinux packages
- `torspawn/`: running tor and privoxy inside container
