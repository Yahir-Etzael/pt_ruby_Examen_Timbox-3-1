#!/usr/bin/env bash
set -e

cd "${APP_HOME:-/rails}"

if [ -d bin ]; then
  find bin -maxdepth 1 -type f -exec sed -i 's/\r$//' {} \;
  chmod +x bin/* 2>/dev/null || true
fi

rm -f tmp/pids/server.pid

if [ -n "${POSTGRES_HOST:-}" ]; then
  until pg_isready -h "$POSTGRES_HOST" -p "${POSTGRES_PORT:-5432}" -U "${POSTGRES_USER:-postgres}" >/dev/null 2>&1; do
    echo "Waiting for PostgreSQL at ${POSTGRES_HOST}:${POSTGRES_PORT:-5432}..."
    sleep 1
  done
fi

bundle check || bundle install

if [ "${RAILS_ENV:-development}" = "development" ]; then
  bundle exec rails db:prepare
fi

exec "$@"
