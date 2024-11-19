#!/usr/bin/with-contenv bashio

bashio::log.info "Starting Music Assistant Proxy..."

# Get config values
export server=$(bashio::config 'server')
bashio::log.info "Server URL: ${server}"

# Generate Nginx configuration
envsubst '${server}' < /etc/nginx/templates/nginx.conf.gtpl > /etc/nginx/nginx.conf

# Start Nginx
exec "$@"
