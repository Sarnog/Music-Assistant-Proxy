ARG BUILD_FROM=ghcr.io/hassio-addons/base:14.3.2
FROM ${BUILD_FROM}

RUN apk add --no-cache \
    nginx \
    gettext \
    python3 \
    py3-aiohttp

COPY rootfs /

RUN chmod a+x /etc/services.d/nginx/run \
    && chmod a+x /etc/services.d/nginx/finish \
    && chmod a+x /etc/services.d/ws-bridge/run \
    && chmod a+x /etc/services.d/ws-bridge/finish

LABEL \
    io.hass.name="Music Assistant Proxy" \
    io.hass.description="Proxy voor Music Assistant met Web Interface" \
    io.hass.type="addon"
