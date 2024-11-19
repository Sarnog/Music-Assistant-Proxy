worker_processes  1;
pid /var/run/nginx.pid;
error_log /dev/stdout info;
daemon off;

events {
    worker_connections  1024;
}

http {
    access_log              /dev/stdout combined;
    client_max_body_size    4G;
    default_type           application/octet-stream;
    include                /etc/nginx/mime.types;
    keepalive_timeout      65;
    sendfile               on;
    server_tokens          off;
    tcp_nodelay            on;
    tcp_nopush             on;

    map $http_upgrade $connection_upgrade {
        default upgrade;
        ''      close;
    }
    
    server {
        listen 8095 default_server;
        root /dev/null;

        location / {
            proxy_pass ${MUSIC_ASSISTANT_SERVER};
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection $connection_upgrade;
            proxy_http_version 1.1;
        }
    }
}
