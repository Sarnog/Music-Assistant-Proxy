ARG BUILD_FROM
FROM $BUILD_FROM

# Install required packages
RUN apk add --no-cache python3 py3-pip nginx

# Copy your application
WORKDIR /app
COPY proxy.py .
COPY run.sh .
COPY nginx.conf /etc/nginx/nginx.conf

# Make scripts executable
RUN chmod a+x /app/run.sh

# Install Python requirements
RUN pip3 install websockets aiohttp

CMD [ "/app/run.sh" ]
