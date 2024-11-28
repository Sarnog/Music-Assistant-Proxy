ENV SERVER_HOST=${SERVER_HOST}
ENV SERVER_PORT=${SERVER_PORT}

COPY rootfs /
COPY icon/music_assistant.ico /music_assistant_proxy/icon/music_assistant.ico

RUN chmod a+x /etc/services.d/nginx/run \
    && chmod a+x /etc/services.d/nginx/finish
