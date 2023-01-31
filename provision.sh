#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

if [ -z "${MASTODON_ADMIN_USERNAME:-}" ]; then
  echo "MASTODON_ADMIN_USERNAME env var must be set"
  exit 1
fi

if [ -z "${MASTODON_ADMIN_EMAIL:-}" ]; then
  echo "MASTODON_ADMIN_EMAIL env var must be set"
  exit 1
fi

echo "Creating Postgres DB..."
bundle exec rake db:create

echo "Migrating database..."
bundle exec rake db:migrate

echo "Checking if provisioning is required..."
CHECK=$(bin/tootctl accounts approve $MASTODON_ADMIN_USERNAME || true)

if [ "${CHECK}" = "No such account" ]; then
  echo "Provisioning mastodon..."

  bin/tootctl accounts create ${MASTODON_ADMIN_USERNAME:-} --email ${MASTODON_ADMIN_EMAIL:-} --confirmed --role Owner

  echo "Provisioning done"
else
  echo "Provisioning not required"
fi


