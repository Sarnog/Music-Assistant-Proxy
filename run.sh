#!/usr/bin/env sh

TARGET_IP=${TARGET_IP:-"192.168.1.72"}
TARGET_PORT=${TARGET_PORT:-"80"}

# Start a simple proxy using nc
while true; do
    # Listen for incoming requests
    nc -l -p 8080 | while read line; do
        # Forward the request to the Music Assistant
        curl -s -X "${line}" "http://${TARGET_IP}:${TARGET_PORT}" &
    done
done
