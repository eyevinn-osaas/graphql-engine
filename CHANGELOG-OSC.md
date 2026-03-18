# Eyevinn Open Source Cloud - Processing History

## Changelog

- **2026-03-18T13:01:52.807Z**: Project synchronized with upstream by OSaaS Service Builder

- **2026-03-18T13:01:44.751Z**: Project synchronized with upstream by OSaaS Service Builder

# OSC Changelog

All OSC-specific changes to the Hasura GraphQL Engine fork are documented here.

## [1.0.0] - 2026-03-18

### Added
- `Dockerfile.osc` — Docker image built on `hasura/graphql-engine:v2.48.13`
- `osc-entrypoint.sh` — Entrypoint script with OSC platform variable mapping:
  - `PORT` is mapped to `HASURA_GRAPHQL_SERVER_PORT`
  - `OSC_HOSTNAME` is mapped to `HASURA_GRAPHQL_CORS_DOMAIN`
  - `HASURA_GRAPHQL_ENABLE_CONSOLE` defaults to `true`
  - `HASURA_GRAPHQL_ENABLE_TELEMETRY` defaults to `false`
  - Validation for required `HASURA_GRAPHQL_METADATA_DATABASE_URL`
- `README-OSC.md` — OSC-specific documentation
- `CHANGELOG-OSC.md` — This file
