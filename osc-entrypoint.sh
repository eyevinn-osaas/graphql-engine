#!/bin/bash
set -e

# OSC Platform entrypoint for Hasura GraphQL Engine
#
# OSC Platform variables handled:
#   PORT              -> HASURA_GRAPHQL_SERVER_PORT (default: 8080)
#   OSC_HOSTNAME      -> HASURA_GRAPHQL_CORS_DOMAIN (sets allowed CORS domain)
#
# User-configurable variables:
#   HASURA_GRAPHQL_METADATA_DATABASE_URL  (required) - PostgreSQL connection string for metadata
#   HASURA_GRAPHQL_DATABASE_URL           (optional) - PostgreSQL connection string for data source
#   HASURA_GRAPHQL_ADMIN_SECRET           (required) - Admin secret key
#   HASURA_GRAPHQL_ENABLE_CONSOLE         (optional, default: "true") - Enable web console
#   HASURA_GRAPHQL_ENABLE_TELEMETRY       (optional, default: "false") - Disable telemetry

# Map OSC PORT to Hasura server port
if [ -n "$PORT" ]; then
  export HASURA_GRAPHQL_SERVER_PORT="${PORT}"
else
  export HASURA_GRAPHQL_SERVER_PORT="${HASURA_GRAPHQL_SERVER_PORT:-8080}"
fi

# Map OSC_HOSTNAME to CORS domain so the console and API are accessible
if [ -n "$OSC_HOSTNAME" ]; then
  export HASURA_GRAPHQL_CORS_DOMAIN="${HASURA_GRAPHQL_CORS_DOMAIN:-https://${OSC_HOSTNAME}}"
fi

# Enable console by default if not set
export HASURA_GRAPHQL_ENABLE_CONSOLE="${HASURA_GRAPHQL_ENABLE_CONSOLE:-true}"

# Disable telemetry by default
export HASURA_GRAPHQL_ENABLE_TELEMETRY="${HASURA_GRAPHQL_ENABLE_TELEMETRY:-false}"

# Validate required environment variables
if [ -z "$HASURA_GRAPHQL_METADATA_DATABASE_URL" ]; then
  echo "ERROR: HASURA_GRAPHQL_METADATA_DATABASE_URL is required" >&2
  echo "  Set this to a PostgreSQL connection string, e.g.:" >&2
  echo "  postgres://user:password@host:5432/dbname" >&2
  exit 1
fi

if [ -z "$HASURA_GRAPHQL_ADMIN_SECRET" ]; then
  echo "WARNING: HASURA_GRAPHQL_ADMIN_SECRET is not set. The admin API will be unprotected." >&2
fi

exec "$@"
