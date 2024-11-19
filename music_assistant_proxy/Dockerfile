ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base-python:3.11-alpine3.19
FROM ${BUILD_FROM}

# Install required packages
RUN \
    apk add --no-cache \
        nginx \
        py3-pip \
        gcc \
        musl-dev \
        python3-dev

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

# Create requirements.txt
RUN echo "websockets==12.0" > requirements.txt && \
    echo "aiohttp==3.9.1" >> requirements.txt

# Install Python requirements
RUN pip3 install --no-cache-dir -r requirements.txt

# Labels
LABEL \
    io.hass.name="Music Assistant Proxy" \
    io.hass.description="Proxy voor Music Assistant met Web Interface" \
    io.hass.type="addon" \
    io.hass.version="1.0.0" \
    io.hass.arch="armhf|armv7|aarch64|amd64|i386"

CMD [ "/app/run.sh" ]
