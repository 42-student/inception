# Use Alpine Linux 3.20 as the base image (lightweight and secure)
FROM alpine:3.20

# Define build arguments for PHP version and database credentials
ARG PHP_VERSION=82 \
    DB_NAME \
    DB_USER \
    DB_PASS

# Update package list, upgrade system, and install required PHP extensions & utilities
# PHP core package
# PHP command-line interface
# PHP FastCGI Process Manager
# MySQL support for PHP
# JSON support for PHP
# cURL support
# DOM extension for XML parsing
# EXIF metadata support
# File info extension
# Multibyte string support
# OpenSSL support
# XML parsing support
# ZIP extension
# Redis caching support
# Utility to download files
# Utility to unzip files
# Update PHP-FPM configuration to listen on all interfaces
# Clean up cache to reduce image size
RUN apk update && apk upgrade && apk add --no-cache \
    php${PHP_VERSION} \
    php${PHP_VERSION}-cli \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-mysqli \
    php${PHP_VERSION}-json \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-dom \
    php${PHP_VERSION}-exif \
    php${PHP_VERSION}-fileinfo \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-openssl \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-zip \
    php${PHP_VERSION}-redis \
    wget \
    unzip && \
    sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" \
      /etc/php82/php-fpm.d/www.conf && \
    sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" \
      /etc/php82/php-fpm.d/www.conf && \
    sed -i "s|;listen.group = nobody|listen.group = nobody|g" \
      /etc/php82/php-fpm.d/www.conf && \
    rm -f /var/cache/apk/*

# Create a symbolic link to make PHP globally accessible
RUN ln -s /usr/bin/php82 /usr/bin/php

# Set the working directory to /var/www
WORKDIR /var/www

# Download and extract the latest version of WordPress
RUN wget https://wordpress.org/latest.zip && \
    unzip latest.zip && \
    cp -rf wordpress/* . && \
    rm -rf wordpress latest.zip  # Remove unnecessary files after extraction

# Copy and execute WordPress configuration script
# Ensure WordPress content directory is writable
COPY ./requirements/wordpress/conf/wp-config-create.sh .
RUN sh wp-config-create.sh && rm wp-config-create.sh && \
    chmod -R 0777 wp-content/

# Start PHP-FPM in foreground mode to keep the container running
CMD ["/usr/sbin/php-fpm82", "-F"]
