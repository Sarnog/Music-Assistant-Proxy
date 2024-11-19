ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base-python:3.11-alpine3.19
FROM ${BUILD_FROM}

# Install required packages
RUN apk add --no-cache \
    nginx \
    bash \
    jq \
    curl

# Set working directory
WORKDIR /app

# Copy application files
COPY proxy.py .
COPY run.sh .
COPY nginx.conf /etc/nginx/nginx.conf
COPY s6-overlay/etc /etc

# Make all necessary scripts executable
RUN chmod a+x /app/run.sh && \
    chmod a+x /etc/services.d/proxy/run && \
    chmod a+x /etc/services.d/proxy/finish

# Install Python packages
RUN pip3 install --no-cache-dir websockets==12.0 aiohttp==3.9.1

# Labels
LABEL \
    io.hass.name="Music Assistant Proxy" \
    io.hass.description="Proxy voor Music Assistant met Web Interface" \
    io.hass.type="addon" \
    io.hass.version="1.0.0" \
    io.hass.arch="armhf|armv7|aarch64|amd64|i386"

# Use Home Assistant default entrypoint
CMD [ "/app/run.sh" ]
