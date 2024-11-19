#!/usr/bin/with-contenv bashio

# Get config values
bashio::config.require 'server'
export MUSIC_ASSISTANT_SERVER=$(bashio::config 'server')

bashio::log.info "Starting Music Assistant Proxy..."
bashio::log.info "Server URL: ${MUSIC_ASSISTANT_SERVER}"

# Generate Nginx configuration
envsubst '${MUSIC_ASSISTANT_SERVER}' < /etc/nginx/nginx.conf.gtpl > /etc/nginx/nginx.conf

# Start Nginx
exec "$@"
