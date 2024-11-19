ARG BUILD_FROM=ghcr.io/hassio-addons/base:14.3.2
FROM ${BUILD_FROM}

# Install required packages
RUN \
    apk add --no-cache \
        nginx=1.24.0-r14 \
        python3=3.11.8-r0 \
        py3-pip=23.3.1-r0 \
        py3-aiohttp=3.8.6-r0 \
        py3-websockets=10.4-r3

# Copy root filesystem
COPY rootfs /

# Setup base
RUN \
    chmod a+x /etc/s6-overlay/s6-rc.d/*/run \
    && chmod a+x /etc/s6-overlay/s6-rc.d/*/finish

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Sarnog" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="Home Assistant Add-ons" \
    org.opencontainers.image.authors="Sarnog" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://github.com/Sarnog" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}
