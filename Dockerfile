ARG BUILD_FROM=ghcr.io/hassio-addons/base:14.3.2
FROM ${BUILD_FROM}

# Install requirements for add-on
RUN \
    apk add --no-cache \
        nginx

# Copy root filesystem
COPY rootfs /

# Make scripts executable
RUN \
    chmod a+x /etc/services.d/nginx/run \
    && chmod a+x /etc/services.d/nginx/finish

# Labels
LABEL \
    io.hass.name="Music Assistant Proxy" \
    io.hass.description="Proxy voor Music Assistant met Web Interface" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Sarnog <info@sarnog.nl>"

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION
