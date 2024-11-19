#!/usr/bin/with-contenv bashio

# Configure bash to log everything
exec 1> >(logger -s -t $(basename $0)) 2>&1

echo "Starting Music Assistant Proxy..."

# Get config values
if bashio::config.has_value "server_ip"; then
    export SERVER_IP=$(bashio::config 'server_ip')
else
    bashio::log.error "Server IP is not configured"
    exit 1
fi

export SERVER_PORT=$(bashio::config 'server_port')

bashio::log.info "Configuration loaded:"
bashio::log.info "Server IP: $SERVER_IP"
bashio::log.info "Server Port: $SERVER_PORT"

# Replace environment variables in nginx.conf
envsubst '$SERVER_IP $SERVER_PORT' < /etc/nginx/nginx.conf > /etc/nginx/nginx.conf.tmp
mv /etc/nginx/nginx.conf.tmp /etc/nginx/nginx.conf

# Start nginx
bashio::log.info "Starting nginx..."
nginx

# Start the proxy
bashio::log.info "Starting proxy..."
python3 /app/proxy.py --server-ip "$SERVER_IP" --server-port "$SERVER_PORT"
