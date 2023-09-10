# About `mstdnspawn/`

This attempts to create Mastodon instance as nspawn container via mkosi.

As a result of my poor skills, this becomes complicated. So I decide to write README.md for 'mstdnspawn'

## How to use

### New Mastodon instance

You must create `.env.production` and put it to `mkosi.extra` as `mastodon.env.production`.

`.env.production` is Mastodon configuration file. See https://docs.joinmastodon.org/admin/ for details.

After preparing `env.production`, simply run below:

```bash
sudo make                     # create nspawn container
sudo make install             # install nspawn container
machinectl start mstdnspawn   # run Mastodon instance
```

You must create DB for mastodon after started container.

### Use existing content in Mastodon instance

In this case, mastodon code tree and content of PostgreSQL DB are needed:

- `mkosi.extra/opt/mastodon`
  - Mastodon code tree: typically directory created by `git clone https://github.com/tootsuite/mastodon.git`
- `mkosi.extra/var/lib/postgres`
  - PostgreSQL DB data

Then simply run below (same of "New Mastodon instance"):

```bash
sudo make                     # create nspawn container
sudo make install             # install nspawn container
machinectl start mstdnspawn   # run Mastodon instance
```

## Notes

- You must set up reverse proxy for using this nspawn container as usuable Mastodon instance
  - See https://docs.joinmastodon.org/admin/ for more information
