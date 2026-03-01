FROM binwiederhier/ntfy:v2.17.0 AS ntfy

FROM nginx:alpine

# Copy ntfy binary from official image
COPY --from=ntfy /usr/bin/ntfy /usr/bin/ntfy

# Create ntfy data directories
RUN mkdir -p /var/cache/ntfy /var/lib/ntfy /etc/ntfy && \
    chmod 777 /var/cache/ntfy /var/lib/ntfy

# Create branding directory
RUN mkdir -p /usr/share/nginx/html/branding

# Copy nginx config (with sub_filter for CSS injection)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy branding assets
COPY custom.css /usr/share/nginx/html/branding/custom.css
COPY logo.png /usr/share/nginx/html/branding/logo.png

# Copy entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 80
CMD ["/entrypoint.sh"]
