ARG BUILD_FROM=ghcr.io/hassio-addons/base:14.3.2
FROM ${BUILD_FROM}

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

# Setup base
RUN \
    chmod a+x /etc/s6-overlay/s6-rc.d/*/run \
    && chmod a+x /etc/s6-overlay/s6-rc.d/*/finish

# Labels
LABEL \
    io.hass.name="Music Assistant Proxy" \
    io.hass.description="Proxy voor Music Assistant met Web Interface" \
    io.hass.arch="amd64" \
    io.hass.type="addon" \
    io.hass.version="1.0.0" \
    maintainer="Sarnog" \
    org.opencontainers.image.title="Music Assistant Proxy" \
    org.opencontainers.image.description="Proxy voor Music Assistant met Web Interface" \
    org.opencontainers.image.vendor="Home Assistant Add-ons" \
    org.opencontainers.image.authors="Sarnog" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://github.com/Sarnog" \
    org.opencontainers.image.source="https://github.com/Sarnog/Music-Assistant-Proxy" \
    org.opencontainers.image.documentation="https://github.com/Sarnog/Music-Assistant-Proxy/blob/main/README.md" \
    org.opencontainers.image.version="1.0.0"

# Start the proxy
CMD [ "/app/run.sh" ]
