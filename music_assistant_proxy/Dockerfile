ARG BUILD_FROM
ARG BUILD_VERSION

# Basisimage
FROM $BUILD_FROM

# Labels
LABEL \
    io.hass.version=$BUILD_VERSION \
    io.hass.type="addon" \
    io.hass.name="Music Assistant Proxy"

# Kopieer bestanden
COPY rootfs/ /
COPY icon/music_assistant.ico /data/icon/music_assistant.ico

# Zorg dat scripts uitvoerbaar zijn
RUN chmod +x /etc/services.d/nginx/run /etc/services.d/nginx/finish

# Toegangspoorten
EXPOSE 80

# Startpunt
CMD [ "/init" ]
