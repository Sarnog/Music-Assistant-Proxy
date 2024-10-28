#!/usr/bin/with-contenv sh

# Load environment variables
HOST=${music_assistant_host}
PORT=${music_assistant_port}

# Start Nginx
nginx -g 'daemon off;' &

# Wait for Nginx to start
sleep 5

# Start Music Assistant Proxy (adjust as necessary for your application)
curl -s "http://$HOST:$PORT" || {
    echo "Failed to connect to Music Assistant on $HOST:$PORT"
    exit 1
}

# Keep the script running
tail -f /dev/null
