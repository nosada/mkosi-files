#!/bin/bash

MASTODON_DIRECTORY="/opt/mastodon"

sudo systemctl stop mastodon-web.service
sudo systemctl stop mastodon-sidekiq.service
sudo systemctl stop mastodon-streaming.service

cd ${MASTODON_DIRECTORY}
bundle install --path vendor/bundle
RAILS_ENV=production bundle exec rails db:migrate
yarn install --pure-lockfile
RAILS_ENV=production bundle exec rails assets:precompile

sudo systemctl start mastodon-web.service
sudo systemctl start mastodon-sidekiq.service
sudo systemctl start mastodon-streaming.service
