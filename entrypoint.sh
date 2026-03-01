#!/bin/sh
# Start ntfy on port 8080 in background
ntfy serve --listen-http :8080 --base-url https://push.florianrolke.com &

# Start nginx in foreground
nginx -g 'daemon off;'
