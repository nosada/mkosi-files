#!/bin/bash

# cf.
# - https://github.com/tootsuite/documentation/blob/master/Running-Mastodon/Production-guide.md
# - https://wiki.archlinux.org/index.php/Mastodon

MASTODON_DIRECTORY="/opt/mastodon"
MASTDON_SERVICES=("web" "sidekiq" "streaming")

cd ${MASTODON_DIRECTORY}
MASTODON_VERSION=`git tag -l | grep -v 'rc[0-9]*$' | sort -V | tail -n 1`
git checkout ${MASTODON_VERSION}
bundle install --deployment --without development test
yarn install --pure-lockfile

for SERVICE in ${MASTODON_SERVICES};
do
	sed -i -e 's/CHANGEME/'${MASTODON_DIRECTORY}'/g/' /mastodon-${SERVICE}.service.tmpl /etc/systemd/system/mastodon-${SERVICE}.service
	systemctl daemon-reload
	systemctl enable mastodon-$SERVICE
done

systemctl disable set_up_mastodon.service
rm -f /etc/systemd/system/set_up_mastodon.service
systemctl daemon-reload
rm -f $0
