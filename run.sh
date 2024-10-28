#!/usr/bin/env bash

TARGET_IP=${TARGET_IP:-"192.168.1.72"}
TARGET_PORT=${TARGET_PORT:-"8095"}

# Start a simple proxy using curl
while true; do
    # Use a simple HTTP server to listen for requests
    nc -l -p 8080 | while read line; do
        # Forward the request to the Music Assistant
        curl -s -X "${line}" "http://${TARGET_IP}:${TARGET_PORT}" &
    done
done
