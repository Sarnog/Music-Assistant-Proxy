ARG BUILD_FROM=ghcr.io/home-assistant/base:3.19
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install required packages
RUN \
    apk add --no-cache \
        nginx \
        python3 \
        py3-pip \
        py3-aiohttp \
        py3-websockets

# Copy root filesystem
COPY rootfs /

# Make scripts executable
RUN \
    chmod a+x /etc/services.d/proxy/run \
    && chmod a+x /etc/services.d/proxy/finish \
    && chmod a+x /etc/services.d/nginx/run \
    && chmod a+x /etc/services.d/nginx/finish

# Labels
LABEL \
    io.hass.name="Music Assistant Proxy" \
    io.hass.description="Proxy voor Music Assistant met Web Interface" \
    io.hass.type="addon" \
    io.hass.version="1.0.0"
