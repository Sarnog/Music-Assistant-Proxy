ARG BUILD_FROM=ghcr.io/hassio-addons/base:14.3.2
FROM ${BUILD_FROM}

# Install requirements for add-on
RUN \
    apk add --no-cache \
        nginx \
        gettext

# Copy files
COPY nginx.conf.gtpl /etc/nginx/templates/
COPY entrypoint.sh /
RUN chmod a+x /entrypoint.sh

# Labels
LABEL \
    io.hass.name="Music Assistant Proxy" \
    io.hass.description="Proxy voor Music Assistant met Web Interface" \
    io.hass.type="addon"

ENTRYPOINT [ "/entrypoint.sh" ]
CMD ["nginx", "-g", "daemon off;"]
