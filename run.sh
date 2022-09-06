#!/usr/bin/env sh

set -e

# Grab DB config

DB_HOST=${DB_HOST:?}
DB_NAME=${DB_NAME:?}
DB_PASSWORD=${DB_PASSWORD:?}
DB_PORT=${DB_PORT:?}
DB_TIMEOUT=${DB_TIMEOUT:-10}
DB_USER=${DB_USER:?}

# wait for the database to be ready
for i in $(seq $DB_TIMEOUT) ; do
  echo "I am waiting for db to be read => $DB_HOST:$DB_PORT"
  if ! nc -z $DB_HOST $DB_PORT > /dev/null 2>&1; then
    sleep 1
  else
    break
  fi
done

echo "Running migrations"

# For this example I am using PostgreSQL
DB_URL="postgresql://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_NAME}?sslmode=disable"

# Run the migrate cli include inside parent image.
migrate -verbose -path=./migrations -database=$DB_URL "$@"