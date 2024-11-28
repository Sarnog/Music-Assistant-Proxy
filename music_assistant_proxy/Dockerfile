# Base image
ARG BUILD_FROM=ghcr.io/hassio-addons/base:14.3.2
FROM ${BUILD_FROM}

# Install required packages
RUN apk add --no-cache \
    nginx \
    gettext

# Copy all necessary files into the container
COPY rootfs /

# Set execute permissions for the 'run' and 'finish' scripts
RUN chmod +x /etc/services.d/nginx/run /etc/services.d/nginx/finish

# Set permissions for the 'icon' folder and all its contents
RUN chmod -R 644 /icon && find /icon -type d -exec chmod 755 {} +

# Set permissions for the 'rootfs' directory
RUN chmod -R 755 /rootfs

# Expose the required port
EXPOSE 8095

# Label information
LABEL \
    io.hass.name="Music Assistant Proxy" \
    io.hass.description="Proxy voor Music Assistant met Web Interface" \
    io.hass.type="addon"
