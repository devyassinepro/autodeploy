#!/bin/bash
TARGET="/var/www/laravel"
GIT_DIR="/home/user/repo/ecopy.git"
BRANCH="main"

while read oldrev newrev ref
do
    if [ "$ref" = "refs/heads/$BRANCH" ];
    then
        echo "Deploying branch $BRANCH to production..."
        git --work-tree=$TARGET --git-dir=$GIT_DIR checkout -f
        
        # Run any deployment tasks here
        cd $TARGET
        composer install --no-dev --prefer-dist
        php artisan migrate --force
        php artisan cache:clear
        php artisan config:cache
        php artisan route:cache
        php artisan view:cache
        echo "Deployment finished."
    fi
done
