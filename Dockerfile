# Use an official PHP runtime as a parent image
FROM php:7.4-apache

# Install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    git \
    zip \
    unzip \
    openssl

# Enable necessary PHP extensions
RUN docker-php-ext-install pdo pdo_mysql

# Download and install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set the working directory in the container to /var/www/html
WORKDIR /var/www/html

# Copy the PufferPanel source code into the container
RUN git clone https://github.com/PufferPanel/PufferPanel .

# Install PufferPanel dependencies
RUN composer install

# Copy the PufferPanel configuration file into the container
COPY pufferpanel.json /var/www/html

# Expose port 80
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
