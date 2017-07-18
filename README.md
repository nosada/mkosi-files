# What's this?
Configs and files for generating simple archlinux container by [mkosi](https://github.com/systemd/mkosi).


# How to use
After cloning this repository, you would do:

## Creating container image
```
$ cd <container_directory>
# make
```

## Importing build image (via machinectl, and put nspawn config to /etc/systemd/nspawn/)
```
$ cd <container_directory>
# make install
```

## Remove container image (via machinectl)
```
$ cd <container_directory>
# make uninstall
```

## Remove container image (via machinectl)
```
$ cd <container_directory>
# make clean
```


# Containers on this repository
- `corespawn/`: basic container with neovim
- `buildspawn/`: basic container for building archlinux packages
- `torspawn/`: running tor and privoxy inside container
