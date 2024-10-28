FROM homeassistant/amd64-base:latest

RUN apk add --no-cache nginx curl

COPY run.sh /usr/bin/run
COPY nginx.conf /etc/nginx/nginx.conf
RUN chmod +x /usr/bin/run

CMD [ "/usr/bin/run" ]
