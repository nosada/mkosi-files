# About `mstdnspawn/`
This attempts to create Mastodon instance as nspawn container via mkosi.

As a result of my poor skills, this becomes complicated. So I decide to write README.md for 'mstdnspawn'


## How to use

### New Mastodon instance
You must create `.env.production` and put it to `mkosi.extra` as `mastodon.env.production`.

`.env.production` is config of Mastodon. See https://github.com/tootsuite/documentation/blob/master/Running-Mastodon/Production-guide.md for more information & contents.

After crerating `env.production`, simply run below:
```
$ sudo make			# create nspawn container
$ sudo make install 		# install nspawn container
$ machinectl start mstdnspawn	# run Mastodon instance
```

You must create DB for mastodon after started container.

### Use existing content in Mastodon instance
In this case, mastodon code tree and  content of PostgreSQL DB are needed:

- mastodon code tree: typically directory created by `git clone https://github.com/tootsuite/mastodon.git`
- content of PostgreSQL DB: directory such as `/var/lib/postgres/`, etc.

and above 2 directories are put to `mkosi.extra` as `mastodon` (mastodon code tree) and `postgres` (content of PostgreSQL DB).

Then simply run below (same of "New Mastodon instance"):
```
$ sudo make			# create nspawn container
$ sudo make install 		# install nspawn container
$ machinectl start mstdnspawn	# run Mastodon instance
```

### After started container
Do below:
```
$ machinectl login mstdonspawn
(login to container as 'mastodon')
$ sudo /opt/bin/post_installation.sh
```

Accounts for loggin in to container is defined at `mkosi.postinst`.


## Notes
- You must set up reverse proxy for using this nspawn container as usuable Mastodon instance
  - See https://github.com/tootsuite/documentation/blob/master/Running-Mastodon/Production-guide.md
