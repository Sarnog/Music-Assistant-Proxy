FROM python:3.11-alpine

# Install required packages
RUN apk add --no-cache \
    nginx \
    bash

# Set working directory
WORKDIR /app

# Copy application files
COPY proxy.py .
COPY run.sh .
COPY nginx.conf /etc/nginx/nginx.conf
COPY s6-overlay/etc /etc

# Make scripts executable
RUN chmod a+x /app/run.sh && \
    chmod a+x /etc/services.d/proxy/run && \
    chmod a+x /etc/services.d/proxy/finish

# Install Python packages
RUN python -m pip install --no-cache-dir aiohttp websockets

# Labels
LABEL \
    io.hass.name="Music Assistant Proxy" \
    io.hass.description="Proxy voor Music Assistant met Web Interface" \
    io.hass.type="addon" \
    io.hass.version="1.0.0" \
    io.hass.arch="armhf|armv7|aarch64|amd64|i386"

CMD [ "/app/run.sh" ]
