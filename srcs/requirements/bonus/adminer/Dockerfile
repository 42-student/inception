# Use the official Alpine 3.20 image as the base image for a lightweight PHP container
FROM alpine:3.20

# Define a build argument to specify the PHP version, defaulting to 8.2
ARG PHP_VERSION=82

# Update the package index, upgrade existing packages, and install PHP and necessary extensions
# Install PHP version specified by ARG
# PHP common utilities
# PHP session management support
# PHP iconv extension for character encoding conversion
# PHP GD library for image manipulation
# PHP CURL support for HTTP requests
# PHP XML support for XML parsing
# PHP MySQLi extension for MySQL database interaction
# PHP IMAP extension for email handling
# PHP CGI support
# PHP PDO support for database abstraction
# PHP PDO MySQL driver for MySQL database access
# PHP SOAP extension for web services
# PHP POSIX support for Unix-like systems
# PHP GetText extension for localization
# PHP LDAP extension for directory services
# PHP CTYPE extension for character classification
# PHP DOM extension for document object model manipulation
# PHP SimpleXML extension for XML parsing
# Install wget for downloading files
RUN apk update && apk upgrade && apk add --no-cache \
    php${PHP_VERSION} \
    php${PHP_VERSION}-common \
    php${PHP_VERSION}-session \
    php${PHP_VERSION}-iconv \
    php${PHP_VERSION}-gd \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-mysqli \
    php${PHP_VERSION}-imap \
    php${PHP_VERSION}-cgi \
    php${PHP_VERSION}-pdo \
    php${PHP_VERSION}-pdo_mysql \
    php${PHP_VERSION}-soap \
    php${PHP_VERSION}-posix \
    php${PHP_VERSION}-gettext \
    php${PHP_VERSION}-ldap \
    php${PHP_VERSION}-ctype \
    php${PHP_VERSION}-dom \
    php${PHP_VERSION}-simplexml \
    wget

# Create a symbolic link to use `php` as the command, pointing to php82
RUN ln -s /usr/bin/php82 /usr/bin/php

# Set the working directory inside the container to /var/www
WORKDIR /var/www

# Download the Adminer PHP file, rename it to index.php, and set the correct ownership
RUN wget https://github.com/vrana/adminer/releases/download/v4.17.1/adminer-4.17.1.php && \
    mv adminer-4.17.1.php index.php && chown -R root:root /var/www/

# Expose port 8080 to access the web application
EXPOSE 8080

# Define the default command to start PHP's built-in web server on port 8080 and serve the /var/www directory
CMD [ "php", "-S", "[::]:8080", "-t", "/var/www" ]
