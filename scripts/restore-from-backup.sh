#!/bin/bash

echo 'This script OVERWRITES all files in /var/www/data with files from provided archive!'
echo 'Press Ctrl-C in 10s to quit!'
sleep 10
rm -rf /var/www/data/*
tar xz -C /var/www/data -f $1
chown www-data:www-data -R /var/www/data/
