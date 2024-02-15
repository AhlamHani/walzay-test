#!/bin/bash -e

# Wait for Postgres to become available
until PGPASSWORD=$DB_PASSWORD psql -h "$DB_HOST" -U "$DB_USER" -c '\q'; do
  echo "Postgres is unavailable - sleeping"
  sleep 1
done

echo "Postgres is up"

# Wait for Elasticsearch to become available
until curl --output /dev/null --silent --head --fail "$ELASTICSEARCH_URL"; do
  echo "Elasticsearch is unavailable - sleeping"
  sleep 1
done

echo "Elasticsearch is up"

echo "Running migrations and rake tasks"
rails db:prepare
rails db:migrate
rails movies:import
rails reviews:import
rails searchkick:reindex:all

#bundle exec rails server -b 0.0.0.0

"$@"