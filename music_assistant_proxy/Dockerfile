ARG BUILD_FROM=ghcr.io/hassio-addons/base:14.3.2
FROM ${BUILD_FROM}

RUN apk add --no-cache \
    nginx \
    gettext

# Ensure the /icon directory is created first
RUN mkdir -p /icon

# Copy the icon file
COPY Music-Assistant-Proxy/music_assistant_proxy/icon/music_assistant.ico /icon/music_assistant.ico

# Set permissions correctly
RUN chmod 755 /icon/music_assistant.ico

RUN chmod a+x /etc/services.d/nginx/run \
    && chmod a+x /etc/services.d/nginx/finish

LABEL \
    io.hass.name="Music Assistant Proxy" \
    io.hass.description="Proxy voor Music Assistant met Web Interface" \
    io.hass.type="addon"
