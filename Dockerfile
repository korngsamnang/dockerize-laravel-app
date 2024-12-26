# Stage 1: Build dependencies
FROM composer:2 AS builder

# Set the working directory for the builder stage
WORKDIR /app

# Copy the composer files (composer.json and composer.lock) and install dependencies
COPY composer.json composer.lock ./
RUN composer install --no-dev --optimize-autoloader

# Stage 2: Build the application image
FROM php:8.1-fpm

# Install system dependencies
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

# Copy the entire application code into the container
COPY . .

# Debug: List files to confirm `artisan` and `composer.json` exist
RUN ls -l /var/www && ls -l /var/www/artisan

# Copy the vendor directory from the builder stage
COPY --from=builder /app/vendor ./vendor

# Run Composer install to ensure dependencies are installed (if not already done in the builder stage)
RUN composer install --no-dev --optimize-autoloader || { echo "Composer install failed"; exit 1; }

# Set permissions for Laravel
RUN chmod -R 775 /var/www/storage /var/www/bootstrap/cache \
    && chown -R www-data:www-data /var/www \
    || { echo "Failed to set permissions"; exit 1; }

# Expose port 9000
EXPOSE 9000

# Start PHP-FPM
CMD ["php-fpm"]
