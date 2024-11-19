FROM python:3.11-alpine

# Install required packages
RUN apk add --no-cache nginx

# Set working directory
WORKDIR /app

# Copy application files
COPY proxy.py .
COPY run.sh .
COPY nginx.conf /etc/nginx/nginx.conf

# Make run.sh executable
RUN chmod a+x /app/run.sh

# Create and activate virtual environment
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Install Python packages
RUN pip install --no-cache-dir websockets==12.0 aiohttp==3.9.1

# Labels
LABEL \
    io.hass.name="Music Assistant Proxy" \
    io.hass.description="Proxy voor Music Assistant met Web Interface" \
    io.hass.type="addon" \
    io.hass.version="1.0.0"

# Command to run
CMD ["/app/run.sh"]
