#!/bin/bash

MASTODON_DIRECTORY="/opt/mastodon"

cd ${MASTODON_DIRECTORY}
RAILS_ENV=production bundle exec rake mastodon:daily
