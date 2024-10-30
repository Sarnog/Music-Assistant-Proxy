#!/usr/bin/with-contenv sh

# Haal de configuratie-instellingen op uit de Home Assistant configuratie
export MUSIC_ASSISTANT_HOST=$(bashio::config 'music_assistant_host')
export MUSIC_ASSISTANT_PORT=$(bashio::config 'music_assistant_port')

# Start Nginx met de nieuwe omgevingsvariabelen
nginx -g 'daemon off;'
