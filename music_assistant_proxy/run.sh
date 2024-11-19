#!/usr/bin/with-contenv bashio

# Get config values
SERVER_IP=$(bashio::config 'server_ip')
SERVER_PORT=$(bashio::config 'server_port')

# Start nginx
nginx

# Start the proxy
python3 /app/proxy.py --server-ip "$SERVER_IP" --server-port "$SERVER_PORT"
