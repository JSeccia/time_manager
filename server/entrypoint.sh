#!/bin/sh
set -e
# # Docker entrypoint script.
export DATABASE_URL=ecto://$PGUSER:$PGPASSWORD@$PGHOST/$PGDATABASE
export SECRET_KEY_BASE=SMN1ScMRX7A8UaQXZRtsXRA4UPgHbFf9cSH/65FgyyCiS/cX7/738qEscRZQxvml
# Wait until Postgres is ready.
while ! pg_isready -q -h $PGHOST -p $PGPORT -U $PGUSER
do
  echo "$(date) - waiting for database to start"
  sleep 2
done

# Create, migrate, and seed database if it doesn't exist.
if [ ! `psql -Atqc "\\list $PGDATABASE"` ]; then
  echo "Database $PGDATABASE does not exist. Creating..."
  createdb -E UTF8 $PGDATABASE -l en_US.UTF-8 -T template0
  mix ecto.migrate
  mix run priv/repo/seeds.exs
  echo "Database $PGDATABASE created."
fi
exec mix phx.server