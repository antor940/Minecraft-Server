# Use a base image with PHP and required extensions
FROM php:7.4-apache

# Install necessary packages
RUN apt-get update && \
    apt-get install -y \
    git \
    unzip \
    libzip-dev \
    libpng-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libonig-dev \
    libcurl4-openssl-dev

# Enable Apache modules
RUN a2enmod rewrite && \
    a2enmod headers

# Install PHP extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql zip gd opcache

# Clone PufferPanel repository
RUN git clone --branch v1.4.0 --depth 1 https://github.com/PufferPanel/PufferPanel.git /var/www/html

# Set up permissions
RUN chown -R www-data:www-data /var/www/html

# Expose Apache port
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
