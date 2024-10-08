#!/bin/bash

# Prune remote statuses that never interacted with a local user
docker compose exec mastodon-web tootctl accounts prune

# Remove remote statuses that local user never interacted with older than 14 days
docker compose exec mastodon-web tootctl statuses remove --days 14

# Remove media attachments older than 14 days
docker compose exec mastodon-web tootctl media remove --days 14

# Remove all headers (including people I follow) older than 14 days
docker compose exec mastodon-web tootctl media remove --remove-headers --include-follows --days 14

# Remove link previews older than 14 days
docker compose exec mastodon-web tootctl preview_cards remove --days 14

# Remvoe files not linked to any post
docker compose exec mastodon-web tootctl media remove-orphans

