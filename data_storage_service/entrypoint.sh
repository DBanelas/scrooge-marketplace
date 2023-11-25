#!/bin/bash
composer install
php artisan cache:clear
php artisan serve --port=$PORT --host=0.0.0.0 --env=.env