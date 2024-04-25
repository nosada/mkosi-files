
# What's this

[Mkosi](https://github.com/systemd/mkosi) configs and files for Arch Linux [systemd-nspawn](https://www.freedesktop.org/software/systemd/man/systemd-nspawn.html) images.

Expected to be used in Arch Linux box.

# How to use

1. Install `base-devel`, `git`
2. Install `mkosi` (or `mkosi-git` in AUR)
3. Clone this repository

After cloning it, you can do the followings:

## Simple way

Run `update-nspawn-images` as root:

```bash
update-nspawn-images CONTAINER [OTHER_CONTAINER ...]
```

where `CONTAINER` or `OTHER_CONTAINER` are nspawn container name in this repository.

`update-nspawn-images` will do below:

1. Build specified nspawn image
2. Remove existing image (nspawn container will be terminated)
3. Install new image and config

## Complicated way

### Create container image

```bash
cd CONTAINER/
sudo make
```

### Import built image

- Import container image via `machinectl`
- Install nspawn config to `/etc/systemd/nspawn/` as `CONTAINER.nspawn`

```bash
cd CONTAINER/
sudo make install
```

### Remove container image

- Remove container image via `machinectl`
- Delete nspawn config installed as `/etc/systemd/nspawn/CONTAINER.nspawn`

```bash
cd CONTAINER/
sudo make uninstall
```

### Clean built files

Delete container image and `mkosi.default` in `CONTAINER/`

```bash
cd CONTAINER/
sudo make clean
```

# Containers on this repository

- `corespawn/`: Basic Arch LInux container
- `mstdnspawn/`: Configuable Mastodon instance
- `guispawn/`: Packaging GUI apps. Currently only web browsers (Tor browser & Chromium)
- `tlspawn/`: Packaging Tex Live utilities
- `torspawn/`: Running Tor proxy (Tor + Privoxy; tcp:8118 opened)
- `sngskspawn/`: Web app run as [sngsk.info](https://sngsk.info)

## Notes

### Communicating outside container with `VirtualEthernet=yes`

See [this comment](https://github.com/nosada/mkosi-files/issues/6#issuecomment-706651468).

### Using `guispawn`

Some environment variables are required to run X apps. Use below snippet:

```bash
machinectl shell \
    --setenv=display=:0 \
    --setenv=xauthority="\${HOME}/.xauthority" \
    --setenv=pulse_server=unix:/run/user/host/pulse/native \
    gui@guispawn /usr/bin/COMMAND ARGUMENTS
```

Or you can use script `launch-app-in-container` like below:

```bash
launch-app-in-container COMMAND ARGUMENTS
```

This will do same thing of above snippet.
