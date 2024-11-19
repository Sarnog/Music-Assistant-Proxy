#!/usr/bin/with-contenv bashio

echo "Starting Music Assistant Proxy..."

# Print Python version and pip list for debugging
python3 --version
pip3 list

# Get config values
SERVER_IP=$(bashio::config 'server_ip')
SERVER_PORT=$(bashio::config 'server_port')

echo "Configuration loaded:"
echo "Server IP: $SERVER_IP"
echo "Server Port: $SERVER_PORT"

# Start nginx
echo "Starting nginx..."
nginx

# Start the proxy
echo "Starting proxy..."
python3 /app/proxy.py --server-ip "$SERVER_IP" --server-port "$SERVER_PORT"
