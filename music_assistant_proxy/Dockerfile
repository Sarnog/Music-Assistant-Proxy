ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base-python:3.11-alpine3.19
FROM ${BUILD_FROM}

# Install required packages
RUN \
    apk add --no-cache \
        nginx

# Copy your application
WORKDIR /app
COPY proxy.py .
COPY run.sh .
COPY nginx.conf /etc/nginx/nginx.conf

# Make scripts executable
RUN chmod a+x /app/run.sh

# Install Python requirements with verbose output
RUN pip3 install --no-cache-dir --verbose websockets aiohttp

LABEL \
    io.hass.name="Music Assistant Proxy" \
    io.hass.description="Proxy voor Music Assistant met Web Interface" \
    io.hass.type="addon" \
    io.hass.version="1.0.0"

CMD [ "/app/run.sh" ]
