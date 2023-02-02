# Mastodon docker-compose server

This runs the Mastodon web server, streaming API, a Caddy proxy frontend,
Redis, Elastisearch, and Sidekiq.

Expects to connect to a Linode managed Postgres cluster.

## Usage

1. `cp .env.template .env`
1. Edit `.env` to reflect the values for your instance
1. Look at the external volumes defined at the end of `docker-compose.yml`
   and run `docker volume create [vol-name]` for each of them.
1. `docker compose up -d`

You can then monitor the server logs with: `docker compose logs -f`
