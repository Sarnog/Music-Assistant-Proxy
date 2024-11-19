#!/bin/sh

echo "Starting Music Assistant Proxy..."

# Activate virtual environment
. /opt/venv/bin/activate

# Get config values (using environment variables since we're not using bashio)
SERVER_IP=${SERVER_IP:-"localhost"}
SERVER_PORT=${SERVER_PORT:-8095}

echo "Configuration loaded:"
echo "Server IP: $SERVER_IP"
echo "Server Port: $SERVER_PORT"

# Start nginx
echo "Starting nginx..."
nginx

# Start the proxy
echo "Starting proxy..."
python /app/proxy.py --server-ip "$SERVER_IP" --server-port "$SERVER_PORT"
