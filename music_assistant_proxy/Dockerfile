ARG BUILD_FROM=ghcr.io/hassio-addons/base:14.3.2
FROM ${BUILD_FROM}

# Install required packages
RUN apk add --no-cache \
    nginx \
    gettext

# Copy files
COPY rootfs /
COPY icon/music_assistant.ico /usr/share/icons/music_assistant.ico

# Permissions for scripts
RUN chmod a+x /etc/services.d/nginx/run \
    && chmod a+x /etc/services.d/nginx/finish

LABEL \
    io.hass.name="Music Assistant Proxy" \
    io.hass.description="Proxy voor Music Assistant met Web Interface" \
    io.hass.type="addon"

CMD [ "/usr/bin/run.sh" ]
