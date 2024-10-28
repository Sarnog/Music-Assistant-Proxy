# Use an Alpine base image for a lightweight container
FROM alpine:latest

# Install required packages
RUN apk add --no-cache nginx bash

# Copy the configuration files
COPY run.sh /run.sh
RUN chmod +x /run.sh

# Configure entry point
ENTRYPOINT [ "/run.sh" ]
