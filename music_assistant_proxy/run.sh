#!/usr/bin/with-contenv bashio

echo "Starting Music Assistant Proxy..."

# Get config values
export SERVER_IP=$(bashio::config 'server_ip')
export SERVER_PORT=$(bashio::config 'server_port')

echo "Configuration loaded:"
echo "Server IP: $SERVER_IP"
echo "Server Port: $SERVER_PORT"

# Replace environment variables in nginx.conf
envsubst '$SERVER_IP $SERVER_PORT' < /etc/nginx/nginx.conf > /etc/nginx/nginx.conf.tmp
mv /etc/nginx/nginx.conf.tmp /etc/nginx/nginx.conf

# Start nginx
echo "Starting nginx..."
nginx

# Start the proxy
echo "Starting proxy..."
python3 /app/proxy.py --server-ip "$SERVER_IP" --server-port "$SERVER_PORT"
