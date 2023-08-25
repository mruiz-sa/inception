#!/bin/sh

# Instal the core with the env variables .env
wp core install --path=/var/www --url=domain_here \
    --title="inception project" \
    --admin_name=wp_admin_user_here \
    --admin_user=wp_admin_user_here \
    --admin_password=wp_admin_password_here \
    --admin_email=wp_admin_email_here \
    --skip-email --allow-root

# Install a theme
wp theme install inspiro --path=/var/www --activate --allow-root

exec "$@"
