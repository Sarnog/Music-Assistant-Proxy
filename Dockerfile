ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base-python:3.11-alpine3.19
FROM ${BUILD_FROM}

# Install required packages
RUN \
    apk add --no-cache \
        nginx \
        py3-aiohttp \
        py3-websockets

# Copy root filesystem
WORKDIR /
COPY rootfs /

# Make scripts executable
RUN chmod a+x /etc/s6-overlay/s6-rc.d/*/run \
    && chmod a+x /etc/s6-overlay/s6-rc.d/*/finish

# Labels
LABEL \
    io.hass.name="Music Assistant Proxy" \
    io.hass.description="Proxy voor Music Assistant met Web Interface" \
    io.hass.type="addon" \
    io.hass.version="1.0.0"
