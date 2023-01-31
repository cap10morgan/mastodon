echo "Checking if streaming API source code is patched for Postgres CA certificate..."
if grep -q 'pgConfigs.production.ssl = true' /mastodon/streaming/index.js; then
  echo "Patching streaming API source..."
  sed -i "s/pgConfigs.production.ssl = true/pgConfigs.production.ssl = { ca: fs.readFileSync('\/mastodon\/config\/pg-server-ca-certificate.crt').toString(), }/" /mastodon/streaming/index.js
else
  echo "Streaming API source is already patched"
fi

