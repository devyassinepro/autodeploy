#!/bin/bash

set -e

echo "Starting deployment..."

# Navigate to the project directory
cd /var/www/laravel || { echo "Directory /var/www/laravel not found"; exit 1; }

# Pull the latest changes
git pull origin main

# Install dependencies
COMPOSER_ALLOW_SUPERUSER=1 composer install --no-dev --optimize-autoloader

# Clear and cache configuration
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Run database migrations
php artisan migrate --force

echo "Deployment finished."
