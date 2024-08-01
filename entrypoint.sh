#!/usr/bin/env bash
set -e

# Debugging-Ausgaben für Umgebungsvariablen
echo "DB_HOST: ${DB_HOST:-'not set'}"
echo "DB_PORT: ${DB_PORT:-'not set'}"

# Standardwerte setzen, falls Umgebungsvariablen nicht gesetzt sind
DB_HOST=${DB_HOST:-"truck-signs-db"}
DB_PORT=${DB_PORT:-5432}

# Verwenden der Umgebungsvariablen im Skript
echo "Connecting to database at $DB_HOST:$DB_PORT..."

echo "Waiting for postgres to connect ..."

while ! nc -z $DB_HOST $DB_PORT; do
  sleep 1
done

echo "PostgreSQL is active"

python manage.py collectstatic --noinput
python manage.py makemigrations
python manage.py migrate

if [ "$DJANGO_SUPERUSER_USERNAME" ] && [ "$DJANGO_SUPERUSER_PASSWORD" ] && [ "$DJANGO_SUPERUSER_EMAIL" ]; then
    python manage.py createsuperuser --noinput --username $DJANGO_SUPERUSER_USERNAME --email $DJANGO_SUPERUSER_EMAIL || true
fi


gunicorn truck_signs_designs.wsgi:application --bind 0.0.0.0:8000



echo "Postgresql migrations finished"

python manage.py runserver