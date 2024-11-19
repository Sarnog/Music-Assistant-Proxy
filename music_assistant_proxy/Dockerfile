ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base-python:3.11-alpine3.19
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install required packages
RUN \
    apk add --no-cache \
        nginx \
        python3 \
        py3-pip \
        gcc \
        musl-dev \
        python3-dev

# Copy your application
WORKDIR /app
COPY proxy.py .
COPY run.sh .
COPY nginx.conf /etc/nginx/nginx.conf

# Make scripts executable
RUN chmod a+x /app/run.sh

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
    io.hass.version="1.0.0"

# Start the proxy
CMD [ "/app/run.sh" ]
