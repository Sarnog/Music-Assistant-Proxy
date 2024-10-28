FROM alpine:latest

# Install nginx
RUN apk add --no-cache nginx bash

# Copy the custom nginx configuration file
COPY nginx.conf /etc/nginx/nginx.conf

# Copy the run script and make it executable
COPY run.sh /run.sh
RUN chmod +x /run.sh

# Run the entrypoint script
ENTRYPOINT [ "/run.sh" ]
