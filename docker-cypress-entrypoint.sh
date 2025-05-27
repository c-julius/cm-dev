#!/bin/sh
# Entrypoint script to ensure correct permissions for Laravel storage and cache directories
set -e

cd /e2e
npm install

exec "$@"
