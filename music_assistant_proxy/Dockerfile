ARG BUILD_FROM=ghcr.io/hassio-addons/base:14.3.2
FROM ${BUILD_FROM}

RUN apk add --no-cache \
    nginx \
    gettext

# Copy the necessary files and folders, including the icon
COPY rootfs /

# Set permissions for the /icon directory only after the copy command
RUN mkdir -p /icon && cp -R /rootfs/icon/* /icon && chmod -R 755 /icon

RUN chmod a+x /etc/services.d/nginx/run \
    && chmod a+x /etc/services.d/nginx/finish

LABEL \
    io.hass.name="Music Assistant Proxy" \
    io.hass.description="Proxy voor Music Assistant met Web Interface" \
    io.hass.type="addon"
