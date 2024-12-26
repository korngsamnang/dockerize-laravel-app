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

# Ensure the necessary directories exist and adjust permissions
RUN mkdir -p storage/logs bootstrap/cache \
    && chown -R root:root /var/www \
    && chmod -R 775 /var/www/storage /var/www/bootstrap/cache

# Install Laravel dependencies (will create the vendor directory)
RUN composer install --no-dev --optimize-autoloader

# Expose port 9000
EXPOSE 9000

# Start PHP-FPM
CMD ["php-fpm"]
