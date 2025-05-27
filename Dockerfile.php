# Use the official PHP 8.4 FPM image as the base
FROM php:8.4-fpm

# Install Xdebug and other dependencies
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && apt-get update && apt-get install -y zip unzip git \
    && docker-php-ext-install pdo_mysql \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install Node.js and npm for frontend build
RUN apt-get update \
    && apt-get install -y curl \
    && curl -fsSL https://deb.nodesource.com/setup_23.x -o /tmp/nodesource_setup.sh \
    && chmod +x /tmp/nodesource_setup.sh && /tmp/nodesource_setup.sh \
    && apt-get install -y nodejs

# Set working directory
WORKDIR /var/www/html

# Copy entrypoint script
COPY docker-app-entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
