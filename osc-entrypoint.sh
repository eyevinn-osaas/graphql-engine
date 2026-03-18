#!/bin/bash
set -e

# OSC Platform entrypoint for Hasura GraphQL Engine (v2)
#
# OSC Platform variables handled:
#   PORT              -> HASURA_GRAPHQL_SERVER_PORT (default: 8080)
#   OSC_HOSTNAME      -> HASURA_GRAPHQL_CORS_DOMAIN
#   DATABASE_URL      -> HASURA_GRAPHQL_METADATA_DATABASE_URL (OSC database service convention)
#
# User-configurable variables:
#   HASURA_GRAPHQL_ADMIN_SECRET           (required) - Admin secret key
#   HASURA_GRAPHQL_ENABLE_CONSOLE         (optional, default: "true")
#   HASURA_GRAPHQL_JWT_SECRET             (optional) - JWT auth config JSON
#   HASURA_GRAPHQL_UNAUTHORIZED_ROLE      (optional) - Role for unauthenticated requests

# Map OSC PORT to Hasura server port
export HASURA_GRAPHQL_SERVER_PORT="${PORT:-${HASURA_GRAPHQL_SERVER_PORT:-8080}}"

# Map OSC_HOSTNAME to CORS domain
if [ -n "$OSC_HOSTNAME" ]; then
  export HASURA_GRAPHQL_CORS_DOMAIN="${HASURA_GRAPHQL_CORS_DOMAIN:-https://${OSC_HOSTNAME}}"
fi

# Map OSC DATABASE_URL to Hasura metadata database URL (OSC database service convention)
if [ -n "$DATABASE_URL" ]; then
  export HASURA_GRAPHQL_METADATA_DATABASE_URL="${HASURA_GRAPHQL_METADATA_DATABASE_URL:-${DATABASE_URL}}"
fi

# Sensible defaults
export HASURA_GRAPHQL_ENABLE_CONSOLE="${HASURA_GRAPHQL_ENABLE_CONSOLE:-true}"
export HASURA_GRAPHQL_ENABLE_TELEMETRY="${HASURA_GRAPHQL_ENABLE_TELEMETRY:-false}"

# Validate required variables
if [ -z "$HASURA_GRAPHQL_METADATA_DATABASE_URL" ]; then
  echo "ERROR: DATABASE_URL (or HASURA_GRAPHQL_METADATA_DATABASE_URL) is required" >&2
  echo "  Provide a PostgreSQL connection string, e.g.:" >&2
  echo "  postgres://user:password@host:5432/dbname" >&2
  exit 1
fi

if [ -z "$HASURA_GRAPHQL_ADMIN_SECRET" ]; then
  echo "ERROR: HASURA_GRAPHQL_ADMIN_SECRET is required" >&2
  exit 1
fi

exec "$@"
