#!/bin/sh
# Entrypoint script to ensure correct permissions for Laravel storage and cache directories
set -e

# Build frontend if present and not already built
echo "Building frontend..."
cd /frontend
npm install
npm run build
cd -

# Set permissions for storage and bootstrap/cache
mkdir -p /var/www/html/storage /var/www/html/bootstrap/cache
chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache
chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

cd /var/www/html
composer install --no-interaction --optimize-autoloader
# Generate .env file if it does not exist
if [ ! -f .env ]; then
    echo "Generating .env file..."
    cp .env.example .env
    echo "Generating application key..."
    php artisan key:generate
    echo "Generating JWT secret..."
    php artisan jwt:secret -f
fi
php artisan migrate
php artisan db:seed || :

echo " =====> Application is ready to run <====== "

exec "$@"
