# Use the official PHP image with FPM support
FROM php:8.1-fpm

# Install system dependencies and PHP extensions
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    git \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd zip pdo pdo_mysql

# Install Composer globally
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set working directory
WORKDIR /var/www

# Copy application files into the container
COPY . .

# Copy entrypoint script if you want dynamic .env generation (optional)
# COPY entrypoint.sh /usr/local/bin/entrypoint.sh
# RUN chmod +x /usr/local/bin/entrypoint.sh

# Set permissions for the application files
RUN chown -R www-data:www-data /var/www

# Install Laravel dependencies (will create the vendor directory)
RUN composer install --no-dev --optimize-autoloader

# Expose port 9000
EXPOSE 9000

# Set the entrypoint (optional, if you use entrypoint.sh)
# ENTRYPOINT ["entrypoint.sh"]

# Start PHP-FPM
CMD ["php-fpm"]
