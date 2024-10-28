# Use an official base image
FROM alpine:latest

# Set environment variables
ENV MUSIC_ASSISTANT_HOST=0.0.0.0
ENV MUSIC_ASSISTANT_PORT=8095

# Install necessary packages
RUN apk add --no-cache nginx

# Copy configuration files
COPY nginx.conf /etc/nginx/nginx.conf
COPY run.sh /usr/local/bin/run.sh

# Make the run script executable
RUN chmod +x /usr/local/bin/run.sh

# Expose the port
EXPOSE 8095

# Run the application
CMD ["/usr/local/bin/run.sh"]
