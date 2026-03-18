# Hasura GraphQL Engine on Eyevinn Open Source Cloud

This fork adds OSC containerization artifacts to [Hasura GraphQL Engine](https://github.com/hasura/graphql-engine), enabling it to run on the [Eyevinn Open Source Cloud](https://www.osaas.io) platform.

## What is Hasura?

Hasura GraphQL Engine is a blazing-fast GraphQL server that gives you instant, realtime GraphQL APIs over PostgreSQL and other databases, with fine-grained access control and webhook-based event triggers.

## OSC Artifacts

- `Dockerfile.osc` — Docker image based on the official `hasura/graphql-engine` image
- `osc-entrypoint.sh` — Entrypoint script that maps OSC platform variables to Hasura configuration

## Required Environment Variables

| Variable | Description | Required |
|----------|-------------|----------|
| `HASURA_GRAPHQL_METADATA_DATABASE_URL` | PostgreSQL connection string for Hasura metadata storage | Yes |
| `HASURA_GRAPHQL_ADMIN_SECRET` | Secret key to secure the admin API and console | Yes |
| `HASURA_GRAPHQL_ENABLE_CONSOLE` | Enable the Hasura web console (default: `true`) | No |

## OSC Platform Mapping

| OSC Variable | Mapped To | Description |
|--------------|-----------|-------------|
| `PORT` | `HASURA_GRAPHQL_SERVER_PORT` | HTTP port to bind to |
| `OSC_HOSTNAME` | `HASURA_GRAPHQL_CORS_DOMAIN` | Public hostname for CORS configuration |

## Quick Start

```bash
docker run -p 8080:8080 \
  -e HASURA_GRAPHQL_METADATA_DATABASE_URL="postgres://user:password@host:5432/dbname" \
  -e HASURA_GRAPHQL_ADMIN_SECRET="your-secret" \
  -e PORT=8080 \
  osc-graphql-engine:dev graphql-engine serve
```

## Original Project

See [hasura/graphql-engine](https://github.com/hasura/graphql-engine) for full documentation, changelog, and contribution guidelines.

## License

Apache-2.0 — see [LICENSE](LICENSE)
