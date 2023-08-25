FROM alpine:3.16
#ARGUMENTS FOR THE WP BUILD
ARG DOMAIN_NAME \
    DB_NAME \
    DB_USER \
    DB_PASS \
    WP_ADMIN_USER \
    WP_ADMIN_PASSWORD \
    WP_ADMIN_EMAIL
#INSTALL PHP PACKAGES AND MODIFY WWW.CONF OF PHP
RUN apk update && apk upgrade && apk add --no-cache \
    php8 \
    php8-fpm \
    php8-mysqli \
    php8-json \
    php8-curl \
    php8-dom \
    php8-exif \
    php8-fileinfo \
    php8-mbstring \
    php8-openssl \
    php8-xml \
    php8-zip \
    php8-redis \
    wget \
    unzip && \
    sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" \
      /etc/php8/php-fpm.d/www.conf && \
    sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" \
      /etc/php8/php-fpm.d/www.conf && \
    sed -i "s|;listen.group = nobody|listen.group = nobody|g" \
      /etc/php8/php-fpm.d/www.conf && \
    rm -f /var/cache/apk/*
#INSTALL WP
WORKDIR /var/www
RUN wget https://wordpress.org/latest.zip && \
    unzip latest.zip && \
    cp -rf wordpress/* . && \
    rm -rf wordpress latest.zip
#COPY AND RUN THE SCRIPT THAT CONFIGURES WP
COPY ./requirements/wordpress/conf/wp-config-create.sh .
RUN sh wp-config-create.sh && rm wp-config-create.sh && \
    chmod -R 0777 wp-content/

#COPY AND TRANSFER THE VARIABLES TO THE SCRIPT
COPY ./requirements/wordpress/conf/install.sh .
RUN chmod +x install.sh && \
    sed -i "s|domain_here|${DOMAIN_NAME}|g" install.sh && \
    sed -i "s|wp_admin_user_here|${WP_ADMIN_USER}|g" install.sh && \
    sed -i "s|wp_admin_password_here|${WP_ADMIN_PASSWORD}|g" install.sh && \
    sed -i "s|wp_admin_email_here|${WP_ADMIN_EMAIL}|g" install.sh

#RUN INSTALL.SH AND RUN PHP-FPM DAEMON
CMD ["sh", "-c", "./install.sh && /usr/sbin/php-fpm8 -F"]
