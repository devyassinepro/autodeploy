#!/bin/bash

echo "Starting deployment..."

# Navigate to the project directory
cd /var/www/laravel || exit

# Pull the latest changes
git pull origin main

# Install dependencies
composer install --no-dev --optimize-autoloader

# Clear and cache configuration
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Run database migrations
php artisan migrate --force

echo "Deployment finished."
